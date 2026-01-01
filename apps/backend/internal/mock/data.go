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
	"toothpaste": {"non-toxic-toothpaste", "charcoal-whitening-toothpaste", "kids-strawberry-toothpaste"},
	"shampoo":    {"gentle-daily-shampoo", "scalp-therapy-shampoo", "color-protect-shampoo"},
}

// categoryLongDescriptions provides SEO content for each category.
var categoryLongDescriptions = map[string]string{
	"toothpaste": "Natural toothpaste options have evolved significantly, offering effective cleaning " +
		"without harsh chemicals. We analyze fluoride alternatives, SLS-free formulas, and remineralizing " +
		"ingredients to help you choose the best option for your family's oral health.",
	"shampoo": "The shampoo market is filled with products containing sulfates, parabens, and synthetic " +
		"fragrances. We evaluate ingredient safety, scalp compatibility, and effectiveness to help you find " +
		"shampoos that clean without compromising your hair or health.",
}

// products holds the curated mock catalog (full detail).
var products = []types.Product{
	// =====================
	// TOOTHPASTE PRODUCTS
	// =====================
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
		Slug:     "charcoal-whitening-toothpaste",
		Name:     "Charcoal Whitening Toothpaste",
		Brand:    "BrightNaturals",
		Category: "toothpaste",
		Score:    87,
		WhyRecommended: []string{
			"Activated charcoal provides gentle whitening",
			"No harsh bleaching agents or peroxides",
			"Natural antibacterial properties from tea tree oil",
		},
		Pros: []string{
			"Visibly whiter teeth within 2 weeks",
			"Charcoal absorbs stains and toxins",
			"Fresh spearmint taste without artificial sweeteners",
		},
		Cons: []string{
			"Charcoal can be messy during application",
		},
		IngredientsSummary: "Activated bamboo charcoal, baking soda, coconut oil, tea tree oil, spearmint. No artificial colors or preservatives.",
		Certifications:     []string{"Vegan Certified", "Leaping Bunny"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Amazon", URL: "https://amazon.com/dp/example2"},
			{Vendor: "Target", URL: "https://target.com/p/example2"},
		},
		PriceRange:   "$10-14",
		Tags:         []string{"fluoride-free", "vegan"},
		LastReviewed: "2025-12-10",
	},
	{
		ID:       "prod-003",
		Slug:     "kids-strawberry-toothpaste",
		Name:     "Kids Strawberry Toothpaste",
		Brand:    "LittleTeeth",
		Category: "toothpaste",
		Score:    90,
		WhyRecommended: []string{
			"Safe-to-swallow formula perfect for toddlers learning to brush",
			"Natural strawberry flavor kids actually enjoy",
			"Xylitol helps prevent cavities naturally",
		},
		Pros: []string{
			"Kids love the natural strawberry taste",
			"Safe if accidentally swallowed",
			"Gentle formula for developing teeth and gums",
		},
		Cons: []string{
			"May not appeal to kids who prefer traditional mint",
		},
		IngredientsSummary: "Xylitol, calcium carbonate, organic strawberry flavor, aloe vera, vitamin E. Fluoride-free and SLS-free.",
		Certifications:     []string{"EWG Verified", "Made Safe"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Amazon", URL: "https://amazon.com/dp/example3"},
			{Vendor: "Walmart", URL: "https://walmart.com/ip/example3"},
		},
		PriceRange:   "$8-12",
		Tags:         []string{"fluoride-free", "kids-safe", "organic"},
		LastReviewed: "2025-12-08",
	},
	// =====================
	// SHAMPOO PRODUCTS
	// =====================
	{
		ID:       "prod-004",
		Slug:     "gentle-daily-shampoo",
		Name:     "Gentle Daily Shampoo",
		Brand:    "CleanRoots",
		Category: "shampoo",
		Score:    91,
		WhyRecommended: []string{
			"Coconut-derived cleansers provide effective yet gentle cleansing",
			"Perfect for daily use without stripping natural oils",
			"Chamomile and aloe soothe the scalp",
		},
		Pros: []string{
			"Gentle enough for sensitive scalps",
			"Leaves hair soft without residue",
			"Pleasant natural scent from essential oils",
		},
		Cons: []string{
			"May not lather as much as sulfate-based shampoos",
		},
		IngredientsSummary: "Aloe vera juice, coconut-derived cleansers, chamomile extract, jojoba oil, vitamin B5. No sulfates, parabens, or silicones.",
		Certifications:     []string{"EWG Verified", "Leaping Bunny", "Vegan Certified"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Amazon", URL: "https://amazon.com/dp/example4"},
			{Vendor: "Thrive Market", URL: "https://thrivemarket.com/p/example4"},
		},
		PriceRange:   "$14-18",
		Tags:         []string{"sulfate-free", "paraben-free", "vegan"},
		LastReviewed: "2025-12-12",
	},
	{
		ID:       "prod-005",
		Slug:     "scalp-therapy-shampoo",
		Name:     "Scalp Therapy Shampoo",
		Brand:    "ScalpCare Pro",
		Category: "shampoo",
		Score:    89,
		WhyRecommended: []string{
			"Tea tree oil provides natural antifungal properties",
			"Targets dandruff and dry scalp effectively",
			"Dermatologist-tested for sensitive scalps",
		},
		Pros: []string{
			"Noticeably reduces flaking within first week",
			"Cooling peppermint sensation soothes itchiness",
			"Works well for various scalp conditions",
		},
		Cons: []string{
			"Tea tree scent may be strong for some users",
		},
		IngredientsSummary: "Tea tree oil, salicylic acid (plant-derived), zinc pyrithione, peppermint oil, oat extract. Dermatologist tested.",
		Certifications:     []string{"Made Safe", "Leaping Bunny"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Amazon", URL: "https://amazon.com/dp/example5"},
			{Vendor: "Ulta", URL: "https://ulta.com/p/example5"},
		},
		PriceRange:   "$18-24",
		Tags:         []string{"sulfate-free", "sensitive-scalp", "paraben-free"},
		LastReviewed: "2025-12-05",
	},
	{
		ID:       "prod-006",
		Slug:     "color-protect-shampoo",
		Name:     "Color Protect Shampoo",
		Brand:    "VibrantLocks",
		Category: "shampoo",
		Score:    86,
		WhyRecommended: []string{
			"Quinoa protein helps seal color into hair shaft",
			"UV protection from sunflower seed extract",
			"Argan oil adds shine without weighing hair down",
		},
		Pros: []string{
			"Color stays vibrant 40% longer than with regular shampoo",
			"Adds noticeable shine and softness",
			"Works well with all hair types",
		},
		Cons: []string{
			"Higher price point than drugstore alternatives",
		},
		IngredientsSummary: "Quinoa protein, sunflower seed extract, argan oil, vitamin E, hibiscus extract. Sulfate-free and color-safe formula.",
		Certifications:     []string{"Vegan Certified", "Leaping Bunny"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Amazon", URL: "https://amazon.com/dp/example6"},
			{Vendor: "Sephora", URL: "https://sephora.com/product/example6"},
		},
		PriceRange:   "$16-22",
		Tags:         []string{"sulfate-free", "color-safe", "vegan"},
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
		Slug:        "shampoo",
		Title:       "Shampoo",
		Description: "Clean hair care products evaluated for scalp health and ingredient safety.",
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
