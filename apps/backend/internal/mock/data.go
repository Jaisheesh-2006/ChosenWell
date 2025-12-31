package mock

import (
	"errors"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/types"
)

// ErrProductNotFound is returned when a product slug does not match any entry.
var ErrProductNotFound = errors.New("product not found")

// products holds the curated mock catalog.
var products = []types.ProductDetail{
	{
		ID:          "prod-001",
		Name:        "Non-Toxic Toothpaste",
		Brand:       "PureSmile",
		Slug:        "non-toxic-toothpaste",
		HealthScore: 92,
		WhyRecommended: "Formulated without fluoride, SLS, or artificial sweeteners. " +
			"Uses hydroxyapatite for enamel remineralization and is safe for the whole family.",
		Pros: []string{
			"Hydroxyapatite strengthens enamel naturally",
			"Free from harsh chemicals and artificial dyes",
			"Mild mint flavor suitable for sensitive mouths",
		},
		Cons: []string{
			"Premium price point compared to mainstream brands",
		},
		IngredientsAnalysis: "Calcium carbonate, hydroxyapatite, xylitol, coconut oil, " +
			"peppermint essential oil. No parabens, no triclosan.",
		AffiliateLink: "https://example.com/affiliate/non-toxic-toothpaste",
	},
	{
		ID:          "prod-002",
		Name:        "Organic Ghee",
		Brand:       "GrassRoots Dairy",
		Slug:        "organic-ghee",
		HealthScore: 95,
		WhyRecommended: "Sourced from pasture-raised, grass-fed cows. Rich in fat-soluble vitamins A, D, E, and K2. " +
			"High smoke point makes it ideal for cooking without oxidation.",
		Pros: []string{
			"High in butyrate for gut health support",
			"Lactose and casein free—suitable for dairy-sensitive individuals",
			"Stable at high temperatures, perfect for sautéing and frying",
		},
		Cons: []string{
			"Calorie-dense; portion control recommended",
		},
		IngredientsAnalysis: "100% organic clarified butter from grass-fed cow milk. " +
			"No additives, preservatives, or colorants.",
		AffiliateLink: "https://example.com/affiliate/organic-ghee",
	},
	{
		ID:          "prod-003",
		Name:        "Magnesium Supplement",
		Brand:       "VitalMin",
		Slug:        "magnesium-supplement",
		HealthScore: 88,
		WhyRecommended: "Uses magnesium glycinate, one of the most bioavailable forms. " +
			"Supports muscle relaxation, sleep quality, and stress resilience without GI upset.",
		Pros: []string{
			"Gentle on the stomach compared to oxide or citrate forms",
			"Third-party tested for purity and potency",
			"Vegan capsules with no fillers or flow agents",
		},
		Cons: []string{
			"Requires 2 capsules per serving for full dose",
		},
		IngredientsAnalysis: "Magnesium glycinate (120 mg elemental Mg per capsule), " +
			"hypromellose capsule. Free from gluten, soy, and artificial additives.",
		AffiliateLink: "https://example.com/affiliate/magnesium-supplement",
	},
}

// categories maps to the product catalog above.
var categories = []types.CategorySummary{
	{
		ID:      "cat-001",
		Name:    "Oral Care",
		Slug:    "oral-care",
		IconURL: "/icons/oral-care.svg",
	},
	{
		ID:      "cat-002",
		Name:    "Cooking Essentials",
		Slug:    "cooking-essentials",
		IconURL: "/icons/cooking.svg",
	},
	{
		ID:      "cat-003",
		Name:    "Supplements",
		Slug:    "supplements",
		IconURL: "/icons/supplements.svg",
	},
}

// GetCategories returns all available product categories.
func GetCategories() []types.CategorySummary {
	return categories
}

// GetProduct looks up a product by its slug.
// Returns a pointer to the product if found, or ErrProductNotFound otherwise.
func GetProduct(slug string) (*types.ProductDetail, error) {
	for i := range products {
		if products[i].Slug == slug {
			return &products[i], nil
		}
	}
	return nil, ErrProductNotFound
}
