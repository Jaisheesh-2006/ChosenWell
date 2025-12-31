package mock

import (
	"errors"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/types"
)

// ErrProductNotFound is returned when a product slug does not match any entry.
var ErrProductNotFound = errors.New("product not found")

// ErrCategoryNotFound is returned when a category slug does not match any entry.
var ErrCategoryNotFound = errors.New("category not found")

// categoryProductMap links category slugs to product slugs.
var categoryProductMap = map[string][]string{
	"toothpaste":  {"non-toxic-toothpaste"},
	"cooking-oil": {"organic-ghee"},
	"vitamins":    {"magnesium-supplement"},
}

// categoryLongDescriptions provides SEO content for each category.
var categoryLongDescriptions = map[string]string{
	"toothpaste": "Natural toothpaste options have evolved significantly, offering effective cleaning " +
		"without harsh chemicals. We analyze fluoride alternatives, SLS-free formulas, and remineralizing " +
		"ingredients to help you choose the best option for your family's oral health.",
	"cooking-oil": "Cooking oils vary dramatically in their health profiles, smoke points, and nutritional " +
		"benefits. Our analysis covers fatty acid composition, processing methods, and optimal cooking " +
		"applications to guide your kitchen choices.",
	"vitamins": "The supplement market is vast and often confusing. We evaluate bioavailability, dosing " +
		"accuracy, third-party testing, and ingredient quality to identify supplements that actually deliver " +
		"on their promises.",
}

// products holds the curated mock catalog (full detail).
var products = []types.Product{
	{
		ID:       "prod-001",
		Slug:     "non-toxic-toothpaste",
		Name:     "Non-Toxic Toothpaste",
		Brand:    "PureSmile",
		Category: "toothpaste",
		Score:    92,
		WhyRecommended: []string{
			"Formulated without fluoride, SLS, or artificial sweeteners",
			"Uses hydroxyapatite for enamel remineralization",
			"Safe for the whole family including children",
		},
		Pros: []string{
			"Hydroxyapatite strengthens enamel naturally",
			"Free from harsh chemicals and artificial dyes",
			"Mild mint flavor suitable for sensitive mouths",
		},
		Cons: []string{
			"Premium price point compared to mainstream brands",
		},
		IngredientsSummary: "Calcium carbonate, hydroxyapatite, xylitol, coconut oil, peppermint essential oil. No parabens, no triclosan.",
		Certifications:     []string{"EWG Verified", "Leaping Bunny"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Amazon", URL: "https://amazon.com/dp/example1"},
			{Vendor: "iHerb", URL: "https://iherb.com/pr/example1"},
		},
		PriceRange:   "$12-18",
		Tags:         []string{"fluoride-free", "kids-safe", "organic"},
		LastReviewed: "2025-12-15",
	},
	{
		ID:       "prod-002",
		Slug:     "organic-ghee",
		Name:     "Organic Ghee",
		Brand:    "GrassRoots Dairy",
		Category: "cooking-oil",
		Score:    95,
		WhyRecommended: []string{
			"Sourced from pasture-raised, grass-fed cows",
			"Rich in fat-soluble vitamins A, D, E, and K2",
			"High smoke point ideal for cooking without oxidation",
		},
		Pros: []string{
			"High in butyrate for gut health support",
			"Lactose and casein free—suitable for dairy-sensitive individuals",
			"Stable at high temperatures, perfect for sautéing and frying",
		},
		Cons: []string{
			"Calorie-dense; portion control recommended",
		},
		IngredientsSummary: "100% organic clarified butter from grass-fed cow milk. No additives, preservatives, or colorants.",
		Certifications:     []string{"USDA Organic", "Non-GMO Project Verified"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Thrive Market", URL: "https://thrivemarket.com/p/example2"},
			{Vendor: "Whole Foods", URL: "https://wholefoodsmarket.com/product/example2"},
		},
		PriceRange:   "$15-22",
		Tags:         []string{"grass-fed", "organic", "keto-friendly"},
		LastReviewed: "2025-12-10",
	},
	{
		ID:       "prod-003",
		Slug:     "magnesium-supplement",
		Name:     "Magnesium Glycinate",
		Brand:    "VitalMin",
		Category: "vitamins",
		Score:    88,
		WhyRecommended: []string{
			"Uses magnesium glycinate, one of the most bioavailable forms",
			"Supports muscle relaxation, sleep quality, and stress resilience",
			"Gentle on the GI system unlike oxide or citrate forms",
		},
		Pros: []string{
			"Gentle on the stomach compared to oxide or citrate forms",
			"Third-party tested for purity and potency",
			"Vegan capsules with no fillers or flow agents",
		},
		Cons: []string{
			"Requires 2 capsules per serving for full dose",
		},
		IngredientsSummary: "Magnesium glycinate (120 mg elemental Mg per capsule), hypromellose capsule. Free from gluten, soy, and artificial additives.",
		Certifications:     []string{"NSF Certified", "Vegan Certified"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Amazon", URL: "https://amazon.com/dp/example3"},
			{Vendor: "Vitacost", URL: "https://vitacost.com/product/example3"},
		},
		PriceRange:   "$18-25",
		Tags:         []string{"vegan", "sleep-support", "stress-relief"},
		LastReviewed: "2025-12-01",
	},
}

