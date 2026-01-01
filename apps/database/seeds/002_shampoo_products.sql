-- Seed: 002_shampoo_products
-- Description: Replace shampoo products with curated product list from product_data
-- Created: 2026-01-01

-- First, remove existing shampoo products and their related data
DELETE FROM product_tags WHERE product_id IN (SELECT id FROM products WHERE category_id = (SELECT id FROM categories WHERE slug = 'shampoo'));
DELETE FROM product_certifications WHERE product_id IN (SELECT id FROM products WHERE category_id = (SELECT id FROM categories WHERE slug = 'shampoo'));
DELETE FROM buy_links WHERE product_id IN (SELECT id FROM products WHERE category_id = (SELECT id FROM categories WHERE slug = 'shampoo'));
DELETE FROM product_cons WHERE product_id IN (SELECT id FROM products WHERE category_id = (SELECT id FROM categories WHERE slug = 'shampoo'));
DELETE FROM product_pros WHERE product_id IN (SELECT id FROM products WHERE category_id = (SELECT id FROM categories WHERE slug = 'shampoo'));
DELETE FROM product_recommendations WHERE product_id IN (SELECT id FROM products WHERE category_id = (SELECT id FROM categories WHERE slug = 'shampoo'));
DELETE FROM products WHERE category_id = (SELECT id FROM categories WHERE slug = 'shampoo');

-- Add new structured tags for shampoo filtering
INSERT INTO tags (name, slug) VALUES
('Dandruff Safe', 'dandruff_safe'),
('Hair Fall Support', 'hair_fall_support'),
('Dry & Frizzy', 'dry_frizzy'),
('Oily Scalp', 'oily_scalp'),
('Certified Organic', 'certified_organic'),
('Modern Clean', 'modern_clean'),
('Zero Chemical', 'zero_chemical'),
('Solid Bar', 'solid_bar'),
('Premium', 'premium'),
('Mid Range', 'mid_range'),
('Affordable', 'affordable'),
('Daily Use', 'daily_use'),
('Alternate Day', 'alternate_day'),
('Weekly Detox', 'weekly_detox')
ON CONFLICT (slug) DO NOTHING;

-- =====================
-- SHAMPOO PRODUCTS FROM CURATED LIST
-- =====================

