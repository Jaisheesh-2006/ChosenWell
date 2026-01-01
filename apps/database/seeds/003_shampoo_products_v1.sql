-- Seed: 003_shampoo_products_v1
-- Description: Import curated shampoo products from product_data/shampoos/file.json
-- Created: 2026-01-01
-- Schema: v1 (005_v1_schema.sql)

-- =====================
-- PRODUCTS
-- =====================

-- 1. Forest Essentials - Hair Cleanser Bhringraj & Shikakai
INSERT INTO products (
    slug, name, brand, category_slug,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'forest-essentials-bhringraj-shikakai-cleanser',
    'Hair Cleanser Bhringraj & Shikakai',
    'Forest Essentials',
    'shampoo',
    'active', true, false,
    90, 'v1', '2025-01-01',
    'alternate_day', 'premium',
    'Gentle Ayurvedic cleanser suitable for sensitive and dandruff-prone scalps.',
    ARRAY[
        'Uses reetha and shikakai for non-stripping cleansing',
        'Supports scalp balance without medicated actives',
        'No dependency or rebound dryness'
    ],
    ARRAY['Extremely gentle', 'Long-term safe'],
    ARRAY['Premium price point'],
    'Bhringraj, Shikakai, Neem, Reetha, Wheat Protein',
    ARRAY['AYUSH'],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']
);

-- 2. Sadhev - Ayurvedic Anti-Dandruff Shampoo
INSERT INTO products (
    slug, name, brand, category_slug,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'sadhev-ayurvedic-anti-dandruff-shampoo',
    'Ayurvedic Anti-Dandruff Shampoo',
    'Sadhev',
    'shampoo',
    'active', false, true,
    78, 'v1', '2025-01-01',
    'alternate_day', 'mid_range',
    'Ayurvedic dandruff control without harsh antifungals.',
    ARRAY[
        'Neem-based antifungal support',
        'Mild surfactants suitable for repeated use'
    ],
    ARRAY['Therapeutic focus', 'Good value'],
    ARRAY['Not deeply conditioning'],
    'Neem, Rosemary, Bakuchi',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']
);

-- 3. Just Herbs - 8-in-1 Root Nourishing Amla Neem Shampoo
INSERT INTO products (
    slug, name, brand, category_slug,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'just-herbs-amla-neem-shampoo',
    '8-in-1 Root Nourishing Amla Neem Shampoo',
    'Just Herbs',
    'shampoo',
    'active', false, true,
    72, 'v1', '2025-01-01',
    'daily_use', 'affordable',
    'Affordable herbal shampoo for dandruff maintenance.',
    ARRAY[
        'Neem and amla for scalp balance',
        'Mild decyl glucoside base'
    ],
    ARRAY['Budget-friendly', 'Easy daily use'],
    ARRAY['Not ideal for severe dandruff'],
    'Neem, Amla, Hibiscus',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']
);

-- 4. SoulTree - Licorice Hair Repair Shampoo with Bhringraj
INSERT INTO products (
    slug, name, brand, category_slug,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'soultree-licorice-bhringraj-shampoo',
    'Licorice Hair Repair Shampoo with Bhringraj',
    'SoulTree',
    'shampoo',
    'active', true, false,
    88, 'v1', '2025-01-01',
    'alternate_day', 'premium',
    'Certified organic shampoo focused on reducing hair fall.',
    ARRAY[
        'BDIH certified formulation',
        'Bhringraj supports growth cycle'
    ],
    ARRAY['Highest trust signal', 'Excellent ingredient transparency'],
    ARRAY['Premium pricing'],
    'Bhringraj, Licorice, Aloe Vera',
    ARRAY['BDIH'],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']
);

-- 5. Kama Ayurveda - Bringadi Hair Cleanser
INSERT INTO products (
    slug, name, brand, category_slug,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'kama-ayurveda-bringadi-cleanser',
    'Bringadi Hair Cleanser',
    'Kama Ayurveda',
    'shampoo',
    'active', false, false,
    80, 'v1', '2025-01-01',
    'alternate_day', 'mid_range',
    'Mild, clinically positioned cleanser for fragile hair.',
    ARRAY[
        'Amino-acid surfactants',
        'Suitable for chemically treated hair'
    ],
    ARRAY['Very gentle', 'Balanced formulation'],
    ARRAY['Moderate conditioning only'],
    'Bringadi herbs, Aloe, essential oils',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']
);

-- 6. Vilvah - Goat Milk Shampoo
INSERT INTO products (
    slug, name, brand, category_slug,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'vilvah-goat-milk-shampoo',
    'Goat Milk Shampoo',
    'Vilvah',
    'shampoo',
    'active', false, true,
    76, 'v1', '2025-01-01',
    'alternate_day', 'affordable',
    'Gentle, pH-balanced shampoo ideal for reducing breakage.',
    ARRAY[
        'Goat milk lipids reduce breakage',
        'Excellent transition shampoo'
    ],
    ARRAY['Gentle', 'Affordable'],
    ARRAY['Not for severe dandruff'],
    'Goat milk, pea protein, mild surfactants',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']
);

