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
	"shampoo": {
		"forest-essentials-bhringraj-shikakai",
		"sadhev-anti-dandruff",
		"just-herbs-amla-neem",
		"soultree-licorice-bhringraj",
		"kama-bringadi-cleanser",
		"vilvah-goat-milk",
		"kama-rose-jasmine",
		"arata-super-shampoo",
		"tribe-concepts-powder",
		"earth-rhythm-shampoo-bar",
	},
}

// categoryLongDescriptions provides SEO content for each category.
var categoryLongDescriptions = map[string]string{
	"toothpaste": "Natural toothpaste options have evolved significantly, offering effective cleaning " +
		"without harsh chemicals. We analyze fluoride alternatives, SLS-free formulas, and remineralizing " +
		"ingredients to help you choose the best option for your family's oral health.",
	"shampoo": "India's shampoo market is crowded, confusing, and often misleading. Most products are " +
		"designed to look effective in the short term—high foam, instant smoothness—while quietly compromising " +
		"long-term scalp and hair health. Our role is simple: act as a strict filter. If a shampoo appears on " +
		"this platform, it has cleared a bar that most mass-market products do not.",
}

// categoryCriteria defines evaluation criteria for each category.
var categoryCriteria = map[string]types.CategoryCriteria{
	"toothpaste": {
		MustHave: []string{
			"Free from SLS (Sodium Lauryl Sulfate)",
			"No artificial sweeteners or colors",
			"Third-party tested for safety",
		},
		GoodToHave: []string{
			"Contains remineralizing ingredients (hydroxyapatite, calcium)",
			"Natural flavoring from essential oils",
			"EWG Verified or similar certification",
		},
		Disqualifiers: []string{
			"Contains triclosan",
			"Contains artificial dyes (Blue 1, Red 40, etc.)",
			"Contains microbeads or microplastics",
		},
	},
	"shampoo": {
		MustHave: []string{
			"Uses approved gentle cleansing agents only (Decyl Glucoside, Sodium Cocoyl Glutamate, Sodium Lauroyl Sarcosinate, Sodium Cocoyl Isethionate, Reetha/Shikakai)",
			"Full INCI ingredient disclosure - no hidden 'Base Q.S.'",
			"BIS safety standards compliance (pH balance, heavy metal limits)",
			"Scalp-compatible pH (~5.5)",
		},
		GoodToHave: []string{
			"Contains verified Ayurvedic ingredients (Bhringraj, Amla, Shikakai, Reetha, Neem)",
			"ECOCERT / COSMOS certification",
			"BDIH Certified Natural Cosmetics",
			"Export-grade GMP standards",
			"Biodegradable surfactants",
		},
		Disqualifiers: []string{
			"Sulfates (SLS/SLES) - disrupts scalp's natural lipid barrier, causes dryness and irritation",
			"Formaldehyde releasers (DMDM Hydantoin, Diazolidinyl Urea) - linked to dermatitis and hair fall",
			"Parabens - endocrine disruptors with hormonal health concerns",
			"Hidden or undisclosed 'Base Q.S.' ingredients",
			"Token herbs added for marketing on harsh synthetic base",
			"Silicones that cause buildup and dependency cycles",
		},
	},
}