-- 1. Forest Essentials – Hair Cleanser Bhringraj & Shikakai (Dandruff & Dry Hair)
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'forest-essentials-bhringraj-shikakai',
    'Hair Cleanser Bhringraj & Shikakai',
    'Forest Essentials',
    c.id,
    94,
    'No dependency cycle, gentle long-term scalp balance with Ayurvedic herbs',
    'Reetha (Soapnut) base, Neem extract, Shikakai, Bhringraj oil, Wheat Protein. Sulfate-free, non-stripping formulation.',
    '₹1,295-1,495',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- 2. Sadhev – Ayurvedic Anti-Dandruff Shampoo
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'sadhev-anti-dandruff',
    'Ayurvedic Anti-Dandruff Shampoo',
    'Sadhev',
    c.id,
    89,
    'Good balance of efficacy and affordability for persistent dandruff',
    'Neem extract, Rosemary essential oil, Bakuchi (Psoralea corylifolia), mild surfactants. Ayurvedic therapeutic blend.',
    '₹495-595',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- 3. Just Herbs – 8-in-1 Root Nourishing Amla Neem Shampoo
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'just-herbs-amla-neem',
    '8-in-1 Root Nourishing Amla Neem Shampoo',
    'Just Herbs',
    c.id,
    86,
    'Reliable entry-level clean option for early-stage dandruff and maintenance',
    'Decyl Glucoside base, Neem extract, Amla extract, Hibiscus. Mild herbal cleanser.',
    '₹345-425',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- 4. SoulTree – Licorice Hair Repair Shampoo with Bhringraj
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'soultree-licorice-bhringraj',
    'Licorice Hair Repair Shampoo with Bhringraj',
    'SoulTree',
    c.id,
    93,
    'Strongest certification-backed option for hair fall and weak roots',
    'Bhringraj extract, Licorice (Mulethi), Aloe Vera juice, biodegradable surfactants. BDIH certified.',
    '₹595-695',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- 5. Kama Ayurveda – Bringadi Hair Cleanser
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'kama-bringadi-cleanser',
    'Bringadi Hair Cleanser',
    'Kama Ayurveda',
    c.id,
    90,
    'Balances traditional herbs with modern mild chemistry for fragile hair',
    'Bringadi herbal complex, Aloe Vera, essential oils, amino-acid based surfactants. Clinically positioned formula.',
    '₹795-995',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- 6. Vilvah – Goat Milk Shampoo
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'vilvah-goat-milk',
    'Goat Milk Shampoo',
    'Vilvah',
    c.id,
    88,
    'Excellent transition shampoo from mass-market products, prevents oil rebound',
    'Goat Milk protein, Pea Protein, Sarcosinate-based surfactants, pH balanced (5.5-6).',
    '₹450-550',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- 7. Kama Ayurveda – Rose & Jasmine Hair Cleanser
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'kama-rose-jasmine',
    'Rose & Jasmine Hair Cleanser',
    'Kama Ayurveda',
    c.id,
    91,
    'One of the gentlest cleansers in the category for colored and damaged hair',
    'Rose extract, Jasmine essential oil, Aloe Vera gel, extremely mild surfactants. Essential oil conditioning.',
    '₹895-1,095',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- 8. Arata – Super Shampoo
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'arata-super-shampoo',
    'Super Shampoo',
    'Arata',
    c.id,
    87,
    'Modern clean formulation with good sensory experience for urban users',
    'Onion Oil, Argan Oil, Apple Cider Vinegar, SCI-based creamy foam, pH-balancing ingredients.',
    '₹349-449',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- 9. The Tribe Concepts – Hair Cleanser Powder
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'tribe-concepts-powder',
    'Hair Cleanser Powder',
    'The Tribe Concepts',
    c.id,
    85,
    '100% botanical, maximum purity for ingredient purists',
    'Reetha (Soapnut) powder, Shikakai powder, Amla powder. No preservatives, no surfactants, 100% botanical.',
    '₹295-395',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- 10. Earth Rhythm – Murumuru Butter Shampoo Bar
INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'earth-rhythm-shampoo-bar',
    'Murumuru Butter Shampoo Bar',
    'Earth Rhythm',
    c.id,
    86,
    'Plastic-free, gentle, and effective sustainable option',
    'Murumuru Butter, Vitamin E, SCI-based (not soap), hard water compatible.',
    '₹350-450',
    '2026-01-01'
FROM categories c WHERE c.slug = 'shampoo';

-- =====================
-- SHAMPOO RECOMMENDATIONS (Why Recommended)
-- =====================

-- Forest Essentials
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Reetha-based cleansing is sulfate-free and non-stripping', 1),
    ('Neem and Shikakai control chronic dandruff without harsh chemicals', 2),
    ('Safe for frequent use on sensitive scalp', 3)
) AS recs(rec, ord)
WHERE p.slug = 'forest-essentials-bhringraj-shikakai';

-- Sadhev
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Ayurvedic therapeutic blend targets persistent dandruff', 1),
    ('Neem and Rosemary provide antifungal benefits', 2),
    ('Value-conscious option without compromising efficacy', 3)
) AS recs(rec, ord)
WHERE p.slug = 'sadhev-anti-dandruff';

-- Just Herbs
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Decyl Glucoside base is extremely gentle on scalp', 1),
    ('Amla and Hibiscus provide herbal nourishment', 2),
    ('Perfect for dandruff maintenance and prevention', 3)
) AS recs(rec, ord)
WHERE p.slug = 'just-herbs-amla-neem';

