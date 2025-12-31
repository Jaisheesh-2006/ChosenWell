package types

// CategorySummary represents a product category in the curated catalog.
type CategorySummary struct {
	Slug        string `json:"slug"`
	Title       string `json:"title"`
	Description string `json:"description,omitempty"`
}

// Category includes category metadata along with its curated products.
type Category struct {
	Slug            string           `json:"slug"`
	Title           string           `json:"title"`
	LongDescription string           `json:"long_description"`
	Criteria        []string         `json:"criteria,omitempty"`
	CuratedProducts []ProductSummary `json:"curated_products,omitempty"`
}

// ProductSummary is a brief view of a product for listings.
type ProductSummary struct {
	ID          string  `json:"id,omitempty"`
	Slug        string  `json:"slug"`
	Name        string  `json:"name"`
	Brand       string  `json:"brand,omitempty"`
	Score       float64 `json:"score"`
	ShortReason string  `json:"short_reason,omitempty"`
	PriceRange  string  `json:"price_range,omitempty"`
}

// BuyLink represents a vendor purchase link.
type BuyLink struct {
	Vendor string `json:"vendor,omitempty"`
	URL    string `json:"url,omitempty"`
}

// Product is the full detail view of a curated health product.
type Product struct {
	ID                 string    `json:"id,omitempty"`
	Slug               string    `json:"slug"`
	Name               string    `json:"name"`
	Brand              string    `json:"brand,omitempty"`
	Category           string    `json:"category,omitempty"`
	Score              float64   `json:"score"`
	WhyRecommended     []string  `json:"why_recommended,omitempty"`
	Pros               []string  `json:"pros,omitempty"`
	Cons               []string  `json:"cons,omitempty"`
	IngredientsSummary string    `json:"ingredients_summary,omitempty"`
	Certifications     []string  `json:"certifications,omitempty"`
	BuyLinks           []BuyLink `json:"buy_links,omitempty"`
	PriceRange         string    `json:"price_range,omitempty"`
	Tags               []string  `json:"tags,omitempty"`
	LastReviewed       string    `json:"last_reviewed,omitempty"`
}
