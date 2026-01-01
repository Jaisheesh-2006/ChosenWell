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
	CriteriaVersion string           `json:"criteria_version,omitempty"`
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
	Tags               []string         `json:"tags,omitempty"`
	LastReviewed       string           `json:"last_reviewed,omitempty"`
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
