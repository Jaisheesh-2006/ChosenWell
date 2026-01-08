package db

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"os"
	"strings"
	"sync"
	"time"

	"github.com/lib/pq"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/types"
)

// =====================
// IN-MEMORY CACHE
// =====================

type cacheEntry struct {
	data      interface{}
	expiresAt time.Time
}

type cache struct {
	mu      sync.RWMutex
	entries map[string]cacheEntry
}

func newCache() *cache {
	return &cache{entries: make(map[string]cacheEntry)}
}

func (c *cache) get(key string) (interface{}, bool) {
	c.mu.RLock()
	defer c.mu.RUnlock()
	entry, ok := c.entries[key]
	if !ok || time.Now().After(entry.expiresAt) {
		return nil, false
	}
	return entry.data, true
}

func (c *cache) set(key string, data interface{}, ttl time.Duration) {
	c.mu.Lock()
	defer c.mu.Unlock()
	c.entries[key] = cacheEntry{data: data, expiresAt: time.Now().Add(ttl)}
}

func (c *cache) delete(key string) {
	c.mu.Lock()
	defer c.mu.Unlock()
	delete(c.entries, key)
}

// =====================
// REPOSITORY
// =====================

// Repository handles database operations with caching and logging
type Repository struct {
	db    *sql.DB
	cache *cache
}

// New creates a new database repository
func New() (*Repository, error) {
	connStr := os.Getenv("DATABASE_URL")
	if connStr == "" {
		connStr = "postgresql://healthuser:healthpass@localhost:5432/healthiswealth?sslmode=disable"
	}

	// Add binary_parameters=yes for better Neon/PgBouncer compatibility
	if !strings.Contains(connStr, "binary_parameters") {
		if strings.Contains(connStr, "?") {
			connStr += "&binary_parameters=yes"
		} else {
			connStr += "?binary_parameters=yes"
		}
	}

	// Log connection (hide password)
	if idx := strings.Index(connStr, "@"); idx > 0 {
		log.Printf("Connecting to database: ...%s", connStr[idx:])
	}

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, fmt.Errorf("failed to open database: %w", err)
	}

	// Configure connection pool - optimized for serverless DB
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(2)
	db.SetConnMaxLifetime(3 * time.Minute)
	db.SetConnMaxIdleTime(1 * time.Minute)

	// Verify connection with longer timeout
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	if err := db.PingContext(ctx); err != nil {
		return nil, fmt.Errorf("failed to ping database: %w", err)
	}

	log.Println("Database connection established successfully")
	return &Repository{db: db, cache: newCache()}, nil
}

// Close closes the database connection
func (r *Repository) Close() error {
	return r.db.Close()
}

// logQuery logs query execution time for debugging
func logQuery(name string, start time.Time, rowCount int) {
	duration := time.Since(start)
	if duration > 500*time.Millisecond {
		log.Printf("⚠️ SLOW QUERY [%s]: %v (%d rows)", name, duration, rowCount)
	} else {
		log.Printf("✓ Query [%s]: %v (%d rows)", name, duration, rowCount)
	}
}

// =====================
// CATEGORIES
// =====================

// GetCategories returns all active categories (CACHED for 5 minutes)
func (r *Repository) GetCategories(ctx context.Context) ([]types.CategorySummary, error) {
	cacheKey := "categories:all"

	// Check cache first
	if cached, ok := r.cache.get(cacheKey); ok {
		log.Println("Cache HIT: categories")
		return cached.([]types.CategorySummary), nil
	}

	start := time.Now()
	query := `
		SELECT slug, title, COALESCE(description, '') as description
		FROM categories
		WHERE status = 'active'
		ORDER BY title
	`

	rows, err := r.db.QueryContext(ctx, query)
	if err != nil {
		return nil, fmt.Errorf("failed to query categories: %w", err)
	}
	defer rows.Close()

	var categories []types.CategorySummary
	for rows.Next() {
		var c types.CategorySummary
		if err := rows.Scan(&c.Slug, &c.Title, &c.Description); err != nil {
			return nil, fmt.Errorf("failed to scan category: %w", err)
		}
		categories = append(categories, c)
	}

	logQuery("GetCategories", start, len(categories))

	// Cache for 5 minutes
	r.cache.set(cacheKey, categories, 5*time.Minute)

	return categories, rows.Err()
}