-- 7. Arata - Super Shampoo
INSERT INTO products (
    slug, name, brand, category_slug,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'arata-super-shampoo',
    'Super Shampoo',
    'Arata',
    'shampoo',
    'active', false, false,
    74, 'v1', '2025-01-01',
    'alternate_day', 'affordable',
    'Modern clean shampoo designed for urban hair stress.',
    ARRAY[
        'SCI-based creamy foam',
        'Apple cider vinegar for cuticle sealing'
    ],
    ARRAY['Good sensory experience'],
    ARRAY['Less therapeutic'],
    'Onion oil, argan oil, apple cider vinegar',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']
);

-- 8. The Tribe Concepts - Hair Cleanser Powder
INSERT INTO products (
    slug, name, brand, category_slug,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'tribe-concepts-hair-cleanser-powder',
    'Hair Cleanser Powder',
    'The Tribe Concepts',
    'shampoo',
    'active', false, false,
    70, 'v1', '2025-01-01',
    'weekly_detox', 'mid_range',
    'Ultra-pure botanical cleanser for sensitive users.',
    ARRAY[
        'No preservatives or surfactants',
        'Traditional cleansing method'
    ],
    ARRAY['Maximum purity'],
    ARRAY['Inconvenient', 'Not for heavy oil'],
    'Reetha, Shikakai, Amla',
    ARRAY[]::TEXT[],
    ARRAY['All synthetic surfactants', 'Preservatives']
);

-- 9. Earth Rhythm - Murumuru Butter Shampoo Bar
INSERT INTO products (
    slug, name, brand, category_slug,
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
    'active', false, false,
    75, 'v1', '2025-01-01',
    'alternate_day', 'mid_range',
    'Plastic-free shampoo bar suitable for Indian water.',
    ARRAY[
        'SCI-based, not soap',
        'Travel-friendly and eco-conscious'
    ],
    ARRAY['Low waste'],
    ARRAY['Learning curve'],
    'Murumuru butter, vitamin E, SCI',
    ARRAY[]::TEXT[],
    ARRAY['Soap base', 'SLS', 'Parabens']
);

-- =====================
-- PRIMARY CONCERNS (join table)
-- =====================

-- Forest Essentials: dandruff_safe, sensitive_scalp, dry_frizzy
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dandruff_safe' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-cleanser';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitive_scalp' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-cleanser';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-cleanser';

-- Sadhev: dandruff_safe
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dandruff_safe' FROM products WHERE slug = 'sadhev-ayurvedic-anti-dandruff-shampoo';

-- Just Herbs: dandruff_safe, oily_scalp
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dandruff_safe' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'oily_scalp' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';

-- SoulTree: hair_fall_support
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';

-- Kama Ayurveda: hair_fall_support, dry_frizzy
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';

-- Vilvah: hair_fall_support, oily_scalp
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'oily_scalp' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';

-- Arata: dry_frizzy
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'arata-super-shampoo';

-- Tribe Concepts: sensitive_scalp
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitive_scalp' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';

-- Earth Rhythm: dry_frizzy
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';

-- =====================
-- PHILOSOPHY TAGS (join table)
-- =====================

-- Forest Essentials: ayurvedic, premium_clean
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-cleanser';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'premium_clean' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-cleanser';

-- Sadhev: ayurvedic
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'sadhev-ayurvedic-anti-dandruff-shampoo';

-- Just Herbs: ayurvedic
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';

-- SoulTree: ayurvedic, certified_organic
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'certified_organic' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';

-- Kama Ayurveda: ayurvedic, modern_clean
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';

-- Vilvah: modern_clean
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';

-- Arata: modern_clean
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'arata-super-shampoo';

-- Tribe Concepts: zero_chemical, ayurvedic
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'zero_chemical' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';

-- Earth Rhythm: solid_bar, modern_clean
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'solid_bar' FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';

-- =====================
-- VERIFY
-- =====================

-- Check product count
SELECT COUNT(*) AS product_count FROM products WHERE category_slug = 'shampoo';

-- Check concerns distribution
SELECT 
    pc.concern_code,
    COUNT(*) AS product_count
FROM product_primary_concerns pc
GROUP BY pc.concern_code
ORDER BY product_count DESC;

-- Check philosophy distribution
SELECT 
    pt.philosophy_code,
    COUNT(*) AS product_count
FROM product_philosophy_tags pt
GROUP BY pt.philosophy_code
ORDER BY product_count DESC;
