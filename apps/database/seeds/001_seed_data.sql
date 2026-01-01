-- Seed: 001_seed_data
-- Description: Initial seed data for toothpaste and shampoo categories
-- Created: 2025-12-31

-- Insert categories (only toothpaste and shampoo)
INSERT INTO categories (slug, title, description, long_description, criteria_version) VALUES
(
    'toothpaste',
    'Toothpaste',
    'Natural and effective oral care products analyzed for safety and efficacy.',
    'Natural toothpaste options have evolved significantly, offering effective cleaning without harsh chemicals. We analyze fluoride alternatives, SLS-free formulas, and remineralizing ingredients to help you choose the best option for your family''s oral health.',
    '1.0'
),
(
    'shampoo',
    'Shampoo',
    'Clean hair care products evaluated for scalp health and ingredient safety.',
    'India''s shampoo market is crowded, confusing, and often misleading. Most products are designed to look effective in the short term—high foam, instant smoothness—while quietly compromising long-term scalp and hair health. Our role is simple: act as a strict filter. If a shampoo appears on this platform, it has cleared a bar that most mass-market products do not.',
    '1.0'
);

-- =====================
-- CATEGORY CRITERIA (Structured: must_have, good_to_have, disqualifiers)
-- =====================

-- Toothpaste: Must Have
INSERT INTO category_criteria (category_id, criteria_type, criterion, display_order)
SELECT c.id, 'must_have', criterion, ord
FROM categories c
CROSS JOIN (VALUES 
    ('Free from SLS (Sodium Lauryl Sulfate)', 1),
    ('No artificial sweeteners or colors', 2),
    ('Third-party tested for safety', 3)
) AS criteria(criterion, ord)
WHERE c.slug = 'toothpaste';

-- Toothpaste: Good to Have
INSERT INTO category_criteria (category_id, criteria_type, criterion, display_order)
SELECT c.id, 'good_to_have', criterion, ord
FROM categories c
CROSS JOIN (VALUES 
    ('Contains remineralizing ingredients (hydroxyapatite, calcium)', 1),
    ('Natural flavoring from essential oils', 2),
    ('EWG Verified or similar certification', 3)
) AS criteria(criterion, ord)
WHERE c.slug = 'toothpaste';

-- Toothpaste: Disqualifiers
INSERT INTO category_criteria (category_id, criteria_type, criterion, display_order)
SELECT c.id, 'disqualifiers', criterion, ord
FROM categories c
CROSS JOIN (VALUES 
    ('Contains triclosan', 1),
    ('Contains artificial dyes (Blue 1, Red 40, etc.)', 2),
    ('Contains microbeads or microplastics', 3)
) AS criteria(criterion, ord)
WHERE c.slug = 'toothpaste';

-- Shampoo: Must Have (from evaluation criteria document)
INSERT INTO category_criteria (category_id, criteria_type, criterion, display_order)
SELECT c.id, 'must_have', criterion, ord
FROM categories c
CROSS JOIN (VALUES 
    ('Uses approved gentle cleansing agents only (Decyl Glucoside, Sodium Cocoyl Glutamate, Sodium Lauroyl Sarcosinate, Sodium Cocoyl Isethionate, Reetha/Shikakai)', 1),
    ('Full INCI ingredient disclosure - no hidden ''Base Q.S.''', 2),
    ('BIS safety standards compliance (pH balance, heavy metal limits)', 3),
    ('Scalp-compatible pH (~5.5)', 4),
    ('Low irritation potential surfactants', 5),
    ('Biodegradable cleansing agents', 6)
) AS criteria(criterion, ord)
WHERE c.slug = 'shampoo';

-- Shampoo: Good to Have (from evaluation criteria document)
INSERT INTO category_criteria (category_id, criteria_type, criterion, display_order)
SELECT c.id, 'good_to_have', criterion, ord
FROM categories c
CROSS JOIN (VALUES 
    ('Contains verified Ayurvedic ingredients (Bhringraj - supports hair growth cycles)', 1),
    ('Contains Amla - antioxidant protection, hair fall support', 2),
    ('Contains Shikakai - natural cleanser with acidic pH', 3),
    ('Contains Reetha - mild, hypoallergenic cleansing', 4),
    ('Contains Neem - antifungal, dandruff control', 5),
    ('ECOCERT / COSMOS certification', 6),
    ('BDIH Certified Natural Cosmetics', 7),
    ('Export-grade GMP standards', 8)
) AS criteria(criterion, ord)
WHERE c.slug = 'shampoo';