// supportedCurrencies lists all supported currencies with exchange rates.
var supportedCurrencies = []types.Currency{
	{Code: "USD", Symbol: "$", Name: "US Dollar", Country: "US", ExchangeRate: 1.0},
	{Code: "INR", Symbol: "₹", Name: "Indian Rupee", Country: "IN", ExchangeRate: 83.12},
	{Code: "GBP", Symbol: "£", Name: "British Pound", Country: "GB", ExchangeRate: 0.79},
	{Code: "EUR", Symbol: "€", Name: "Euro", Country: "EU", ExchangeRate: 0.92},
	{Code: "CAD", Symbol: "C$", Name: "Canadian Dollar", Country: "CA", ExchangeRate: 1.36},
	{Code: "AUD", Symbol: "A$", Name: "Australian Dollar", Country: "AU", ExchangeRate: 1.53},
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
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 95, MaxScore: 100},
			{Factor: "effectiveness", Score: 88, MaxScore: 100},
			{Factor: "certifications", Score: 92, MaxScore: 100},
		},
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
		PriceRange: "$12-18",
		Prices: []types.LocalizedPrice{
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 12, MaxPrice: 18, Formatted: "$12-18"},
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 997, MaxPrice: 1496, Formatted: "₹997-1496"},
			{Country: "GB", Currency: "GBP", CurrencySymbol: "£", MinPrice: 9.48, MaxPrice: 14.22, Formatted: "£9-14"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"sensitivity_relief", "cavity_prevention"},
			Philosophy: []string{"certified_organic", "modern_clean"},
			Budget:     "premium",
			Usage:      []string{"daily_use"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "sensitivity_relief", TagType: "concern", Explanation: "Hydroxyapatite helps reduce tooth sensitivity naturally"},
			{Tag: "cavity_prevention", TagType: "concern", Explanation: "Xylitol and hydroxyapatite work together to prevent cavities"},
			{Tag: "certified_organic", TagType: "philosophy", Explanation: "EWG Verified with organic ingredients"},
			{Tag: "modern_clean", TagType: "philosophy", Explanation: "Free from fluoride, SLS, and artificial sweeteners"},
			{Tag: "premium", TagType: "budget", Explanation: "Higher price point but excellent ingredient quality"},
			{Tag: "daily_use", TagType: "usage", Explanation: "Safe and gentle enough for twice-daily brushing"},
		},
		LastReviewed: "2025-12-15",
	},
	{
		ID:       "prod-002",
		Slug:     "charcoal-whitening-toothpaste",
		Name:     "Charcoal Whitening Toothpaste",
		Brand:    "BrightNaturals",
		Category: "toothpaste",
		Score:    87,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 85, MaxScore: 100},
			{Factor: "effectiveness", Score: 90, MaxScore: 100},
			{Factor: "certifications", Score: 86, MaxScore: 100},
		},
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
		PriceRange: "$10-14",
		Prices: []types.LocalizedPrice{
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 10, MaxPrice: 14, Formatted: "$10-14"},
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 831, MaxPrice: 1164, Formatted: "₹831-1164"},
			{Country: "GB", Currency: "GBP", CurrencySymbol: "£", MinPrice: 7.90, MaxPrice: 11.06, Formatted: "£8-11"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"whitening", "stain_removal"},
			Philosophy: []string{"modern_clean", "zero_chemical"},
			Budget:     "mid_range",
			Usage:      []string{"daily_use"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "whitening", TagType: "concern", Explanation: "Activated charcoal provides gentle, natural whitening"},
			{Tag: "stain_removal", TagType: "concern", Explanation: "Charcoal absorbs surface stains and toxins"},
			{Tag: "modern_clean", TagType: "philosophy", Explanation: "No harsh bleaching agents or peroxides"},
			{Tag: "zero_chemical", TagType: "philosophy", Explanation: "No artificial colors or preservatives"},
			{Tag: "mid_range", TagType: "budget", Explanation: "Affordable natural whitening option"},
			{Tag: "daily_use", TagType: "usage", Explanation: "Safe for twice-daily use"},
		},
		LastReviewed: "2025-12-10",
	},
	{
		ID:       "prod-003",
		Slug:     "kids-strawberry-toothpaste",
		Name:     "Kids Strawberry Toothpaste",
		Brand:    "LittleTeeth",
		Category: "toothpaste",
		Score:    90,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 94, MaxScore: 100},
			{Factor: "effectiveness", Score: 85, MaxScore: 100},
			{Factor: "certifications", Score: 91, MaxScore: 100},
		},
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
		PriceRange: "$8-12",
		Prices: []types.LocalizedPrice{
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 8, MaxPrice: 12, Formatted: "$8-12"},
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 665, MaxPrice: 997, Formatted: "₹665-997"},
			{Country: "GB", Currency: "GBP", CurrencySymbol: "£", MinPrice: 6.32, MaxPrice: 9.48, Formatted: "£6-9"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"kids_safe", "cavity_prevention"},
			Philosophy: []string{"certified_organic", "modern_clean"},
			Budget:     "affordable",
			Usage:      []string{"daily_use"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "kids_safe", TagType: "concern", Explanation: "Safe-to-swallow formula perfect for toddlers"},
			{Tag: "cavity_prevention", TagType: "concern", Explanation: "Xylitol helps prevent cavities naturally"},
			{Tag: "certified_organic", TagType: "philosophy", Explanation: "EWG Verified and Made Safe certified"},
			{Tag: "modern_clean", TagType: "philosophy", Explanation: "Fluoride-free and SLS-free formula"},
			{Tag: "affordable", TagType: "budget", Explanation: "Budget-friendly option for families"},
			{Tag: "daily_use", TagType: "usage", Explanation: "Gentle enough for kids' developing teeth"},
		},
		LastReviewed: "2025-12-08",
	},
	// =====================
	// SHAMPOO PRODUCTS (Curated from product_data)
	// =====================
	// 1. Forest Essentials – Hair Cleanser Bhringraj & Shikakai (Premium)
	{
		ID:       "prod-004",
		Slug:     "forest-essentials-bhringraj-shikakai",
		Name:     "Hair Cleanser Bhringraj & Shikakai",
		Brand:    "Forest Essentials",
		Category: "shampoo",
		Score:    94,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 96, MaxScore: 100},
			{Factor: "effectiveness", Score: 93, MaxScore: 100},
			{Factor: "certifications", Score: 93, MaxScore: 100},
		},
		WhyRecommended: []string{
			"Reetha-based cleansing is sulfate-free and non-stripping",
			"Neem and Shikakai control chronic dandruff without harsh chemicals",
			"Safe for frequent use on sensitive scalp",
		},
		Pros: []string{
			"Luxury Ayurvedic formulation backed by heritage brand",
			"Effective for both dandruff and dry/frizzy hair concerns",
			"No dependency cycle - scalp stays balanced long-term",
		},
		Cons: []string{
			"Premium pricing may not suit all budgets",
			"May require adjustment period from conventional shampoos",
		},
		IngredientsSummary: "Reetha (Soapnut) base, Neem extract, Shikakai, Bhringraj oil, Wheat Protein. Sulfate-free, non-stripping formulation.",
		Certifications:     []string{"Ayurvedic Heritage"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Forest Essentials", URL: "https://www.forestessentialsindia.com/hair-cleanser-bhringraj-and-shikakai.html"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/Forest-Essentials-Cleanser-Bhringraj-Shikakai/dp/B07D8NQNZT"},
			{Vendor: "Nykaa", URL: "https://www.nykaa.com/forest-essentials-hair-cleanser-bhringraj-shikakai/p/287932"},
		},
		PriceRange: "₹1,295-1,495",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 1295, MaxPrice: 1495, Formatted: "₹1,295-1,495"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 15.50, MaxPrice: 18, Formatted: "$15.50-18"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"dandruff_safe", "dry_frizzy", "sensitive_scalp"},
			Philosophy: []string{"ayurvedic"},
			Budget:     "premium",
			Usage:      []string{"daily_use"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "dandruff_safe", TagType: "concern", Explanation: "Neem and Shikakai provide natural antifungal properties without harsh medicated chemistry"},
			{Tag: "dry_frizzy", TagType: "concern", Explanation: "Wheat Protein repairs dry, frizzy hair without artificial smoothness"},
			{Tag: "sensitive_scalp", TagType: "concern", Explanation: "Reetha base is gentle enough for chronic sensitive scalp conditions"},
			{Tag: "ayurvedic", TagType: "philosophy", Explanation: "Heritage Ayurvedic formulation with traditional herbs"},
			{Tag: "premium", TagType: "budget", Explanation: "Luxury positioning at ₹1,295-1,495"},
			{Tag: "daily_use", TagType: "usage", Explanation: "Non-stripping formula safe for frequent use"},
		},
		LastReviewed: "2026-01-01",
	},
	// 2. Sadhev – Ayurvedic Anti-Dandruff Shampoo (Mid-range)
	{
		ID:       "prod-005",
		Slug:     "sadhev-anti-dandruff",
		Name:     "Ayurvedic Anti-Dandruff Shampoo",
		Brand:    "Sadhev",
		Category: "shampoo",
		Score:    89,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 90, MaxScore: 100},
			{Factor: "effectiveness", Score: 88, MaxScore: 100},
			{Factor: "certifications", Score: 89, MaxScore: 100},
		},
		WhyRecommended: []string{
			"Ayurvedic therapeutic blend targets persistent dandruff",
			"Neem and Rosemary provide antifungal benefits",
			"Value-conscious option without compromising efficacy",
		},
		Pros: []string{
			"Effective dandruff control at mid-range pricing",
			"Bakuchi provides unique anti-dandruff benefits",
			"Mild surfactants suitable for regular use",
		},
		Cons: []string{
			"Less widely available than mainstream brands",
			"Herbal scent may not appeal to everyone",
		},
		IngredientsSummary: "Neem extract, Rosemary essential oil, Bakuchi (Psoralea corylifolia), mild surfactants. Ayurvedic therapeutic blend.",
		Certifications:     []string{"Ayurvedic"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Sadhev", URL: "https://www.sadhev.com/collections/hair-care"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/Sadhev-Ayurvedic-Anti-Dandruff-Shampoo/dp/B09EXAMPLE"},
		},
		PriceRange: "₹495-595",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 495, MaxPrice: 595, Formatted: "₹495-595"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 6, MaxPrice: 7.15, Formatted: "$6-7.15"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"dandruff_safe"},
			Philosophy: []string{"ayurvedic"},
			Budget:     "mid_range",
			Usage:      []string{"alternate_day"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "dandruff_safe", TagType: "concern", Explanation: "Neem and Bakuchi combination targets persistent dandruff effectively"},
			{Tag: "ayurvedic", TagType: "philosophy", Explanation: "Traditional Ayurvedic therapeutic blend"},
			{Tag: "mid_range", TagType: "budget", Explanation: "Good balance of efficacy and affordability at ₹495-595"},
			{Tag: "alternate_day", TagType: "usage", Explanation: "Therapeutic blend works best with alternate-day use"},
		},
		LastReviewed: "2026-01-01",
	},
	// 3. Just Herbs – 8-in-1 Root Nourishing Amla Neem Shampoo (Affordable)
	{
		ID:       "prod-006",
		Slug:     "just-herbs-amla-neem",
		Name:     "8-in-1 Root Nourishing Amla Neem Shampoo",
		Brand:    "Just Herbs",
		Category: "shampoo",
		Score:    86,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 87, MaxScore: 100},
			{Factor: "effectiveness", Score: 84, MaxScore: 100},
			{Factor: "certifications", Score: 87, MaxScore: 100},
		},
		WhyRecommended: []string{
			"Decyl Glucoside base is extremely gentle on scalp",
			"Amla and Hibiscus provide herbal nourishment",
			"Perfect for dandruff maintenance and prevention",
		},
		Pros: []string{
			"Most affordable clean shampoo option",
			"8-in-1 formula addresses multiple hair concerns",
			"Gentle enough for daily use",
		},
		Cons: []string{
			"May not be strong enough for severe dandruff",
			"Lower foam level than conventional shampoos",
		},
		IngredientsSummary: "Decyl Glucoside base, Neem extract, Amla extract, Hibiscus. Mild herbal cleanser.",
		Certifications:     []string{"Vegan Certified"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Just Herbs", URL: "https://justherbs.in/products/herbal-anti-dandruff-shampoo"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/Just-Herbs-Nourishing-Shampoo-200ml/dp/B07H8WNPK4"},
			{Vendor: "Nykaa", URL: "https://www.nykaa.com/just-herbs-8-in-1-root-nourishing-amla-neem-shampoo/p/303453"},
		},
		PriceRange: "₹345-425",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 345, MaxPrice: 425, Formatted: "₹345-425"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 4.15, MaxPrice: 5.10, Formatted: "$4.15-5.10"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"dandruff_safe", "oily_scalp"},
			Philosophy: []string{"modern_clean"},
			Budget:     "affordable",
			Usage:      []string{"daily_use"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "dandruff_safe", TagType: "concern", Explanation: "Entry-level clean option for early-stage dandruff and maintenance"},
			{Tag: "oily_scalp", TagType: "concern", Explanation: "Gentle enough to not trigger rebound oil production"},
			{Tag: "modern_clean", TagType: "philosophy", Explanation: "Decyl Glucoside base is among the gentlest surfactants available"},
			{Tag: "affordable", TagType: "budget", Explanation: "Budget-friendly at ₹345-425"},
			{Tag: "daily_use", TagType: "usage", Explanation: "Mild formula suitable for daily maintenance"},
		},
		LastReviewed: "2026-01-01",
	},
	// 4. SoulTree – Licorice Hair Repair Shampoo with Bhringraj (Premium)
	{
		ID:       "prod-007",
		Slug:     "soultree-licorice-bhringraj",
		Name:     "Licorice Hair Repair Shampoo with Bhringraj",
		Brand:    "SoulTree",
		Category: "shampoo",
		Score:    93,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 95, MaxScore: 100},
			{Factor: "effectiveness", Score: 91, MaxScore: 100},
			{Factor: "certifications", Score: 93, MaxScore: 100},
		},
		WhyRecommended: []string{
			"BDIH certification ensures highest formulation standards",
			"Bhringraj supports hair growth cycle naturally",
			"Biodegradable surfactants are gentle yet effective",
		},
		Pros: []string{
			"BDIH certified - highest verification standard",
			"Licorice soothes irritated scalp",
			"Excellent for hair fall and weak roots",
		},
		Cons: []string{
			"Higher price point in mid-range category",
			"Results take consistent use to show",
		},
		IngredientsSummary: "Bhringraj extract, Licorice (Mulethi), Aloe Vera juice, biodegradable surfactants. BDIH certified.",
		Certifications:     []string{"BDIH"},
		BuyLinks: []types.BuyLink{
			{Vendor: "SoulTree", URL: "https://soultree.in/collections/hair-care/products/licorice-hair-repair-shampoo"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/SoulTree-Licorice-Hair-Repair-Shampoo/dp/B07D8EXAMPLE"},
		},
		PriceRange: "₹595-695",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 595, MaxPrice: 695, Formatted: "₹595-695"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 7.15, MaxPrice: 8.35, Formatted: "$7.15-8.35"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"hair_fall_support"},
			Philosophy: []string{"certified_organic"},
			Budget:     "mid_range",
			Usage:      []string{"alternate_day"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "hair_fall_support", TagType: "concern", Explanation: "Bhringraj and Licorice support hair growth cycle and strengthen weak roots"},
			{Tag: "certified_organic", TagType: "philosophy", Explanation: "BDIH certified - strongest certification-backed option in this segment"},
			{Tag: "mid_range", TagType: "budget", Explanation: "Premium quality at ₹595-695"},
			{Tag: "alternate_day", TagType: "usage", Explanation: "Best results with consistent alternate-day use"},
		},
		LastReviewed: "2026-01-01",
	},
	// 5. Kama Ayurveda – Bringadi Hair Cleanser (Mid-range)
	{
		ID:       "prod-008",
		Slug:     "kama-bringadi-cleanser",
		Name:     "Bringadi Hair Cleanser",
		Brand:    "Kama Ayurveda",
		Category: "shampoo",
		Score:    90,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 91, MaxScore: 100},
			{Factor: "effectiveness", Score: 90, MaxScore: 100},
			{Factor: "certifications", Score: 89, MaxScore: 100},
		},
		WhyRecommended: []string{
			"Amino-acid based surfactants are gentle on fragile hair",
			"Traditional Bringadi herbs support hair health",
			"Suitable for chemically treated hair",
		},
		Pros: []string{
			"Premium brand with clinical positioning",
			"Safe for chemically treated and fragile hair",
			"Traditional herbs in modern mild formulation",
		},
		Cons: []string{
			"Premium pricing",
			"May not provide instant smoothness some expect",
		},
		IngredientsSummary: "Bringadi herbal complex, Aloe Vera, essential oils, amino-acid based surfactants. Clinically positioned formula.",
		Certifications:     []string{"GMP Certified"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Kama Ayurveda", URL: "https://www.kamaayurveda.com/bringadi-hair-cleanser.html"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/Kama-Ayurveda-Bringadi-Intensive-Cleanser/dp/B01N5EXAMPLE"},
			{Vendor: "Nykaa", URL: "https://www.nykaa.com/kama-ayurveda-bringadi-hair-cleanser/p/287654"},
		},
		PriceRange: "₹795-995",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 795, MaxPrice: 995, Formatted: "₹795-995"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 9.55, MaxPrice: 11.95, Formatted: "$9.55-11.95"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"hair_fall_support"},
			Philosophy: []string{"modern_clean"},
			Budget:     "mid_range",
			Usage:      []string{"alternate_day"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "hair_fall_support", TagType: "concern", Explanation: "Bringadi herbs support hair health for fragile and falling hair"},
			{Tag: "modern_clean", TagType: "philosophy", Explanation: "Amino-acid based surfactants balance traditional herbs with modern chemistry"},
			{Tag: "mid_range", TagType: "budget", Explanation: "Premium positioning at ₹795-995"},
			{Tag: "alternate_day", TagType: "usage", Explanation: "Optimal for alternate-day washing"},
		},
		LastReviewed: "2026-01-01",
	},
	// 6. Vilvah – Goat Milk Shampoo (Affordable)
	{
		ID:       "prod-009",
		Slug:     "vilvah-goat-milk",
		Name:     "Goat Milk Shampoo",
		Brand:    "Vilvah",
		Category: "shampoo",
		Score:    88,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 89, MaxScore: 100},
			{Factor: "effectiveness", Score: 87, MaxScore: 100},
			{Factor: "certifications", Score: 88, MaxScore: 100},
		},
		WhyRecommended: []string{
			"Goat Milk provides gentle cleansing without stripping",
			"pH balanced at 5.5-6 for optimal scalp health",
			"Prevents oil rebound cycle common with harsh shampoos",
		},
		Pros: []string{
			"Unique Goat Milk formula for gentle cleansing",
			"Perfect transition from mass-market shampoos",
			"Suitable for both oily scalp and hair fall concerns",
		},
		Cons: []string{
			"Goat Milk scent may take getting used to",
			"May need conditioner for very dry hair",
		},
		IngredientsSummary: "Goat Milk protein, Pea Protein, Sarcosinate-based surfactants, pH balanced (5.5-6).",
		Certifications:     []string{"BIS Compliant"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Vilvah", URL: "https://vilvahstore.com/products/goatmilk-shampoo"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/Vilvah-Goat-Milk-Shampoo/dp/B08EXAMPLE"},
		},
		PriceRange: "₹450-550",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 450, MaxPrice: 550, Formatted: "₹450-550"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 5.40, MaxPrice: 6.60, Formatted: "$5.40-6.60"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"hair_fall_support", "oily_scalp"},
			Philosophy: []string{"modern_clean"},
			Budget:     "affordable",
			Usage:      []string{"daily_use", "alternate_day"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "hair_fall_support", TagType: "concern", Explanation: "Pea Protein strengthens hair to reduce breakage-related hair fall"},
			{Tag: "oily_scalp", TagType: "concern", Explanation: "Non-stripping formula prevents oil rebound cycle"},
			{Tag: "modern_clean", TagType: "philosophy", Explanation: "Sarcosinate-based surfactants are gentle yet effective"},
			{Tag: "affordable", TagType: "budget", Explanation: "Excellent value at ₹450-550"},
			{Tag: "daily_use", TagType: "usage", Explanation: "Gentle enough for daily or alternate-day use"},
		},
		LastReviewed: "2026-01-01",
	},
	// 7. Kama Ayurveda – Rose & Jasmine Hair Cleanser (Premium)
	{
		ID:       "prod-010",
		Slug:     "kama-rose-jasmine",
		Name:     "Rose & Jasmine Hair Cleanser",
		Brand:    "Kama Ayurveda",
		Category: "shampoo",
		Score:    91,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 93, MaxScore: 100},
			{Factor: "effectiveness", Score: 90, MaxScore: 100},
			{Factor: "certifications", Score: 90, MaxScore: 100},
		},
		WhyRecommended: []string{
			"Extremely mild surfactants protect color-treated hair",
			"Essential oil conditioning without silicone buildup",
			"Rose and Jasmine provide gentle aromatherapy benefits",
		},
		Pros: []string{
			"Gentlest cleanser for color-treated hair",
			"Beautiful natural fragrance",
			"No silicone buildup over time",
		},
		Cons: []string{
			"Premium price point",
			"Very mild - may not suit very oily scalps",
		},
		IngredientsSummary: "Rose extract, Jasmine essential oil, Aloe Vera gel, extremely mild surfactants. Essential oil conditioning.",
		Certifications:     []string{"GMP Certified"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Kama Ayurveda", URL: "https://www.kamaayurveda.com/rose-jasmine-hair-cleanser.html"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/Kama-Ayurveda-Rose-Jasmine-Cleanser/dp/B07EXAMPLE"},
			{Vendor: "Nykaa", URL: "https://www.nykaa.com/kama-ayurveda-rose-jasmine-hair-cleanser/p/315432"},
		},
		PriceRange: "₹895-1,095",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 895, MaxPrice: 1095, Formatted: "₹895-1,095"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 10.75, MaxPrice: 13.15, Formatted: "$10.75-13.15"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"dry_frizzy"},
			Philosophy: []string{"modern_clean"},
			Budget:     "premium",
			Usage:      []string{"daily_use"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "dry_frizzy", TagType: "concern", Explanation: "Extremely mild surfactants and essential oil conditioning for colored, heat-damaged, or fragile hair"},
			{Tag: "modern_clean", TagType: "philosophy", Explanation: "No silicone buildup - natural conditioning from essential oils"},
			{Tag: "premium", TagType: "budget", Explanation: "Luxury positioning at ₹895-1,095"},
			{Tag: "daily_use", TagType: "usage", Explanation: "Gentle enough for daily washing"},
		},
		LastReviewed: "2026-01-01",
	},
	// 8. Arata – Super Shampoo (Affordable)
	{
		ID:       "prod-011",
		Slug:     "arata-super-shampoo",
		Name:     "Super Shampoo",
		Brand:    "Arata",
		Category: "shampoo",
		Score:    87,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 88, MaxScore: 100},
			{Factor: "effectiveness", Score: 86, MaxScore: 100},
			{Factor: "certifications", Score: 87, MaxScore: 100},
		},
		WhyRecommended: []string{
			"Apple Cider Vinegar balances scalp pH naturally",
			"Onion Oil supports hair strength and growth",
			"SCI-based foam provides satisfying wash experience",
		},
		Pros: []string{
			"Modern formulation with proven ingredients",
			"Good sensory experience with creamy foam",
			"Addresses urban pollution and frizz",
		},
		Cons: []string{
			"Onion oil scent lingers slightly",
			"May not suit traditional fragrance preferences",
		},
		IngredientsSummary: "Onion Oil, Argan Oil, Apple Cider Vinegar, SCI-based creamy foam, pH-balancing ingredients.",
		Certifications:     []string{"Vegan Certified"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Arata", URL: "https://arata.in/products/super-shampoo"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/Arata-Super-Shampoo-Onion-Oil/dp/B09EXAMPLE"},
			{Vendor: "Nykaa", URL: "https://www.nykaa.com/arata-super-shampoo/p/456789"},
		},
		PriceRange: "₹349-449",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 349, MaxPrice: 449, Formatted: "₹349-449"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 4.20, MaxPrice: 5.40, Formatted: "$4.20-5.40"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"dry_frizzy"},
			Philosophy: []string{"modern_clean"},
			Budget:     "affordable",
			Usage:      []string{"daily_use"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "dry_frizzy", TagType: "concern", Explanation: "Argan Oil and Apple Cider Vinegar address urban pollution exposure and frizz"},
			{Tag: "modern_clean", TagType: "philosophy", Explanation: "SCI-based creamy foam with pH-balancing for modern clean formulation"},
			{Tag: "affordable", TagType: "budget", Explanation: "Budget-friendly at ₹349-449"},
			{Tag: "daily_use", TagType: "usage", Explanation: "Suitable for daily washing"},
		},
		LastReviewed: "2026-01-01",
	},
	// 9. The Tribe Concepts – Hair Cleanser Powder (Niche/Traditional)
	{
		ID:       "prod-012",
		Slug:     "tribe-concepts-powder",
		Name:     "Hair Cleanser Powder",
		Brand:    "The Tribe Concepts",
		Category: "shampoo",
		Score:    85,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 98, MaxScore: 100},
			{Factor: "effectiveness", Score: 78, MaxScore: 100},
			{Factor: "certifications", Score: 79, MaxScore: 100},
		},
		WhyRecommended: []string{
			"100% botanical with zero synthetic ingredients",
			"Traditional Reetha-Shikakai-Amla combination",
			"Maximum purity for ultra-sensitive scalps",
		},
		Pros: []string{
			"Zero synthetic ingredients - pure botanical",
			"Traditional time-tested formula",
			"Ideal for ingredient purists and sensitive users",
		},
		Cons: []string{
			"Requires effort and technique to use powder format",
			"Not ideal for heavy oil or product buildup",
			"No foam - different experience than liquid shampoo",
		},
		IngredientsSummary: "Reetha (Soapnut) powder, Shikakai powder, Amla powder. No preservatives, no surfactants, 100% botanical.",
		Certifications:     []string{},
		BuyLinks: []types.BuyLink{
			{Vendor: "The Tribe Concepts", URL: "https://thetribeconcepts.com/products/hair-cleanser-powder"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/Tribe-Concepts-Hair-Cleanser-Powder/dp/B08EXAMPLE"},
		},
		PriceRange: "₹295-395",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 295, MaxPrice: 395, Formatted: "₹295-395"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 3.55, MaxPrice: 4.75, Formatted: "$3.55-4.75"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"sensitive_scalp"},
			Philosophy: []string{"zero_chemical", "ayurvedic"},
			Budget:     "affordable",
			Usage:      []string{"weekly_detox"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "sensitive_scalp", TagType: "concern", Explanation: "Maximum purity with zero synthetic ingredients for ultra-sensitive scalps"},
			{Tag: "zero_chemical", TagType: "philosophy", Explanation: "100% botanical - no preservatives, no surfactants"},
			{Tag: "ayurvedic", TagType: "philosophy", Explanation: "Traditional Reetha-Shikakai-Amla formulation"},
			{Tag: "affordable", TagType: "budget", Explanation: "Budget-friendly at ₹295-395"},
			{Tag: "weekly_detox", TagType: "usage", Explanation: "Best used as weekly detox, not ideal for daily use"},
		},
		LastReviewed: "2026-01-01",
	},
	// 10. Earth Rhythm – Murumuru Butter Shampoo Bar (Sustainable)
	{
		ID:       "prod-013",
		Slug:     "earth-rhythm-shampoo-bar",
		Name:     "Murumuru Butter Shampoo Bar",
		Brand:    "Earth Rhythm",
		Category: "shampoo",
		Score:    86,
		ScoreBreakdown: []types.ScoreBreakdown{
			{Factor: "ingredient_safety", Score: 87, MaxScore: 100},
			{Factor: "effectiveness", Score: 84, MaxScore: 100},
			{Factor: "certifications", Score: 87, MaxScore: 100},
		},
		WhyRecommended: []string{
			"Plastic-free packaging reduces environmental impact",
			"SCI-based bar (not soap) works in hard water",
			"Murumuru Butter provides natural conditioning",
		},
		Pros: []string{
			"Zero plastic waste packaging",
			"Travel-friendly solid format",
			"Works well even in hard water areas",
		},
		Cons: []string{
			"Bar format needs proper storage",
			"Takes practice to lather effectively",
		},
		IngredientsSummary: "Murumuru Butter, Vitamin E, SCI-based (not soap), hard water compatible.",
		Certifications:     []string{"Vegan Certified"},
		BuyLinks: []types.BuyLink{
			{Vendor: "Earth Rhythm", URL: "https://earthrhythm.in/products/murumuru-butter-shampoo-bar"},
			{Vendor: "Amazon India", URL: "https://www.amazon.in/Earth-Rhythm-Murumuru-Butter-Shampoo/dp/B08EXAMPLE"},
			{Vendor: "Nykaa", URL: "https://www.nykaa.com/earth-rhythm-murumuru-shampoo-bar/p/567890"},
		},
		PriceRange: "₹350-450",
		Prices: []types.LocalizedPrice{
			{Country: "IN", Currency: "INR", CurrencySymbol: "₹", MinPrice: 350, MaxPrice: 450, Formatted: "₹350-450"},
			{Country: "US", Currency: "USD", CurrencySymbol: "$", MinPrice: 4.20, MaxPrice: 5.40, Formatted: "$4.20-5.40"},
		},
		Tags: &types.ProductTags{
			Concern:    []string{"dry_frizzy"},
			Philosophy: []string{"solid_bar", "modern_clean"},
			Budget:     "affordable",
			Usage:      []string{"alternate_day"},
		},
		TagExplanations: []types.TagExplanation{
			{Tag: "dry_frizzy", TagType: "concern", Explanation: "Murumuru Butter provides natural conditioning for dry, frizzy hair"},
			{Tag: "solid_bar", TagType: "philosophy", Explanation: "Plastic-free sustainable option with minimal environmental impact"},
			{Tag: "modern_clean", TagType: "philosophy", Explanation: "SCI-based (not soap) works in hard water areas"},
			{Tag: "affordable", TagType: "budget", Explanation: "Budget-friendly at ₹350-450"},
			{Tag: "alternate_day", TagType: "usage", Explanation: "Best for alternate-day use"},
		},
		LastReviewed: "2026-01-01",
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
	criteria := categoryCriteria[slug]
	productSummaries := GetProductSummariesByCategory(slug)

	return &types.Category{
		Slug:            cat.Slug,
		Title:           cat.Title,
		LongDescription: longDesc,
		Criteria:        criteria,
		CriteriaVersion: "1.0",
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

// GetSimilarProducts returns products similar to the given product slug.
func GetSimilarProducts(slug string, limit int) ([]types.ProductSummary, error) {
	product, err := GetProduct(slug)
	if err != nil {
		return nil, err
	}

	if limit <= 0 {
		limit = 6
	}

	var similar []types.ProductSummary
	for _, p := range products {
		// Skip the same product
		if p.Slug == slug {
			continue
		}

		// Include products from the same category
		if p.Category == product.Category {
			similar = append(similar, toProductSummary(p))
		}

		if len(similar) >= limit {
			break
		}
	}

	return similar, nil
}

// GetCurrencies returns all supported currencies with exchange rates.
func GetCurrencies() types.CurrencyList {
	return types.CurrencyList{
		BaseCurrency: "USD",
		Currencies:   supportedCurrencies,
	}
}

// FilterOption represents a single filter option with count.
type FilterOption struct {
	Value string `json:"value"`
	Label string `json:"label"`
	Count int    `json:"count"`
}

// AvailableFilters represents all available filter options.
type AvailableFilters struct {
	Concerns     []FilterOption `json:"concerns"`
	Philosophies []FilterOption `json:"philosophies"`
	Budgets      []FilterOption `json:"budgets"`
	Usages       []FilterOption `json:"usages"`
}

// ProductListResult represents the filtered product list with pagination.
type ProductListResult struct {
	Products   []types.ProductSummary `json:"products"`
	TotalCount int                    `json:"totalCount"`
	Page       int                    `json:"page"`
	Limit      int                    `json:"limit"`
	TotalPages int                    `json:"totalPages"`
}

// GetAvailableFilters returns the available filter options, optionally filtered by category.
func GetAvailableFilters(categorySlug string) AvailableFilters {
	concernCounts := make(map[string]int)
	philosophyCounts := make(map[string]int)
	budgetCounts := make(map[string]int)
	usageCounts := make(map[string]int)

	for _, p := range products {
		// Filter by category if specified
		if categorySlug != "" && p.Category != categorySlug {
			continue
		}

		if p.Tags != nil {
			for _, c := range p.Tags.Concern {
				concernCounts[c]++
			}
			for _, ph := range p.Tags.Philosophy {
				philosophyCounts[ph]++
			}
			if p.Tags.Budget != "" {
				budgetCounts[p.Tags.Budget]++
			}
			for _, u := range p.Tags.Usage {
				usageCounts[u]++
			}
		}
	}

	return AvailableFilters{
		Concerns:     mapToFilterOptions(concernCounts, concernLabels),
		Philosophies: mapToFilterOptions(philosophyCounts, philosophyLabels),
		Budgets:      mapToFilterOptions(budgetCounts, budgetLabels),
		Usages:       mapToFilterOptions(usageCounts, usageLabels),
	}
}

// Label mappings for filter options.
var concernLabels = map[string]string{
	"dandruff_safe":      "Dandruff Safe",
	"hair_fall_support":  "Hair Fall Support",
	"dry_frizzy":         "Dry & Frizzy",
	"oily_scalp":         "Oily Scalp",
	"sensitive_scalp":    "Sensitive Scalp",
	"sensitivity_relief": "Sensitivity Relief",
	"cavity_prevention":  "Cavity Prevention",
	"whitening":          "Whitening",
	"stain_removal":      "Stain Removal",
	"kids_safe":          "Kids Safe",
}

var philosophyLabels = map[string]string{
	"ayurvedic":         "Ayurvedic",
	"certified_organic": "Certified Organic",
	"modern_clean":      "Modern Clean",
	"zero_chemical":     "Zero Chemical",
	"solid_bar":         "Solid Bar",
}

var budgetLabels = map[string]string{
	"premium":    "Premium",
	"mid_range":  "Mid Range",
	"affordable": "Affordable",
}

var usageLabels = map[string]string{
	"daily_use":     "Daily Use",
	"alternate_day": "Alternate Day",
	"weekly_detox":  "Weekly Detox",
}

func mapToFilterOptions(counts map[string]int, labels map[string]string) []FilterOption {
	options := make([]FilterOption, 0, len(counts))
	for value, count := range counts {
		label := labels[value]
		if label == "" {
			label = value
		}
		options = append(options, FilterOption{
			Value: value,
			Label: label,
			Count: count,
		})
	}
	return options
}

// GetFilteredProducts returns products matching the given filters with pagination.
func GetFilteredProducts(category string, concerns, philosophies []string, budget string, usages []string, sortBy, order string, page, limit int) ProductListResult {
	var filtered []types.Product

	for _, p := range products {
		// Filter by category
		if category != "" && p.Category != category {
			continue
		}

		// Filter by tags
		if p.Tags == nil {
			continue
		}

		// Filter by concerns (any match)
		if len(concerns) > 0 && !hasAnyTag(p.Tags.Concern, concerns) {
			continue
		}

		// Filter by philosophies (any match)
		if len(philosophies) > 0 && !hasAnyTag(p.Tags.Philosophy, philosophies) {
			continue
		}

		// Filter by budget (exact match)
		if budget != "" && p.Tags.Budget != budget {
			continue
		}

		// Filter by usage (any match)
		if len(usages) > 0 && !hasAnyTag(p.Tags.Usage, usages) {
			continue
		}

		filtered = append(filtered, p)
	}

	// Sort results
	sortProducts(filtered, sortBy, order)

	// Calculate pagination
	totalCount := len(filtered)
	totalPages := (totalCount + limit - 1) / limit
	if page > totalPages && totalPages > 0 {
		page = totalPages
	}

	start := (page - 1) * limit
	end := start + limit
	if end > totalCount {
		end = totalCount
	}
	if start > totalCount {
		start = totalCount
	}

	// Convert to summaries
	summaries := make([]types.ProductSummary, 0, end-start)
	for i := start; i < end; i++ {
		summaries = append(summaries, toProductSummary(filtered[i]))
	}

	return ProductListResult{
		Products:   summaries,
		TotalCount: totalCount,
		Page:       page,
		Limit:      limit,
		TotalPages: totalPages,
	}
}

// hasAnyTag checks if any of the product tags match the filter tags.
func hasAnyTag(productTags, filterTags []string) bool {
	for _, pt := range productTags {
		for _, ft := range filterTags {
			if pt == ft {
				return true
			}
		}
	}
	return false
}

// sortProducts sorts the products slice in place.
func sortProducts(products []types.Product, sortBy, order string) {
	if sortBy == "" {
		sortBy = "score"
	}
	if order == "" {
		order = "desc"
	}

	// Simple bubble sort for now (small dataset)
	n := len(products)
	for i := 0; i < n-1; i++ {
		for j := 0; j < n-i-1; j++ {
			shouldSwap := false

			switch sortBy {
			case "score":
				if order == "desc" {
					shouldSwap = products[j].Score < products[j+1].Score
				} else {
					shouldSwap = products[j].Score > products[j+1].Score
				}
			case "name":
				if order == "desc" {
					shouldSwap = products[j].Name < products[j+1].Name
				} else {
					shouldSwap = products[j].Name > products[j+1].Name
				}
			}

			if shouldSwap {
				products[j], products[j+1] = products[j+1], products[j]
			}
		}
	}
}
