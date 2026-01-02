package types

// CategorySummary represents a product category in the curated catalog.
type CategorySummary struct {
	Slug        string `json:"slug"`
	Title       string `json:"title"`
	Description string `json:"description,omitempty"`
}

// CategoryCriteria defines the evaluation criteria for a category.
type CategoryCriteria struct {
	MustHave      []string `json:"must_have"`
	GoodToHave    []string `json:"good_to_have,omitempty"`
	Disqualifiers []string `json:"disqualifiers"`
}

// Category includes category metadata along with its curated products.
type Category struct {
	Slug            string           `json:"slug"`
	Title           string           `json:"title"`
	LongDescription string           `json:"long_description"`
	Criteria        CategoryCriteria `json:"criteria"`
	CriteriaContent string           `json:"criteria_content,omitempty"`
	CriteriaVersion string           `json:"criteria_version,omitempty"`
	CuratedProducts []ProductSummary `json:"curated_products,omitempty"`
}

// ProductSummary is a brief view of a product for listings.
type ProductSummary struct {
	ID          string       `json:"id,omitempty"`
	Slug        string       `json:"slug"`
	Name        string       `json:"name"`
	Brand       string       `json:"brand,omitempty"`
	ImageURL    string       `json:"image_url,omitempty"`
	Score       float64      `json:"score"`
	ShortReason string       `json:"short_reason,omitempty"`
	BudgetTier  string       `json:"budget_tier,omitempty"`
	Tags        *ProductTags `json:"tags,omitempty"`
}

// ProductTags contains structured tags for filtering.
// Each tag must be explainable on product page.
type ProductTags struct {
	Concern    []string `json:"concern,omitempty"`    // Max 1-2: dandruff, hair_fall, dry_frizzy, oily_scalp, sensitive_scalp
	Philosophy []string `json:"philosophy,omitempty"` // Max 1-2: ayurvedic, certified_organic, modern_clean, zero_chemical, solid_bar
	Budget     string   `json:"budget,omitempty"`     // Exactly one: premium, mid_range, affordable
	Usage      []string `json:"usage,omitempty"`      // Max 1: daily_use, alternate_day, weekly_detox
}

// TagExplanation explains why a specific tag was assigned.
type TagExplanation struct {
	Tag         string `json:"tag"`
	TagType     string `json:"tag_type"` // concern, philosophy, budget, usage
	Explanation string `json:"explanation"`
}

// BuyLink represents a vendor purchase link.
type BuyLink struct {
	Vendor string `json:"vendor,omitempty"`
	URL    string `json:"url,omitempty"`
}

// ScoreBreakdown shows detailed scoring for transparency.
type ScoreBreakdown struct {
	Factor   string  `json:"factor"`
	Score    float64 `json:"score"`
	MaxScore float64 `json:"max_score"`
}

// LocalizedPrice represents pricing for a specific country/currency.
type LocalizedPrice struct {
	Country        string  `json:"country"`
	Currency       string  `json:"currency"`
	CurrencySymbol string  `json:"currency_symbol,omitempty"`
	MinPrice       float64 `json:"min_price"`
	MaxPrice       float64 `json:"max_price,omitempty"`
	Formatted      string  `json:"formatted,omitempty"`
}

// Product is the full detail view of a curated health product.
type Product struct {
	ID                 string           `json:"id,omitempty"`
	Slug               string           `json:"slug"`
	Name               string           `json:"name"`
	Brand              string           `json:"brand,omitempty"`
	ImageURL           string           `json:"image_url,omitempty"`
	Category           string           `json:"category,omitempty"`
	Score              float64          `json:"score"`
	ScoreBreakdown     []ScoreBreakdown `json:"score_breakdown,omitempty"`
	WhyRecommended     []string         `json:"why_recommended,omitempty"`
	Pros               []string         `json:"pros,omitempty"`
	Cons               []string         `json:"cons,omitempty"`
	IngredientsSummary string           `json:"ingredients_summary,omitempty"`
	Certifications     []string         `json:"certifications,omitempty"`
	BuyLinks           []BuyLink        `json:"buy_links,omitempty"`
	PriceRange         string           `json:"price_range,omitempty"`
	Prices             []LocalizedPrice `json:"prices,omitempty"`
	Tags               *ProductTags     `json:"tags,omitempty"`
	TagExplanations    []TagExplanation `json:"tag_explanations,omitempty"`
	LastReviewed       string           `json:"last_reviewed,omitempty"`
}

// ProductListResponse wraps product list with metadata.
type ProductListResponse struct {
	Products       []ProductSummary  `json:"products"`
	Total          int               `json:"total"`
	FiltersApplied map[string]string `json:"filters_applied,omitempty"`
	EditorialNote  string            `json:"editorial_note,omitempty"`
}

// FilterOption represents a single filter choice with count.
type FilterOption struct {
	Value string `json:"value"`
	Label string `json:"label"`
	Count int    `json:"count"`
}

// FilterOptions contains available filters for a category.
type FilterOptions struct {
	Category   string         `json:"category"`
	Concern    []FilterOption `json:"concern,omitempty"`
	Philosophy []FilterOption `json:"philosophy,omitempty"`
	Budget     []FilterOption `json:"budget,omitempty"`
	Usage      []FilterOption `json:"usage,omitempty"`
}

// Currency represents a supported currency with exchange rate.
type Currency struct {
	Code         string  `json:"code"`
	Symbol       string  `json:"symbol"`
	Name         string  `json:"name,omitempty"`
	Country      string  `json:"country"`
	ExchangeRate float64 `json:"exchange_rate"`
}

// CurrencyList contains supported currencies and their exchange rates.
type CurrencyList struct {
	BaseCurrency string     `json:"base_currency"`
	Currencies   []Currency `json:"currencies"`
}

// Methodology describes how products are evaluated and scored.
type Methodology struct {
	Version     string             `json:"version"`
	Summary     string             `json:"summary"`
	Scoring     map[string]float64 `json:"scoring,omitempty"`
	LastUpdated string             `json:"last_updated,omitempty"`
}