-- SoulTree
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('BDIH certification ensures highest formulation standards', 1),
    ('Bhringraj supports hair growth cycle naturally', 2),
    ('Biodegradable surfactants are gentle yet effective', 3)
) AS recs(rec, ord)
WHERE p.slug = 'soultree-licorice-bhringraj';

-- Kama Bringadi
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Amino-acid based surfactants are gentle on fragile hair', 1),
    ('Traditional Bringadi herbs support hair health', 2),
    ('Suitable for chemically treated hair', 3)
) AS recs(rec, ord)
WHERE p.slug = 'kama-bringadi-cleanser';

-- Vilvah
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Goat Milk provides gentle cleansing without stripping', 1),
    ('pH balanced at 5.5-6 for optimal scalp health', 2),
    ('Prevents oil rebound cycle common with harsh shampoos', 3)
) AS recs(rec, ord)
WHERE p.slug = 'vilvah-goat-milk';

-- Kama Rose & Jasmine
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Extremely mild surfactants protect color-treated hair', 1),
    ('Essential oil conditioning without silicone buildup', 2),
    ('Rose and Jasmine provide gentle aromatherapy benefits', 3)
) AS recs(rec, ord)
WHERE p.slug = 'kama-rose-jasmine';

-- Arata
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Apple Cider Vinegar balances scalp pH naturally', 1),
    ('Onion Oil supports hair strength and growth', 2),
    ('SCI-based foam provides satisfying wash experience', 3)
) AS recs(rec, ord)
WHERE p.slug = 'arata-super-shampoo';

-- Tribe Concepts
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('100% botanical with zero synthetic ingredients', 1),
    ('Traditional Reetha-Shikakai-Amla combination', 2),
    ('Maximum purity for ultra-sensitive scalps', 3)
) AS recs(rec, ord)
WHERE p.slug = 'tribe-concepts-powder';

-- Earth Rhythm
INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Plastic-free packaging reduces environmental impact', 1),
    ('SCI-based bar (not soap) works in hard water', 2),
    ('Murumuru Butter provides natural conditioning', 3)
) AS recs(rec, ord)
WHERE p.slug = 'earth-rhythm-shampoo-bar';

-- =====================
-- SHAMPOO PROS
-- =====================

-- Forest Essentials
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Luxury Ayurvedic formulation backed by heritage brand', 1),
    ('Effective for both dandruff and dry/frizzy hair concerns', 2),
    ('No dependency cycle - scalp stays balanced long-term', 3)
) AS pros(pro, ord)
WHERE p.slug = 'forest-essentials-bhringraj-shikakai';

-- Sadhev
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Effective dandruff control at mid-range pricing', 1),
    ('Bakuchi provides unique anti-dandruff benefits', 2),
    ('Mild surfactants suitable for regular use', 3)
) AS pros(pro, ord)
WHERE p.slug = 'sadhev-anti-dandruff';

-- Just Herbs
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Most affordable clean shampoo option', 1),
    ('8-in-1 formula addresses multiple hair concerns', 2),
    ('Gentle enough for daily use', 3)
) AS pros(pro, ord)
WHERE p.slug = 'just-herbs-amla-neem';

-- SoulTree
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('BDIH certified - highest verification standard', 1),
    ('Licorice soothes irritated scalp', 2),
    ('Excellent for hair fall and weak roots', 3)
) AS pros(pro, ord)
WHERE p.slug = 'soultree-licorice-bhringraj';

-- Kama Bringadi
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Premium brand with clinical positioning', 1),
    ('Safe for chemically treated and fragile hair', 2),
    ('Traditional herbs in modern mild formulation', 3)
) AS pros(pro, ord)
WHERE p.slug = 'kama-bringadi-cleanser';

-- Vilvah
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Unique Goat Milk formula for gentle cleansing', 1),
    ('Perfect transition from mass-market shampoos', 2),
    ('Suitable for both oily scalp and hair fall concerns', 3)
) AS pros(pro, ord)
WHERE p.slug = 'vilvah-goat-milk';

