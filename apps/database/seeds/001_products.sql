-- Seed: 001_products.sql
-- Description: Import curated shampoo products from updated JSON data
-- Created: 2026-01-02

-- =====================
-- PRODUCTS (8 shampoos from updated JSON)
-- =====================

-- 1. Forest Essentials - Hair Cleanser Bhringraj & Shikakai
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'forest-essentials-bhringraj-shikakai-hair-cleanser',
    'Forest Essentials Hair Cleanser, Bhringraj & Shikakai',
    'Forest Essentials',
    'shampoo',
    'https://placehold.co/400x400/06b6d4/ffffff?text=Forest+Essentials',
    'active', true, false,
    88, 'v1', '2025-11-01',
    'alternate_day', 'premium',
    'Ayurvedic, sulphate-free cleanser aimed at reducing hair fall and supporting scalp health without harsh stripping.',
    ARRAY[
        'Formulated with traditional Ayurvedic herbs like bhringraj and shikakai.',
        'SLS/SLES free and gentle for regular cleansing without dryness.',
        'Supports reduction in hair thinning, breakage and promotes scalp nourishment.'
    ],
    ARRAY['Herbal formulation', 'Gentle cleansing', 'Supports hair strength'],
    ARRAY['Premium pricing', 'Herbal scent not for everyone'],
    'Shikakai, Bhringraj, Reetha, Coconut Milk, Hydrolyzed Wheat Protein, Licorice, Kalonji Seed Oil',
    ARRAY['Ayurvedic formulation'],
    ARRAY['SLS', 'SLES', 'Parabens', 'Mineral Oil']
);

-- 2. Just Herbs - 8-in-1 Root Nourishing Amla & Neem Shampoo
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'just-herbs-amla-neem-shampoo',
    '8-in-1 Root Nourishing Amla & Neem Shampoo',
    'Just Herbs',
    'shampoo',
    'https://placehold.co/400x400/f59e0b/ffffff?text=Just+Herbs',
    'active', false, true,
    82, 'v1', '2026-01-02',
    'alternate_day', 'mid_range',
    'Herbal, ingredient-transparent anti-hairfall/dandruff shampoo that is SLS/SLES- and paraben-free.',
    ARRAY[
        'Brand and product pages list active botanicals (Amla, Neem, Hibiscus, Henna, Fenugreek, Vetiver).',
        'Explicit claims show the product is free from SLS/SLES and parabens.',
        'Formulation is plant-forward and positioned for routine use for oily/dandruff-prone scalps.'
    ],
    ARRAY['Transparent ingredient listing', 'SLS/SLES & paraben free', 'Herbal actives for dandruff/hair fall'],
    ARRAY['No major ECOCERT/COSMOS certification', 'May include mild synthetic emulsifiers'],
    'Amla, Hibiscus, Henna, Fenugreek, Neem, Vetiver, Wheatgerm Oil, Soy Lecithin',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'SLES', 'Parabens', 'PEG/PPG', 'Petrochemicals']
);

-- 3. SoulTree - Licorice Hair Repair Shampoo with Strengthening Bhringraj
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'soultree-licorice-bhringraj-shampoo',
    'SoulTree Licorice Hair Repair Shampoo with Bhringraj',
    'SoulTree',
    'shampoo',
    'https://placehold.co/400x400/10b981/ffffff?text=SoulTree',
    'active', true, true,
    90, 'v1', '2026-01-02',
    'alternate_day', 'premium',
    'BDIH-certified, herb-forward shampoo using mild surfactants that avoid sulfates and parabens.',
    ARRAY[
        'Full ingredient panel published (no hidden base q.s.).',
        'Uses mild surfactants (Coco glucoside, Lauryl glucoside) rather than SLS/SLES.',
        'Contains functional Ayurvedic botanicals (Licorice, Bhringraj, Shikakai, Amla).',
        'Certified Natural under BDIH - a strong trust signal.'
    ],
    ARRAY['BDIH certified (natural)', 'Transparent INCI', 'Mild surfactants and preservatives'],
    ARRAY['Contains fragrance with Linalool/Limonene', 'Premium price point'],
    'Coco-glucoside, Lauryl glucoside, Sodium cocoyl glutamate, Licorice, Bhringraj, Shikakai, Amla, Hibiscus, Henna, Aloe, Hydrolysed wheat protein',
    ARRAY['BDIH'],
    ARRAY['SLS', 'SLES', 'Parabens', 'Silicones', 'Mineral oil', 'Phthalates', 'Formaldehyde releasers']
);