// categories maps to the product catalog above.
var categories = []types.CategorySummary{
	{
		Slug:        "toothpaste",
		Title:       "Toothpaste",
		Description: "Natural and effective oral care products analyzed for safety and efficacy.",
	},
	{
		Slug:        "cooking-oil",
		Title:       "Cooking Oils",
		Description: "Heart-healthy oils compared for smoke point, nutrition, and cooking applications.",
	},
	{
		Slug:        "vitamins",
		Title:       "Vitamins & Supplements",
		Description: "Essential supplements evaluated for bioavailability and ingredient quality.",
	},
}

// GetCategories returns all available product categories.
func GetCategories() []types.CategorySummary {
	return categories
}

// GetCategory looks up a category by its slug.
func GetCategory(slug string) (*types.CategorySummary, error) {
	for i := range categories {
		if categories[i].Slug == slug {
			return &categories[i], nil
		}
	}
	return nil, ErrCategoryNotFound
}

// GetCategoryDetail returns full category info including products.
func GetCategoryDetail(slug string) (*types.Category, error) {
	cat, err := GetCategory(slug)
	if err != nil {
		return nil, err
	}

	longDesc := categoryLongDescriptions[slug]
	productSummaries := GetProductSummariesByCategory(slug)

	return &types.Category{
		Slug:            cat.Slug,
		Title:           cat.Title,
		LongDescription: longDesc,
		Criteria:        []string{"Ingredients", "Certifications", "Value", "Effectiveness"},
		CuratedProducts: productSummaries,
	}, nil
}

// GetProduct looks up a product by its slug (full detail).
func GetProduct(slug string) (*types.Product, error) {
	for i := range products {
		if products[i].Slug == slug {
			return &products[i], nil
		}
	}
	return nil, ErrProductNotFound
}

// GetAllProducts returns all products as summaries.
func GetAllProducts() []types.ProductSummary {
	summaries := make([]types.ProductSummary, 0, len(products))
	for _, p := range products {
		summaries = append(summaries, toProductSummary(p))
	}
	return summaries
}

// GetProductSummariesByCategory returns product summaries for a category.
func GetProductSummariesByCategory(categorySlug string) []types.ProductSummary {
	productSlugs, exists := categoryProductMap[categorySlug]
	if !exists {
		return []types.ProductSummary{}
	}

	result := make([]types.ProductSummary, 0, len(productSlugs))
	for _, pSlug := range productSlugs {
		for _, p := range products {
			if p.Slug == pSlug {
				result = append(result, toProductSummary(p))
				break
			}
		}
	}
	return result
}

// toProductSummary converts a full Product to a ProductSummary.
func toProductSummary(p types.Product) types.ProductSummary {
	shortReason := ""
	if len(p.WhyRecommended) > 0 {
		shortReason = p.WhyRecommended[0]
	}
	return types.ProductSummary{
		ID:          p.ID,
		Slug:        p.Slug,
		Name:        p.Name,
		Brand:       p.Brand,
		Score:       p.Score,
		ShortReason: shortReason,
		PriceRange:  p.PriceRange,
	}
}