// GetCategory returns a category by slug with its products (CACHED for 2 minutes)
func (r *Repository) GetCategory(ctx context.Context, slug string) (*types.Category, error) {
	cacheKey := fmt.Sprintf("category:%s", slug)

	// Check cache first
	if cached, ok := r.cache.get(cacheKey); ok {
		log.Printf("Cache HIT: category/%s", slug)
		return cached.(*types.Category), nil
	}

	start := time.Now()
	query := `
		SELECT slug, title, COALESCE(long_description, '') as long_description, 
		       COALESCE(criteria, '{}') as criteria
		FROM categories
		WHERE slug = $1 AND status = 'active'
	`

	var c types.Category
	var criteriaArr []string

	err := r.db.QueryRowContext(ctx, query, slug).Scan(
		&c.Slug, &c.Title, &c.LongDescription, pq.Array(&criteriaArr),
	)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, fmt.Errorf("failed to query category: %w", err)
	}

	c.Criteria = types.CategoryCriteria{MustHave: criteriaArr}
	c.CriteriaContent = c.LongDescription

	logQuery("GetCategory", start, 1)

	// Get products for this category - use optimized single query
	products, err := r.GetProductsOptimized(ctx, slug, 100)
	if err != nil {
		return nil, fmt.Errorf("failed to get category products: %w", err)
	}
	c.CuratedProducts = products

	// Cache for 2 minutes
	r.cache.set(cacheKey, &c, 2*time.Minute)

	return &c, nil
}

// =====================
// PRODUCTS - OPTIMIZED (Fixed N+1 queries)
// =====================

// GetProductsOptimized fetches products with tags in a SINGLE query (no N+1)
func (r *Repository) GetProductsOptimized(ctx context.Context, category string, limit int) ([]types.ProductSummary, error) {
	start := time.Now()

	// Single query with all tags aggregated
	query := `
		SELECT 
			p.id, p.slug, p.name, p.brand, p.image_url, p.score, 
			p.short_reason, p.price_tier, p.usage_pattern,
			COALESCE(
				(SELECT array_agg(concern_code) FROM product_primary_concerns WHERE product_id = p.id),
				'{}'
			) AS concerns,
			COALESCE(
				(SELECT array_agg(philosophy_code) FROM product_philosophy_tags WHERE product_id = p.id),
				'{}'
			) AS philosophies
		FROM products p
		WHERE p.status = 'active' AND p.category_slug = $1
		ORDER BY p.score DESC
		LIMIT $2
	`

	rows, err := r.db.QueryContext(ctx, query, category, limit)
	if err != nil {
		return nil, fmt.Errorf("failed to query products: %w", err)
	}
	defer rows.Close()

	var products []types.ProductSummary
	for rows.Next() {
		var p types.ProductSummary
		var imageURL, priceTier, usagePattern sql.NullString
		var concerns, philosophies []string

		if err := rows.Scan(&p.ID, &p.Slug, &p.Name, &p.Brand, &imageURL, &p.Score,
			&p.ShortReason, &priceTier, &usagePattern,
			pq.Array(&concerns), pq.Array(&philosophies)); err != nil {
			return nil, fmt.Errorf("failed to scan product: %w", err)
		}

		if imageURL.Valid {
			p.ImageURL = imageURL.String
		}
		if priceTier.Valid {
			p.BudgetTier = priceTier.String
		}

		// Set tags directly from query (no additional DB calls!)
		p.Tags = &types.ProductTags{
			Concern:    concerns,
			Philosophy: philosophies,
			Budget:     priceTier.String,
			Usage:      []string{usagePattern.String},
		}

		products = append(products, p)
	}

	logQuery("GetProductsOptimized", start, len(products))
	return products, rows.Err()
}

