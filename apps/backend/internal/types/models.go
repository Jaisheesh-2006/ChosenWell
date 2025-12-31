package types

// CategorySummary represents a product category in the curated catalog.
type CategorySummary struct {
	ID      string `json:"id"`
	Name    string `json:"name"`
	Slug    string `json:"slug"`
	IconURL string `json:"icon_url"`
}

// CategoryDetail includes category metadata along with its products.
type CategoryDetail struct {
	CategorySummary
	Products []ProductDetail `json:"products"`
}

// ProductDetail represents a single curated health product with analysis.
type ProductDetail struct {
	ID                  string   `json:"id"`
	Name                string   `json:"name"`
	Brand               string   `json:"brand"`
	Slug                string   `json:"slug"`
	HealthScore         int      `json:"health_score"`
	WhyRecommended      string   `json:"why_recommended"`
	Pros                []string `json:"pros"`
	Cons                []string `json:"cons"`
	IngredientsAnalysis string   `json:"ingredients_analysis"`
	AffiliateLink       string   `json:"affiliate_link"`
}