-- Kama Rose & Jasmine
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Gentlest cleanser for color-treated hair', 1),
    ('Beautiful natural fragrance', 2),
    ('No silicone buildup over time', 3)
) AS pros(pro, ord)
WHERE p.slug = 'kama-rose-jasmine';

-- Arata
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Modern formulation with proven ingredients', 1),
    ('Good sensory experience with creamy foam', 2),
    ('Addresses urban pollution and frizz', 3)
) AS pros(pro, ord)
WHERE p.slug = 'arata-super-shampoo';

-- Tribe Concepts
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Zero synthetic ingredients - pure botanical', 1),
    ('Traditional time-tested formula', 2),
    ('Ideal for ingredient purists and sensitive users', 3)
) AS pros(pro, ord)
WHERE p.slug = 'tribe-concepts-powder';

-- Earth Rhythm
INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Zero plastic waste packaging', 1),
    ('Travel-friendly solid format', 2),
    ('Works well even in hard water areas', 3)
) AS pros(pro, ord)
WHERE p.slug = 'earth-rhythm-shampoo-bar';

-- =====================
-- SHAMPOO CONS
-- =====================

-- Forest Essentials
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('Premium pricing may not suit all budgets', 1),
    ('May require adjustment period from conventional shampoos', 2)
) AS cons(con, ord)
WHERE p.slug = 'forest-essentials-bhringraj-shikakai';

-- Sadhev
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('Less widely available than mainstream brands', 1),
    ('Herbal scent may not appeal to everyone', 2)
) AS cons(con, ord)
WHERE p.slug = 'sadhev-anti-dandruff';

-- Just Herbs
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('May not be strong enough for severe dandruff', 1),
    ('Lower foam level than conventional shampoos', 2)
) AS cons(con, ord)
WHERE p.slug = 'just-herbs-amla-neem';

-- SoulTree
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('Higher price point in mid-range category', 1),
    ('Results take consistent use to show', 2)
) AS cons(con, ord)
WHERE p.slug = 'soultree-licorice-bhringraj';

-- Kama Bringadi
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('Premium pricing', 1),
    ('May not provide instant smoothness some expect', 2)
) AS cons(con, ord)
WHERE p.slug = 'kama-bringadi-cleanser';

-- Vilvah
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('Goat Milk scent may take getting used to', 1),
    ('May need conditioner for very dry hair', 2)
) AS cons(con, ord)
WHERE p.slug = 'vilvah-goat-milk';

-- Kama Rose & Jasmine
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('Premium price point', 1),
    ('Very mild - may not suit very oily scalps', 2)
) AS cons(con, ord)
WHERE p.slug = 'kama-rose-jasmine';

-- Arata
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('Onion oil scent lingers slightly', 1),
    ('May not suit traditional fragrance preferences', 2)
) AS cons(con, ord)
WHERE p.slug = 'arata-super-shampoo';

-- Tribe Concepts
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('Requires effort and technique to use powder format', 1),
    ('Not ideal for heavy oil or product buildup', 2),
    ('No foam - different experience than liquid shampoo', 3)
) AS cons(con, ord)
WHERE p.slug = 'tribe-concepts-powder';

-- Earth Rhythm
INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, con, ord
FROM products p
CROSS JOIN (VALUES
    ('Bar format needs proper storage', 1),
    ('Takes practice to lather effectively', 2)
) AS cons(con, ord)
WHERE p.slug = 'earth-rhythm-shampoo-bar';

-- =====================
-- SHAMPOO TAGS (Structured filtering)
-- =====================

-- Forest Essentials - Dandruff Safe, Dry & Frizzy, Ayurvedic, Premium, Daily Use
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'forest-essentials-bhringraj-shikakai' 
AND t.slug IN ('dandruff_safe', 'dry_frizzy', 'ayurvedic', 'premium', 'daily_use', 'sensitive-scalp');