// ProductFilters contains filter parameters for product queries
type ProductFilters struct {
	Category   string
	Concern    []string
	Philosophy []string
	Budget     string
	Usage      []string
	SortBy     string
	Order      string
	Page       int
	Limit      int
}

// GetProducts returns filtered products (CACHED for 1 minute)
func (r *Repository) GetProducts(ctx context.Context, filters ProductFilters) (*types.ProductListResponse, error) {
	// Generate cache key
	cacheKey := fmt.Sprintf("products:%s:%d:%d", filters.Category, filters.Page, filters.Limit)

	// Check cache for unfiltered requests
	if filters.Category != "" && len(filters.Concern) == 0 && len(filters.Philosophy) == 0 && filters.Budget == "" {
		if cached, ok := r.cache.get(cacheKey); ok {
			log.Printf("Cache HIT: products/%s", filters.Category)
			return cached.(*types.ProductListResponse), nil
		}
	}

	start := time.Now()

	// Set defaults
	if filters.Limit == 0 {
		filters.Limit = 20
	}
	if filters.Page == 0 {
		filters.Page = 1
	}
	offset := (filters.Page - 1) * filters.Limit

	// Optimized single query with tags included
	query := `
		SELECT DISTINCT 
			p.id, p.slug, p.name, p.brand, p.image_url, p.score, 
			p.short_reason, p.price_tier, p.usage_pattern,
			COALESCE(
				(SELECT array_agg(concern_code) FROM product_primary_concerns WHERE product_id = p.id),
				'{}'
			) AS concerns,
			COALESCE(
				(SELECT array_agg(philosophy_code) FROM product_philosophy_tags WHERE product_id = p.id),
				'{}'
			) AS philosophies
		FROM products p
		LEFT JOIN product_primary_concerns pc ON p.id = pc.product_id
		LEFT JOIN product_philosophy_tags pt ON p.id = pt.product_id
		WHERE p.status = 'active'
	`
	args := []interface{}{}
	argIdx := 1

	if filters.Category != "" {
		query += fmt.Sprintf(" AND p.category_slug = $%d", argIdx)
		args = append(args, filters.Category)
		argIdx++
	}

	if len(filters.Concern) > 0 {
		query += fmt.Sprintf(" AND pc.concern_code = ANY($%d)", argIdx)
		args = append(args, pq.Array(filters.Concern))
		argIdx++
	}

	if len(filters.Philosophy) > 0 {
		query += fmt.Sprintf(" AND pt.philosophy_code = ANY($%d)", argIdx)
		args = append(args, pq.Array(filters.Philosophy))
		argIdx++
	}

	if filters.Budget != "" {
		query += fmt.Sprintf(" AND p.price_tier = $%d", argIdx)
		args = append(args, filters.Budget)
		argIdx++
	}

	if len(filters.Usage) > 0 {
		query += fmt.Sprintf(" AND p.usage_pattern = ANY($%d)", argIdx)
		args = append(args, pq.Array(filters.Usage))
		argIdx++
	}

	// Sorting
	switch filters.SortBy {
	case "name":
		query += " ORDER BY p.name"
	case "brand":
		query += " ORDER BY p.brand"
	default:
		query += " ORDER BY p.score DESC"
	}

	if filters.Order == "asc" {
		query += " ASC"
	}

	query += fmt.Sprintf(" LIMIT $%d OFFSET $%d", argIdx, argIdx+1)
	args = append(args, filters.Limit, offset)

	rows, err := r.db.QueryContext(ctx, query, args...)
	if err != nil {
		return nil, fmt.Errorf("failed to query products: %w", err)
	}
	defer rows.Close()

	var products []types.ProductSummary
	for rows.Next() {
		var p types.ProductSummary
		var imageURL, priceTier, usagePattern sql.NullString
		var concerns, philosophies []string

		if err := rows.Scan(&p.ID, &p.Slug, &p.Name, &p.Brand, &imageURL, &p.Score,
			&p.ShortReason, &priceTier, &usagePattern,
			pq.Array(&concerns), pq.Array(&philosophies)); err != nil {
			return nil, fmt.Errorf("failed to scan product: %w", err)
		}

		if imageURL.Valid {
			p.ImageURL = imageURL.String
		}
		if priceTier.Valid {
			p.BudgetTier = priceTier.String
		}

		// Tags included in query - NO additional DB calls!
		p.Tags = &types.ProductTags{
			Concern:    concerns,
			Philosophy: philosophies,
			Budget:     priceTier.String,
			Usage:      []string{usagePattern.String},
		}

		products = append(products, p)
	}

	// Get total count (simplified)
	total := len(products)
	if filters.Limit > 0 && len(products) == filters.Limit {
		// Only count if we hit the limit (pagination needed)
		countQuery := `SELECT COUNT(DISTINCT p.id) FROM products p WHERE p.status = 'active'`
		if filters.Category != "" {
			countQuery += fmt.Sprintf(" AND p.category_slug = '%s'", filters.Category)
		}
		r.db.QueryRowContext(ctx, countQuery).Scan(&total)
	}

	logQuery("GetProducts", start, len(products))

	result := &types.ProductListResponse{
		Products: products,
		Total:    total,
	}

	// Cache unfiltered category results for 1 minute
	if filters.Category != "" && len(filters.Concern) == 0 && len(filters.Philosophy) == 0 && filters.Budget == "" {
		r.cache.set(cacheKey, result, 1*time.Minute)
	}

	return result, rows.Err()
}