-- Shampoo: Disqualifiers (from evaluation criteria document - automatic exclusions)
INSERT INTO category_criteria (category_id, criteria_type, criterion, display_order)
SELECT c.id, 'disqualifiers', criterion, ord
FROM categories c
CROSS JOIN (VALUES 
    ('Sulfates (SLS/SLES) - disrupts scalp''s natural lipid barrier, causes dryness, irritation, rebound oiliness, and long-term scalp inflammation', 1),
    ('Formaldehyde releasers (DMDM Hydantoin, Diazolidinyl Urea) - linked to contact dermatitis, allergic sensitization, and hair fall', 2),
    ('Parabens - endocrine disruptors (xenoestrogens) with hormonal health concerns from cumulative exposure', 3),
    ('Hidden or undisclosed ''Base Q.S.'' ingredients - prevents verification of safety claims', 4),
    ('Token herbs added for marketing on top of harsh synthetic base', 5),
    ('Ayurvedic claims without full INCI disclosure', 6),
    ('SLES with 1,4-dioxane contamination risk (probable carcinogen)', 7)
) AS criteria(criterion, ord)
WHERE c.slug = 'shampoo';

-- Insert certifications (including those from shampoo criteria document)
INSERT INTO certifications (name, description) VALUES
('EWG Verified', 'Environmental Working Group verified for safety'),
('Leaping Bunny', 'Cruelty-free certified'),
('USDA Organic', 'USDA certified organic product'),
('Non-GMO Project Verified', 'Verified non-GMO ingredients'),
('NSF Certified', 'NSF International certified for quality'),
('Vegan Certified', 'Certified vegan product'),
('Made Safe', 'Made Safe certified for non-toxic ingredients'),
('ECOCERT', 'ECOCERT certified natural and organic cosmetics'),
('COSMOS', 'COSMOS standard for organic and natural cosmetics'),
('BDIH', 'BDIH Certified Natural Cosmetics (German certification)'),
('BIS Compliant', 'Bureau of Indian Standards safety compliance'),
('GMP Certified', 'Good Manufacturing Practice certified');

-- Insert tags (including shampoo-specific tags)
INSERT INTO tags (name, slug) VALUES
('Fluoride-Free', 'fluoride-free'),
('Kids Safe', 'kids-safe'),
('Organic', 'organic'),
('Sulfate-Free', 'sulfate-free'),
('Paraben-Free', 'paraben-free'),
('Sensitive Scalp', 'sensitive-scalp'),
('Color Safe', 'color-safe'),
('Vegan', 'vegan'),
('Budget', 'budget'),
('Ayurvedic', 'ayurvedic'),
('SLS-Free', 'sls-free'),
('Silicone-Free', 'silicone-free'),
('pH Balanced', 'ph-balanced'),
('Dandruff Control', 'dandruff-control'),
('Hair Fall Control', 'hair-fall-control');

-- =====================
-- TOOTHPASTE PRODUCTS
-- =====================

INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'non-toxic-toothpaste',
    'Non-Toxic Toothpaste',
    'PureSmile',
    c.id,
    92,
    'Formulated without fluoride, SLS, or artificial sweeteners',
    'Calcium carbonate, hydroxyapatite, xylitol, coconut oil, peppermint essential oil. No parabens, no triclosan.',
    '$12-18',
    '2025-12-15'
FROM categories c WHERE c.slug = 'toothpaste';

INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'charcoal-whitening-toothpaste',
    'Charcoal Whitening Toothpaste',
    'BrightNaturals',
    c.id,
    87,
    'Activated charcoal for gentle whitening without harsh bleaching agents',
    'Activated bamboo charcoal, baking soda, coconut oil, tea tree oil, spearmint. No artificial colors or preservatives.',
    '$10-14',
    '2025-12-10'
FROM categories c WHERE c.slug = 'toothpaste';

INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'kids-strawberry-toothpaste',
    'Kids Strawberry Toothpaste',
    'LittleTeeth',
    c.id,
    90,
    'Safe-to-swallow formula designed specifically for children',
    'Xylitol, calcium carbonate, organic strawberry flavor, aloe vera, vitamin E. Fluoride-free and SLS-free.',
    '$8-12',
    '2025-12-08'
FROM categories c WHERE c.slug = 'toothpaste';

-- =====================
-- SHAMPOO PRODUCTS
-- =====================

INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'gentle-daily-shampoo',
    'Gentle Daily Shampoo',
    'CleanRoots',
    c.id,
    91,
    'Sulfate-free formula gentle enough for everyday use',
    'Aloe vera juice, coconut-derived cleansers, chamomile extract, jojoba oil, vitamin B5. No sulfates, parabens, or silicones.',
    '$14-18',
    '2025-12-12'
FROM categories c WHERE c.slug = 'shampoo';

INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'scalp-therapy-shampoo',
    'Scalp Therapy Shampoo',
    'ScalpCare Pro',
    c.id,
    89,
    'Targets dry, itchy scalp with soothing botanical ingredients',
    'Tea tree oil, salicylic acid (plant-derived), zinc pyrithione, peppermint oil, oat extract. Dermatologist tested.',
    '$18-24',
    '2025-12-05'
FROM categories c WHERE c.slug = 'shampoo';

INSERT INTO products (slug, name, brand, category_id, score, short_reason, ingredients_summary, price_range, last_reviewed)
SELECT 
    'color-protect-shampoo',
    'Color Protect Shampoo',
    'VibrantLocks',
    c.id,
    86,
    'Preserves color vibrancy while gently cleansing',
    'Quinoa protein, sunflower seed extract, argan oil, vitamin E, hibiscus extract. Sulfate-free and color-safe formula.',
    '$16-22',
    '2025-12-01'
FROM categories c WHERE c.slug = 'shampoo';

-- =====================
-- TOOTHPASTE RECOMMENDATIONS
-- =====================

INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Formulated without fluoride, SLS, or artificial sweeteners', 1),
    ('Uses hydroxyapatite for enamel remineralization', 2),
    ('Safe for the whole family including children', 3)
) AS recs(rec, ord)
WHERE p.slug = 'non-toxic-toothpaste';

INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Activated charcoal provides gentle whitening', 1),
    ('No harsh bleaching agents or peroxides', 2),
    ('Natural antibacterial properties from tea tree oil', 3)
) AS recs(rec, ord)
WHERE p.slug = 'charcoal-whitening-toothpaste';

INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Safe-to-swallow formula perfect for toddlers learning to brush', 1),
    ('Natural strawberry flavor kids actually enjoy', 2),
    ('Xylitol helps prevent cavities naturally', 3)
) AS recs(rec, ord)
WHERE p.slug = 'kids-strawberry-toothpaste';

-- =====================
-- SHAMPOO RECOMMENDATIONS
-- =====================

INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Coconut-derived cleansers provide effective yet gentle cleansing', 1),
    ('Perfect for daily use without stripping natural oils', 2),
    ('Chamomile and aloe soothe the scalp', 3)
) AS recs(rec, ord)
WHERE p.slug = 'gentle-daily-shampoo';

INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Tea tree oil provides natural antifungal properties', 1),
    ('Targets dandruff and dry scalp effectively', 2),
    ('Dermatologist-tested for sensitive scalps', 3)
) AS recs(rec, ord)
WHERE p.slug = 'scalp-therapy-shampoo';

INSERT INTO product_recommendations (product_id, recommendation, display_order)
SELECT p.id, rec, ord
FROM products p
CROSS JOIN (VALUES
    ('Quinoa protein helps seal color into hair shaft', 1),
    ('UV protection from sunflower seed extract', 2),
    ('Argan oil adds shine without weighing hair down', 3)
) AS recs(rec, ord)
WHERE p.slug = 'color-protect-shampoo';

-- =====================
-- TOOTHPASTE PROS
-- =====================

INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Hydroxyapatite strengthens enamel naturally', 1),
    ('Free from harsh chemicals and artificial dyes', 2),
    ('Mild mint flavor suitable for sensitive mouths', 3)
) AS pros(pro, ord)
WHERE p.slug = 'non-toxic-toothpaste';

INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Visibly whiter teeth within 2 weeks', 1),
    ('Charcoal absorbs stains and toxins', 2),
    ('Fresh spearmint taste without artificial sweeteners', 3)
) AS pros(pro, ord)
WHERE p.slug = 'charcoal-whitening-toothpaste';

INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Kids love the natural strawberry taste', 1),
    ('Safe if accidentally swallowed', 2),
    ('Gentle formula for developing teeth and gums', 3)
) AS pros(pro, ord)
WHERE p.slug = 'kids-strawberry-toothpaste';

-- =====================
-- SHAMPOO PROS
-- =====================

INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Gentle enough for sensitive scalps', 1),
    ('Leaves hair soft without residue', 2),
    ('Pleasant natural scent from essential oils', 3)
) AS pros(pro, ord)
WHERE p.slug = 'gentle-daily-shampoo';

INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Noticeably reduces flaking within first week', 1),
    ('Cooling peppermint sensation soothes itchiness', 2),
    ('Works well for various scalp conditions', 3)
) AS pros(pro, ord)
WHERE p.slug = 'scalp-therapy-shampoo';

INSERT INTO product_pros (product_id, pro, display_order)
SELECT p.id, pro, ord
FROM products p
CROSS JOIN (VALUES
    ('Color stays vibrant 40% longer than with regular shampoo', 1),
    ('Adds noticeable shine and softness', 2),
    ('Works well with all hair types', 3)
) AS pros(pro, ord)
WHERE p.slug = 'color-protect-shampoo';

-- =====================
-- TOOTHPASTE CONS
-- =====================

INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, 'Premium price point compared to mainstream brands', 1
FROM products p WHERE p.slug = 'non-toxic-toothpaste';

INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, 'Charcoal can be messy during application', 1
FROM products p WHERE p.slug = 'charcoal-whitening-toothpaste';

INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, 'May not appeal to kids who prefer traditional mint', 1
FROM products p WHERE p.slug = 'kids-strawberry-toothpaste';

-- =====================
-- SHAMPOO CONS
-- =====================

INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, 'May not lather as much as sulfate-based shampoos', 1
FROM products p WHERE p.slug = 'gentle-daily-shampoo';

INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, 'Tea tree scent may be strong for some users', 1
FROM products p WHERE p.slug = 'scalp-therapy-shampoo';

INSERT INTO product_cons (product_id, con, display_order)
SELECT p.id, 'Higher price point than drugstore alternatives', 1
FROM products p WHERE p.slug = 'color-protect-shampoo';

-- =====================
-- PRODUCT CERTIFICATIONS
-- =====================

INSERT INTO product_certifications (product_id, certification_id)
SELECT p.id, c.id
FROM products p, certifications c
WHERE p.slug = 'non-toxic-toothpaste' AND c.name IN ('EWG Verified', 'Leaping Bunny');

INSERT INTO product_certifications (product_id, certification_id)
SELECT p.id, c.id
FROM products p, certifications c
WHERE p.slug = 'charcoal-whitening-toothpaste' AND c.name IN ('Vegan Certified', 'Leaping Bunny');

INSERT INTO product_certifications (product_id, certification_id)
SELECT p.id, c.id
FROM products p, certifications c
WHERE p.slug = 'kids-strawberry-toothpaste' AND c.name IN ('EWG Verified', 'Made Safe');

INSERT INTO product_certifications (product_id, certification_id)
SELECT p.id, c.id
FROM products p, certifications c
WHERE p.slug = 'gentle-daily-shampoo' AND c.name IN ('EWG Verified', 'Leaping Bunny', 'Vegan Certified');

INSERT INTO product_certifications (product_id, certification_id)
SELECT p.id, c.id
FROM products p, certifications c
WHERE p.slug = 'scalp-therapy-shampoo' AND c.name IN ('Made Safe', 'Leaping Bunny');

INSERT INTO product_certifications (product_id, certification_id)
SELECT p.id, c.id
FROM products p, certifications c
WHERE p.slug = 'color-protect-shampoo' AND c.name IN ('Vegan Certified', 'Leaping Bunny');

-- =====================
-- PRODUCT TAGS
-- =====================

INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id
FROM products p, tags t
WHERE p.slug = 'non-toxic-toothpaste' AND t.slug IN ('fluoride-free', 'kids-safe', 'organic');

INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id
FROM products p, tags t
WHERE p.slug = 'charcoal-whitening-toothpaste' AND t.slug IN ('fluoride-free', 'vegan');

INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id
FROM products p, tags t
WHERE p.slug = 'kids-strawberry-toothpaste' AND t.slug IN ('fluoride-free', 'kids-safe', 'organic');

INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id
FROM products p, tags t
WHERE p.slug = 'gentle-daily-shampoo' AND t.slug IN ('sulfate-free', 'paraben-free', 'vegan');

INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id
FROM products p, tags t
WHERE p.slug = 'scalp-therapy-shampoo' AND t.slug IN ('sulfate-free', 'sensitive-scalp', 'paraben-free');

INSERT INTO product_tags (product_id, tag_id)
SELECT p.id, t.id
FROM products p, tags t
WHERE p.slug = 'color-protect-shampoo' AND t.slug IN ('sulfate-free', 'color-safe', 'vegan');

-- =====================
-- BUY LINKS
-- =====================

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Amazon', 'https://amazon.com/dp/example1', true, 1
FROM products p WHERE p.slug = 'non-toxic-toothpaste';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'iHerb', 'https://iherb.com/pr/example1', true, 2
FROM products p WHERE p.slug = 'non-toxic-toothpaste';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Amazon', 'https://amazon.com/dp/example2', true, 1
FROM products p WHERE p.slug = 'charcoal-whitening-toothpaste';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Target', 'https://target.com/p/example2', false, 2
FROM products p WHERE p.slug = 'charcoal-whitening-toothpaste';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Amazon', 'https://amazon.com/dp/example3', true, 1
FROM products p WHERE p.slug = 'kids-strawberry-toothpaste';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Walmart', 'https://walmart.com/ip/example3', false, 2
FROM products p WHERE p.slug = 'kids-strawberry-toothpaste';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Amazon', 'https://amazon.com/dp/example4', true, 1
FROM products p WHERE p.slug = 'gentle-daily-shampoo';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Thrive Market', 'https://thrivemarket.com/p/example4', true, 2
FROM products p WHERE p.slug = 'gentle-daily-shampoo';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Amazon', 'https://amazon.com/dp/example5', true, 1
FROM products p WHERE p.slug = 'scalp-therapy-shampoo';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Ulta', 'https://ulta.com/p/example5', false, 2
FROM products p WHERE p.slug = 'scalp-therapy-shampoo';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Amazon', 'https://amazon.com/dp/example6', true, 1
FROM products p WHERE p.slug = 'color-protect-shampoo';

INSERT INTO buy_links (product_id, vendor, url, is_affiliate, display_order)
SELECT p.id, 'Sephora', 'https://sephora.com/product/example6', false, 2
FROM products p WHERE p.slug = 'color-protect-shampoo';

-- =====================
-- METHODOLOGY
-- =====================

INSERT INTO methodology (version, summary, last_updated, is_current) VALUES
(
    '1.0',
    'Each product is evaluated across multiple dimensions by our team of dermatologists, chemists, and wellness researchers. The final score (0–100) reflects overall quality, safety, and alignment with evidence-based health principles. We assess Trust (brand transparency, certifications), Ingredients (purity, bioavailability), and Effectiveness (clinical evidence, real-world feedback).',
    '2025-12-15',
    true
);

INSERT INTO methodology_scoring (methodology_id, factor_name, weight, description)
SELECT m.id, factor, weight, desc
FROM methodology m
CROSS JOIN (VALUES
    ('trust', 0.30, 'Brand transparency, third-party certifications, and supply chain traceability'),
    ('ingredients', 0.40, 'Purity of ingredients, absence of harmful additives, and bioavailable forms'),
    ('effectiveness', 0.30, 'Clinical evidence, dosage adequacy, and real-world user feedback')
) AS factors(factor, weight, desc)
WHERE m.is_current = true;

-- Verify seed data
SELECT 'Categories:' AS info, COUNT(*) AS count FROM categories
UNION ALL
SELECT 'Products:', COUNT(*) FROM products
UNION ALL
SELECT 'Certifications:', COUNT(*) FROM certifications
UNION ALL
SELECT 'Tags:', COUNT(*) FROM tags;