-- 4. Kama Ayurveda - Bringadi Hair Cleanser
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'kama-ayurveda-bringadi-cleanser',
    'Bringadi Hair Cleanser (Nourishing Shampoo)',
    'Kama Ayurveda',
    'shampoo',
    'https://placehold.co/400x400/8b5cf6/ffffff?text=Kama+Ayurveda',
    'active', true, true,
    88, 'v1', '2026-01-02',
    'alternate_day', 'premium',
    '96% natural-origin cleanser using mild surfactants - suitable for coloured/treated hair.',
    ARRAY[
        'Full INCI published; surfactants are mild glucosides rather than sulfates.',
        'Contains functional Ayurvedic actives (Bhringraj, Amla, Indigo, Licorice, Shikakai).',
        'Product marketed for treated/coloured hair (lower risk of stripping).'
    ],
    ARRAY['Transparent INCI', 'Mild surfactant system', 'Ayurvedic actives'],
    ARRAY['Premium price point', 'Contains fragrance'],
    'Lauryl Glucoside, Disodium Cocoyl Glutamate, Sodium Cocoamphoacetate, Bhringraj, Amla, Indigo, Licorice, Shikakai, Hibiscus',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']
);

-- 5. Vilvah - Goat Milk Shampoo
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'vilvah-goat-milk-shampoo',
    'Goat Milk Shampoo (with Ceramides & Pea Protein)',
    'Vilvah',
    'shampoo',
    'https://placehold.co/400x400/ec4899/ffffff?text=Vilvah',
    'active', false, true,
    80, 'v1', '2026-01-02',
    'alternate_day', 'affordable',
    'pH-balanced, sulphate-free shampoo with ceramides and pea protein for dry/frizzy hair.',
    ARRAY[
        'Brand publishes ingredient panel and markets as pH-balanced and sulphate-free.',
        'Key actives - Goat Milk, Ceramides, Pea Protein - support moisture and barrier repair.',
        'Uses mild surfactants (cocamidopropyl betaine, coco-glucoside) rather than SLS/SLES.'
    ],
    ARRAY['Transparent INCI', 'Mild surfactant system', 'Functional actives for frizz control'],
    ARRAY['Contains fragrance', 'Not positioned as anti-dandruff'],
    'Goat Milk, Jasmine Hydrosol, Cocamidopropyl Betaine, Coco-Glucoside, Pea Protein, Ceramides, Hydrolysed Wheat Protein',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde releasers']
);

-- 6. Arata - Super Shampoo
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'arata-super-shampoo',
    'Arata Super Shampoo (Onion + Argan + Apple Cider Vinegar)',
    'Arata',
    'shampoo',
    'https://placehold.co/400x400/ef4444/ffffff?text=Arata',
    'active', false, true,
    84, 'v1', '2026-01-02',
    'alternate_day', 'affordable',
    'Mild, pH-friendly shampoo with onion oil, argan oil and apple-cider vinegar for hair-fall and scalp balance.',
    ARRAY[
        'Full ingredient list published on brand page (transparent INCI).',
        'Uses gentle surfactants (Sodium Cocoyl Isethionate, Cocamidopropyl Betaine) instead of SLS/SLES.',
        'Contains functional actives for hair fall and scalp balance (Onion oil, Argan oil, Apple Cider Vinegar).'
    ],
    ARRAY['Transparent INCI', 'Mild surfactant system (SCI)', 'Functional botanicals for scalp support'],
    ARRAY['Contains fragrance', 'Not ECOCERT/BDIH certified'],
    'Sodium Cocoyl Isethionate, Sodium Cocoyl Glycinate, Cocamidopropyl Betaine, Aloe Vera, Bhringraj, Pea Protein, Apple Cider Vinegar, Argan Oil, Onion Oil',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']
);

