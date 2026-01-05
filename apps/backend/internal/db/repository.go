package db

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"os"
	"strings"
	"time"

	"github.com/lib/pq"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/types"
)

// Repository handles database operations
type Repository struct {
	db *sql.DB
}

// New creates a new database repository
func New() (*Repository, error) {
	connStr := os.Getenv("DATABASE_URL")
	if connStr == "" {
		connStr = "postgresql://healthuser:healthpass@localhost:5432/healthiswealth?sslmode=disable"
	}

	// Log connection (hide password)
	if idx := strings.Index(connStr, "@"); idx > 0 {
		log.Printf("Connecting to database: ...%s", connStr[idx:])
	}

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, fmt.Errorf("failed to open database: %w", err)
	}

	// Configure connection pool
	db.SetMaxOpenConns(25)
	db.SetMaxIdleConns(5)
	db.SetConnMaxLifetime(5 * time.Minute)

	// Verify connection
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := db.PingContext(ctx); err != nil {
		return nil, fmt.Errorf("failed to ping database: %w", err)
	}

	return &Repository{db: db}, nil
}

// Close closes the database connection
func (r *Repository) Close() error {
	return r.db.Close()
}

// GetCategories returns all active categories
func (r *Repository) GetCategories(ctx context.Context) ([]types.CategorySummary, error) {
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

	return categories, rows.Err()
}