-- Sadhev - Dandruff Safe, Ayurvedic, Mid Range, Alternate Day
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'sadhev-anti-dandruff' 
AND t.slug IN ('dandruff_safe', 'ayurvedic', 'mid_range', 'alternate_day');

-- Just Herbs - Dandruff Safe, Affordable, Daily Use
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'just-herbs-amla-neem' 
AND t.slug IN ('dandruff_safe', 'affordable', 'daily_use', 'oily_scalp');

-- SoulTree - Hair Fall Support, Certified Organic, Premium, Alternate Day
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'soultree-licorice-bhringraj' 
AND t.slug IN ('hair_fall_support', 'certified_organic', 'premium', 'alternate_day');

-- Kama Bringadi - Hair Fall Support, Modern Clean, Mid Range, Alternate Day
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'kama-bringadi-cleanser' 
AND t.slug IN ('hair_fall_support', 'modern_clean', 'mid_range', 'alternate_day');

-- Vilvah - Hair Fall Support, Oily Scalp, Modern Clean, Affordable, Daily Use
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'vilvah-goat-milk' 
AND t.slug IN ('hair_fall_support', 'oily_scalp', 'modern_clean', 'affordable', 'daily_use', 'alternate_day');

-- Kama Rose & Jasmine - Dry & Frizzy, Modern Clean, Premium, Daily Use
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'kama-rose-jasmine' 
AND t.slug IN ('dry_frizzy', 'modern_clean', 'premium', 'daily_use', 'color-safe');

-- Arata - Dry & Frizzy, Modern Clean, Affordable, Daily Use
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'arata-super-shampoo' 
AND t.slug IN ('dry_frizzy', 'modern_clean', 'affordable', 'daily_use');

-- Tribe Concepts - Sensitive Scalp, Zero Chemical, Affordable, Weekly Detox
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'tribe-concepts-powder' 
AND t.slug IN ('sensitive-scalp', 'zero_chemical', 'ayurvedic', 'affordable', 'weekly_detox');

-- Earth Rhythm - Dry & Frizzy, Solid Bar, Modern Clean, Affordable
INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id FROM products p, tags t 
WHERE p.slug = 'earth-rhythm-shampoo-bar' 
AND t.slug IN ('dry_frizzy', 'solid_bar', 'modern_clean', 'affordable', 'alternate_day');

-- =====================
-- BUY LINKS
-- =====================

-- Forest Essentials
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('Forest Essentials', 'https://www.forestessentialsindia.com/hair-cleanser-bhringraj-and-shikakai.html', 1),
    ('Amazon India', 'https://www.amazon.in/Forest-Essentials-Cleanser-Bhringraj-Shikakai/dp/B07D8NQNZT', 2),
    ('Nykaa', 'https://www.nykaa.com/forest-essentials-hair-cleanser-bhringraj-shikakai/p/287932', 3)
) AS links(vendor, url, ord)
WHERE p.slug = 'forest-essentials-bhringraj-shikakai';

-- Sadhev
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('Sadhev', 'https://www.sadhev.com/collections/hair-care', 1),
    ('Amazon India', 'https://www.amazon.in/Sadhev-Ayurvedic-Anti-Dandruff-Shampoo/dp/B09EXAMPLE', 2)
) AS links(vendor, url, ord)
WHERE p.slug = 'sadhev-anti-dandruff';

-- Just Herbs
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('Just Herbs', 'https://justherbs.in/products/herbal-anti-dandruff-shampoo', 1),
    ('Amazon India', 'https://www.amazon.in/Just-Herbs-Nourishing-Shampoo-200ml/dp/B07H8WNPK4', 2),
    ('Nykaa', 'https://www.nykaa.com/just-herbs-8-in-1-root-nourishing-amla-neem-shampoo/p/303453', 3)
) AS links(vendor, url, ord)
WHERE p.slug = 'just-herbs-amla-neem';