// GetProduct returns a single product by slug (CACHED for 2 minutes)
func (r *Repository) GetProduct(ctx context.Context, slug string) (*types.Product, error) {
	cacheKey := fmt.Sprintf("product:%s", slug)

	// Check cache first
	if cached, ok := r.cache.get(cacheKey); ok {
		log.Printf("Cache HIT: product/%s", slug)
		return cached.(*types.Product), nil
	}

	start := time.Now()
	query := `
		SELECT p.id, p.slug, p.name, p.brand, p.image_url, p.category_slug, p.score,
		       p.why_recommended, p.pros, p.cons, p.ingredient_summary,
		       p.certifications, p.last_reviewed_at, p.price_tier,
		       COALESCE(
		           (SELECT array_agg(concern_code) FROM product_primary_concerns WHERE product_id = p.id),
		           '{}'
		       ) AS concerns,
		       COALESCE(
		           (SELECT array_agg(philosophy_code) FROM product_philosophy_tags WHERE product_id = p.id),
		           '{}'
		       ) AS philosophies,
		       p.usage_pattern
		FROM products p
		WHERE p.slug = $1 AND p.status = 'active'
	`

	var p types.Product
	var imageURL, ingredientSummary sql.NullString
	var whyRecommended, pros, cons, certifications, concerns, philosophies []string
	var lastReviewed time.Time
	var priceTier, usagePattern string

	err := r.db.QueryRowContext(ctx, query, slug).Scan(
		&p.ID, &p.Slug, &p.Name, &p.Brand, &imageURL, &p.Category, &p.Score,
		pq.Array(&whyRecommended), pq.Array(&pros), pq.Array(&cons),
		&ingredientSummary, pq.Array(&certifications), &lastReviewed, &priceTier,
		pq.Array(&concerns), pq.Array(&philosophies), &usagePattern,
	)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, fmt.Errorf("failed to query product: %w", err)
	}

	if imageURL.Valid {
		p.ImageURL = imageURL.String
	}
	if ingredientSummary.Valid {
		p.IngredientsSummary = ingredientSummary.String
	}

	p.WhyRecommended = whyRecommended
	p.Pros = pros
	p.Cons = cons
	p.Certifications = certifications
	p.LastReviewed = lastReviewed.Format("2006-01-02")

	// Tags already fetched in main query (no N+1!)
	p.Tags = &types.ProductTags{
		Concern:    concerns,
		Philosophy: philosophies,
		Budget:     priceTier,
		Usage:      []string{usagePattern},
	}

	// Get buy links (single query)
	buyLinks, err := r.getProductBuyLinks(ctx, p.ID)
	if err == nil {
		p.BuyLinks = buyLinks
	}

	// Set price range based on tier
	switch priceTier {
	case "premium":
		p.PriceRange = "₹800+"
	case "mid_range":
		p.PriceRange = "₹400-800"
	case "affordable":
		p.PriceRange = "Under ₹400"
	}

	logQuery("GetProduct", start, 1)

	// Cache for 2 minutes
	r.cache.set(cacheKey, &p, 2*time.Minute)

	return &p, nil
}