-- 7. The Tribe Concepts - Organic Hair Cleanser Powder
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'tribe-concepts-hair-cleanser-powder',
    'Organic Hair Cleanser (Powdered Shikakai, Amla & Hibiscus)',
    'The Tribe Concepts',
    'shampoo',
    'https://placehold.co/400x400/84cc16/ffffff?text=Tribe+Concepts',
    'active', false, true,
    78, 'v1', '2026-01-02',
    'weekly_detox', 'mid_range',
    '100% botanical powdered cleanser - chemical-free and suitable as a gentle weekly detox.',
    ARRAY[
        'Pure botanical powders (Shikakai, Amla, Hibiscus) - no synthetic surfactants.',
        'Claims chemical-free, paraben/sulphate/SLS free with Godavari farms sourcing.',
        'Good match for sensitive scalps or users seeking zero-chemical weekly cleanse.'
    ],
    ARRAY['Maximum ingredient purity', 'Transparent botanical list', 'Eco/sustainable packaging'],
    ARRAY['Inconvenient for daily use', 'Limited efficacy for heavy/oily scalps'],
    'Powdered Reetha, Shikakai, Amla, Hibiscus (organic herbs from Godavari region)',
    ARRAY[]::TEXT[],
    ARRAY['All synthetic surfactants', 'Parabens', 'Preservatives']
);

-- 8. Earth Rhythm - Murumuru Butter Shampoo Bar
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'earth-rhythm-murumuru-shampoo-bar',
    'Murumuru Butter Shampoo Bar',
    'Earth Rhythm',
    'shampoo',
    'https://placehold.co/400x400/0ea5e9/ffffff?text=Earth+Rhythm',
    'active', false, true,
    82, 'v1', '2026-01-02',
    'alternate_day', 'mid_range',
    'Plastic-free, SCI-based shampoo bar - gentle, pH-friendly cleansing for dry/frizzy hair.',
    ARRAY[
        'Formulated with Sodium Cocoyl Isethionate (SCI) rather than SLS, reducing scalp irritation.',
        'Murumuru butter provides conditioning lipids for dry, frizzy hair without silicone residue.',
        'Solid bar format reduces plastic waste and is travel-friendly.'
    ],
    ARRAY['Low waste / plastic-free', 'SCI-based (gentle)', 'Conditioning murumuru butter'],
    ARRAY['Learning curve for bar use', 'May contain fragrance'],
    'Murumuru butter, Sodium Cocoyl Isethionate, Glycerin, Botanical oils, Tocopherol (vitamin E)',
    ARRAY[]::TEXT[],
    ARRAY['Soap base', 'SLS', 'SLES', 'Parabens']
);

-- =====================
-- PRIMARY CONCERNS (Tags) - using product_id from inserted products
-- =====================

-- Forest Essentials concerns
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser' 
AND c.code IN ('hair_fall_support', 'dandruff_safe');

-- Just Herbs concerns
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'just-herbs-amla-neem-shampoo' 
AND c.code IN ('dandruff_safe', 'hair_fall_support', 'oily_scalp');

-- SoulTree concerns
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'soultree-licorice-bhringraj-shampoo' 
AND c.code IN ('hair_fall_support', 'dry_frizzy');

-- Kama Ayurveda concerns
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'kama-ayurveda-bringadi-cleanser' 
AND c.code IN ('hair_fall_support', 'dandruff_safe', 'oily_scalp');

-- Vilvah concerns
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'vilvah-goat-milk-shampoo' 
AND c.code IN ('dry_frizzy', 'hair_fall_support');

-- Arata concerns
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'arata-super-shampoo' 
AND c.code IN ('hair_fall_support', 'dandruff_safe', 'dry_frizzy');

-- Tribe Concepts concerns
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'tribe-concepts-hair-cleanser-powder' 
AND c.code IN ('sensitive_scalp');

-- Earth Rhythm concerns
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'earth-rhythm-murumuru-shampoo-bar' 
AND c.code IN ('dry_frizzy');

-- =====================
-- PHILOSOPHY TAGS
-- =====================

-- Forest Essentials philosophy
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, t.code FROM products p, philosophy_tags t 
WHERE p.slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser' 
AND t.code IN ('ayurvedic');

-- Just Herbs philosophy
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, t.code FROM products p, philosophy_tags t 
WHERE p.slug = 'just-herbs-amla-neem-shampoo' 
AND t.code IN ('ayurvedic');