-- SoulTree
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('SoulTree', 'https://soultree.in/collections/hair-care/products/licorice-hair-repair-shampoo', 1),
    ('Amazon India', 'https://www.amazon.in/SoulTree-Licorice-Hair-Repair-Shampoo/dp/B07D8EXAMPLE', 2)
) AS links(vendor, url, ord)
WHERE p.slug = 'soultree-licorice-bhringraj';

-- Kama Bringadi
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('Kama Ayurveda', 'https://www.kamaayurveda.com/bringadi-hair-cleanser.html', 1),
    ('Amazon India', 'https://www.amazon.in/Kama-Ayurveda-Bringadi-Intensive-Cleanser/dp/B01N5EXAMPLE', 2),
    ('Nykaa', 'https://www.nykaa.com/kama-ayurveda-bringadi-hair-cleanser/p/287654', 3)
) AS links(vendor, url, ord)
WHERE p.slug = 'kama-bringadi-cleanser';

-- Vilvah
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('Vilvah', 'https://vilvahstore.com/products/goatmilk-shampoo', 1),
    ('Amazon India', 'https://www.amazon.in/Vilvah-Goat-Milk-Shampoo/dp/B08EXAMPLE', 2)
) AS links(vendor, url, ord)
WHERE p.slug = 'vilvah-goat-milk';

-- Kama Rose & Jasmine
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('Kama Ayurveda', 'https://www.kamaayurveda.com/rose-jasmine-hair-cleanser.html', 1),
    ('Amazon India', 'https://www.amazon.in/Kama-Ayurveda-Rose-Jasmine-Cleanser/dp/B07EXAMPLE', 2),
    ('Nykaa', 'https://www.nykaa.com/kama-ayurveda-rose-jasmine-hair-cleanser/p/315432', 3)
) AS links(vendor, url, ord)
WHERE p.slug = 'kama-rose-jasmine';

-- Arata
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('Arata', 'https://arata.in/products/super-shampoo', 1),
    ('Amazon India', 'https://www.amazon.in/Arata-Super-Shampoo-Onion-Oil/dp/B09EXAMPLE', 2),
    ('Nykaa', 'https://www.nykaa.com/arata-super-shampoo/p/456789', 3)
) AS links(vendor, url, ord)
WHERE p.slug = 'arata-super-shampoo';

-- Tribe Concepts
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('The Tribe Concepts', 'https://thetribeconcepts.com/products/hair-cleanser-powder', 1),
    ('Amazon India', 'https://www.amazon.in/Tribe-Concepts-Hair-Cleanser-Powder/dp/B08EXAMPLE', 2)
) AS links(vendor, url, ord)
WHERE p.slug = 'tribe-concepts-powder';

-- Earth Rhythm
INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, vendor, url, false, ord FROM products p
CROSS JOIN (VALUES
    ('Earth Rhythm', 'https://earthrhythm.in/products/murumuru-butter-shampoo-bar', 1),
    ('Amazon India', 'https://www.amazon.in/Earth-Rhythm-Murumuru-Butter-Shampoo/dp/B08EXAMPLE', 2),
    ('Nykaa', 'https://www.nykaa.com/earth-rhythm-murumuru-shampoo-bar/p/567890', 3)
) AS links(vendor, url, ord)
WHERE p.slug = 'earth-rhythm-shampoo-bar';

-- =====================
-- CERTIFICATIONS
-- =====================

-- SoulTree - BDIH certified
INSERT INTO product_certifications (product_id, certification_id)
SELECT p.id, c.id FROM products p, certifications c
WHERE p.slug = 'soultree-licorice-bhringraj' AND c.name = 'BDIH';

-- Vilvah - BIS compliant
INSERT INTO product_certifications (product_id, certification_id)
SELECT p.id, c.id FROM products p, certifications c
WHERE p.slug = 'vilvah-goat-milk' AND c.name = 'BIS Compliant';