// GetCategory returns a category by slug with its products
func (r *Repository) GetCategory(ctx context.Context, slug string) (*types.Category, error) {
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

	// Convert criteria array to CategoryCriteria
	c.Criteria = types.CategoryCriteria{MustHave: criteriaArr}

	// Use long_description as criteria_content for frontend compatibility
	c.CriteriaContent = c.LongDescription

	// Get products for this category
	products, err := r.GetProducts(ctx, ProductFilters{Category: slug, Limit: 100})
	if err != nil {
		return nil, fmt.Errorf("failed to get category products: %w", err)
	}
	c.CuratedProducts = products.Products

	return &c, nil
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

// GetProducts returns filtered products
func (r *Repository) GetProducts(ctx context.Context, filters ProductFilters) (*types.ProductListResponse, error) {
	// Set defaults
	if filters.Limit == 0 {
		filters.Limit = 20
	}
	if filters.Page == 0 {
		filters.Page = 1
	}
	offset := (filters.Page - 1) * filters.Limit

	// Build query with filters
	query := `
		SELECT DISTINCT p.id, p.slug, p.name, p.brand, p.image_url, p.score, 
		       p.short_reason, p.price_tier, p.usage_pattern
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

		if err := rows.Scan(&p.ID, &p.Slug, &p.Name, &p.Brand, &imageURL, &p.Score,
			&p.ShortReason, &priceTier, &usagePattern); err != nil {
			return nil, fmt.Errorf("failed to scan product: %w", err)
		}

		if imageURL.Valid {
			p.ImageURL = imageURL.String
		}
		if priceTier.Valid {
			p.BudgetTier = priceTier.String
		}

		// Get tags for this product
		tags, err := r.getProductTags(ctx, p.ID)
		if err == nil {
			p.Tags = tags
		}

		products = append(products, p)
	}

	// Get total count with same filters
	countQuery := `
		SELECT COUNT(DISTINCT p.id)
		FROM products p
		LEFT JOIN product_primary_concerns pc ON p.id = pc.product_id
		LEFT JOIN product_philosophy_tags pt ON p.id = pt.product_id
		WHERE p.status = 'active'
	`

	// Rebuild count query with same filters (excluding LIMIT/OFFSET)
	countArgs := []interface{}{}
	countArgIdx := 1

	if filters.Category != "" {
		countQuery += fmt.Sprintf(" AND p.category_slug = $%d", countArgIdx)
		countArgs = append(countArgs, filters.Category)
		countArgIdx++
	}
	if len(filters.Concern) > 0 {
		countQuery += fmt.Sprintf(" AND pc.concern_code = ANY($%d)", countArgIdx)
		countArgs = append(countArgs, pq.Array(filters.Concern))
		countArgIdx++
	}
	if len(filters.Philosophy) > 0 {
		countQuery += fmt.Sprintf(" AND pt.philosophy_code = ANY($%d)", countArgIdx)
		countArgs = append(countArgs, pq.Array(filters.Philosophy))
		countArgIdx++
	}
	if filters.Budget != "" {
		countQuery += fmt.Sprintf(" AND p.price_tier = $%d", countArgIdx)
		countArgs = append(countArgs, filters.Budget)
		countArgIdx++
	}
	if len(filters.Usage) > 0 {
		countQuery += fmt.Sprintf(" AND p.usage_pattern = ANY($%d)", countArgIdx)
		countArgs = append(countArgs, pq.Array(filters.Usage))
	}

	var total int
	if err := r.db.QueryRowContext(ctx, countQuery, countArgs...).Scan(&total); err != nil {
		total = len(products)
	}

	return &types.ProductListResponse{
		Products: products,
		Total:    total,
	}, rows.Err()
}

// GetProduct returns a single product by slug
func (r *Repository) GetProduct(ctx context.Context, slug string) (*types.Product, error) {
	query := `
		SELECT p.id, p.slug, p.name, p.brand, p.image_url, p.category_slug, p.score,
		       p.why_recommended, p.pros, p.cons, p.ingredient_summary,
		       p.certifications, p.last_reviewed_at, p.price_tier
		FROM products p
		WHERE p.slug = $1 AND p.status = 'active'
	`

	var p types.Product
	var imageURL, ingredientSummary sql.NullString
	var whyRecommended, pros, cons, certifications []string
	var lastReviewed time.Time
	var priceTier string

	err := r.db.QueryRowContext(ctx, query, slug).Scan(
		&p.ID, &p.Slug, &p.Name, &p.Brand, &imageURL, &p.Category, &p.Score,
		pq.Array(&whyRecommended), pq.Array(&pros), pq.Array(&cons),
		&ingredientSummary, pq.Array(&certifications), &lastReviewed, &priceTier,
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

	// Get tags
	tags, err := r.getProductTags(ctx, p.ID)
	if err == nil {
		p.Tags = tags
	}

	// Get buy links
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

	return &p, nil
}

// getProductTags returns tags for a product
func (r *Repository) getProductTags(ctx context.Context, productID string) (*types.ProductTags, error) {
	tags := &types.ProductTags{}

	// Get concerns
	concernQuery := `SELECT concern_code FROM product_primary_concerns WHERE product_id = $1`
	rows, err := r.db.QueryContext(ctx, concernQuery, productID)
	if err == nil {
		defer rows.Close()
		for rows.Next() {
			var code string
			if rows.Scan(&code) == nil {
				tags.Concern = append(tags.Concern, code)
			}
		}
	}

	// Get philosophy tags
	philQuery := `SELECT philosophy_code FROM product_philosophy_tags WHERE product_id = $1`
	rows2, err := r.db.QueryContext(ctx, philQuery, productID)
	if err == nil {
		defer rows2.Close()
		for rows2.Next() {
			var code string
			if rows2.Scan(&code) == nil {
				tags.Philosophy = append(tags.Philosophy, code)
			}
		}
	}

	// Get budget and usage from products table
	budgetQuery := `SELECT price_tier, usage_pattern FROM products WHERE id = $1`
	var budget, usage string
	if r.db.QueryRowContext(ctx, budgetQuery, productID).Scan(&budget, &usage) == nil {
		tags.Budget = budget
		tags.Usage = []string{usage}
	}

	return tags, nil
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

// GetSimilarProducts returns similar products based on category and tags
func (r *Repository) GetSimilarProducts(ctx context.Context, slug string, limit int) ([]types.ProductSummary, error) {
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

	return products, rows.Err()
}

// GetAvailableFilters returns filter options with counts
func (r *Repository) GetAvailableFilters(ctx context.Context, category string) (*types.FilterOptions, error) {
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

	return filters, nil
}

// GetMethodology returns the current scoring methodology
func (r *Repository) GetMethodology(ctx context.Context) (*types.Methodology, error) {
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
		// Return default methodology
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
	return &m, nil
}