// getProductBuyLinks returns buy links for a product
func (r *Repository) getProductBuyLinks(ctx context.Context, productID string) ([]types.BuyLink, error) {
	query := `
		SELECT vendor, url 
		FROM product_buy_links 
		WHERE product_id = $1 
		ORDER BY display_order
	`

	rows, err := r.db.QueryContext(ctx, query, productID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var links []types.BuyLink
	for rows.Next() {
		var link types.BuyLink
		if err := rows.Scan(&link.Vendor, &link.URL); err != nil {
			continue
		}
		links = append(links, link)
	}

	return links, rows.Err()
}

// GetSimilarProducts returns similar products based on category
func (r *Repository) GetSimilarProducts(ctx context.Context, slug string, limit int) ([]types.ProductSummary, error) {
	start := time.Now()

	// Get the product's category first
	var categorySlug string
	err := r.db.QueryRowContext(ctx,
		`SELECT category_slug FROM products WHERE slug = $1`, slug).Scan(&categorySlug)
	if err != nil {
		return nil, err
	}

	// Get similar products from same category
	query := `
		SELECT p.id, p.slug, p.name, p.brand, p.image_url, p.score, p.short_reason, p.price_tier
		FROM products p
		WHERE p.category_slug = $1 AND p.slug != $2 AND p.status = 'active'
		ORDER BY p.score DESC
		LIMIT $3
	`

	rows, err := r.db.QueryContext(ctx, query, categorySlug, slug, limit)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var products []types.ProductSummary
	for rows.Next() {
		var p types.ProductSummary
		var imageURL, priceTier sql.NullString
		if err := rows.Scan(&p.ID, &p.Slug, &p.Name, &p.Brand, &imageURL, &p.Score, &p.ShortReason, &priceTier); err != nil {
			continue
		}
		if imageURL.Valid {
			p.ImageURL = imageURL.String
		}
		if priceTier.Valid {
			p.BudgetTier = priceTier.String
		}
		products = append(products, p)
	}

	logQuery("GetSimilarProducts", start, len(products))
	return products, rows.Err()
}

// GetAvailableFilters returns filter options with counts
func (r *Repository) GetAvailableFilters(ctx context.Context, category string) (*types.FilterOptions, error) {
	start := time.Now()
	filters := &types.FilterOptions{Category: category}

	categoryFilter := ""
	args := []interface{}{}
	if category != "" {
		categoryFilter = " AND p.category_slug = $1"
		args = append(args, category)
	}

	// Get concern counts
	concernQuery := fmt.Sprintf(`
		SELECT pc.concern_code, c.label, COUNT(DISTINCT p.id)
		FROM products p
		JOIN product_primary_concerns pc ON p.id = pc.product_id
		JOIN primary_concerns c ON pc.concern_code = c.code
		WHERE p.status = 'active' %s
		GROUP BY pc.concern_code, c.label
		ORDER BY COUNT(DISTINCT p.id) DESC
	`, categoryFilter)

	rows, err := r.db.QueryContext(ctx, concernQuery, args...)
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var opt types.FilterOption
			if rows.Scan(&opt.Value, &opt.Label, &opt.Count) == nil {
				filters.Concern = append(filters.Concern, opt)
			}
		}
	}

	// Get philosophy counts
	philQuery := fmt.Sprintf(`
		SELECT pt.philosophy_code, t.label, COUNT(DISTINCT p.id)
		FROM products p
		JOIN product_philosophy_tags pt ON p.id = pt.product_id
		JOIN philosophy_tags t ON pt.philosophy_code = t.code
		WHERE p.status = 'active' %s
		GROUP BY pt.philosophy_code, t.label
		ORDER BY COUNT(DISTINCT p.id) DESC
	`, categoryFilter)

	rows2, err := r.db.QueryContext(ctx, philQuery, args...)
	if err == nil {
		defer rows2.Close()
		for rows2.Next() {
			var opt types.FilterOption
			if rows2.Scan(&opt.Value, &opt.Label, &opt.Count) == nil {
				filters.Philosophy = append(filters.Philosophy, opt)
			}
		}
	}

	// Get budget counts
	budgetQuery := fmt.Sprintf(`
		SELECT p.price_tier, 
		       CASE p.price_tier 
		         WHEN 'premium' THEN 'Premium' 
		         WHEN 'mid_range' THEN 'Mid Range' 
		         ELSE 'Affordable' 
		       END as label,
		       COUNT(*)
		FROM products p
		WHERE p.status = 'active' %s
		GROUP BY p.price_tier
		ORDER BY COUNT(*) DESC
	`, categoryFilter)

	rows3, err := r.db.QueryContext(ctx, budgetQuery, args...)
	if err == nil {
		defer rows3.Close()
		for rows3.Next() {
			var opt types.FilterOption
			if rows3.Scan(&opt.Value, &opt.Label, &opt.Count) == nil {
				filters.Budget = append(filters.Budget, opt)
			}
		}
	}

	// Get usage counts
	usageQuery := fmt.Sprintf(`
		SELECT p.usage_pattern,
		       CASE p.usage_pattern 
		         WHEN 'daily_use' THEN 'Daily Use' 
		         WHEN 'alternate_day' THEN 'Alternate Day' 
		         ELSE 'Weekly Detox' 
		       END as label,
		       COUNT(*)
		FROM products p
		WHERE p.status = 'active' %s
		GROUP BY p.usage_pattern
		ORDER BY COUNT(*) DESC
	`, categoryFilter)

	rows4, err := r.db.QueryContext(ctx, usageQuery, args...)
	if err == nil {
		defer rows4.Close()
		for rows4.Next() {
			var opt types.FilterOption
			if rows4.Scan(&opt.Value, &opt.Label, &opt.Count) == nil {
				filters.Usage = append(filters.Usage, opt)
			}
		}
	}

	logQuery("GetAvailableFilters", start, 4)
	return filters, nil
}

// GetMethodology returns the current scoring methodology (CACHED for 1 hour)
func (r *Repository) GetMethodology(ctx context.Context) (*types.Methodology, error) {
	cacheKey := "methodology"

	// Check cache first
	if cached, ok := r.cache.get(cacheKey); ok {
		log.Println("Cache HIT: methodology")
		return cached.(*types.Methodology), nil
	}

	start := time.Now()
	query := `
		SELECT version, summary, last_updated_at
		FROM methodologies
		ORDER BY last_updated_at DESC
		LIMIT 1
	`

	var m types.Methodology
	var lastUpdated time.Time

	err := r.db.QueryRowContext(ctx, query).Scan(&m.Version, &m.Summary, &lastUpdated)
	if err == sql.ErrNoRows {
		return &types.Methodology{
			Version:     "v1",
			Summary:     "Products are scored on safety, efficacy, ingredient quality, and value.",
			LastUpdated: "2025-01-01",
		}, nil
	}
	if err != nil {
		return nil, err
	}

	m.LastUpdated = lastUpdated.Format("2006-01-02")

	logQuery("GetMethodology", start, 1)

	// Cache for 1 hour
	r.cache.set(cacheKey, &m, 1*time.Hour)

	return &m, nil
}