-- SoulTree philosophy
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, t.code FROM products p, philosophy_tags t 
WHERE p.slug = 'soultree-licorice-bhringraj-shampoo' 
AND t.code IN ('ayurvedic', 'certified_organic');

-- Kama Ayurveda philosophy
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, t.code FROM products p, philosophy_tags t 
WHERE p.slug = 'kama-ayurveda-bringadi-cleanser' 
AND t.code IN ('ayurvedic');

-- Vilvah philosophy
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, t.code FROM products p, philosophy_tags t 
WHERE p.slug = 'vilvah-goat-milk-shampoo' 
AND t.code IN ('modern_clean');

-- Arata philosophy
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, t.code FROM products p, philosophy_tags t 
WHERE p.slug = 'arata-super-shampoo' 
AND t.code IN ('modern_clean');

-- Tribe Concepts philosophy
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, t.code FROM products p, philosophy_tags t 
WHERE p.slug = 'tribe-concepts-hair-cleanser-powder' 
AND t.code IN ('zero_chemical', 'ayurvedic');

-- Earth Rhythm philosophy
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, t.code FROM products p, philosophy_tags t 
WHERE p.slug = 'earth-rhythm-murumuru-shampoo-bar' 
AND t.code IN ('solid_bar', 'modern_clean');

-- =====================
-- BUY LINKS
-- =====================

-- Forest Essentials buy links
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Amazon', 'https://a.co/d/3rWo6GR', 'affiliate' FROM products p WHERE p.slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products p WHERE p.slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser';

-- Just Herbs buy links
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Amazon', 'https://amzn.in/d/guRv2SD', 'affiliate' FROM products p WHERE p.slug = 'just-herbs-amla-neem-shampoo';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products p WHERE p.slug = 'just-herbs-amla-neem-shampoo';

-- SoulTree buy links
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Amazon', 'https://amzn.in/d/60xTpP8', 'affiliate' FROM products p WHERE p.slug = 'soultree-licorice-bhringraj-shampoo';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products p WHERE p.slug = 'soultree-licorice-bhringraj-shampoo';

-- Kama Ayurveda buy links
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Amazon', 'https://amzn.in/d/6mmpChY', 'affiliate' FROM products p WHERE p.slug = 'kama-ayurveda-bringadi-cleanser';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products p WHERE p.slug = 'kama-ayurveda-bringadi-cleanser';

-- Vilvah buy links
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Amazon', 'https://amzn.in/d/bGnBqar', 'affiliate' FROM products p WHERE p.slug = 'vilvah-goat-milk-shampoo';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products p WHERE p.slug = 'vilvah-goat-milk-shampoo';

-- Arata buy links
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Amazon', 'https://amzn.in/d/axLaYgb', 'affiliate' FROM products p WHERE p.slug = 'arata-super-shampoo';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products p WHERE p.slug = 'arata-super-shampoo';

-- Tribe Concepts buy links
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Amazon', 'https://amzn.in/d/2YoSmJk', 'affiliate' FROM products p WHERE p.slug = 'tribe-concepts-hair-cleanser-powder';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products p WHERE p.slug = 'tribe-concepts-hair-cleanser-powder';

-- Earth Rhythm buy links
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Amazon', 'https://amzn.in/d/fWlyCj7', 'affiliate' FROM products p WHERE p.slug = 'earth-rhythm-murumuru-shampoo-bar';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT p.id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products p WHERE p.slug = 'earth-rhythm-murumuru-shampoo-bar';

-- =====================
-- METHODOLOGY
-- =====================

INSERT INTO methodologies (version, summary, scoring_weights, last_updated_at) VALUES
('v1', 'Our shampoo evaluation framework focuses on: 1) Ingredient Transparency - Full INCI disclosure required, 2) Surfactant System - Preference for mild surfactants (glucosides, isethionates), 3) Functional Actives - Evidence-based botanical ingredients, 4) Safety Profile - Paraben-free, no formaldehyde releasers, 5) Certifications - BDIH, ECOCERT, COSMOS valued.',
'{"transparency": 25, "surfactants": 25, "actives": 20, "safety": 20, "certifications": 10}'::jsonb,
'2026-01-02');
