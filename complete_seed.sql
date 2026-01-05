-- ============================================================================
-- COMPLETE SEED FILE FOR HEALTHISWEALTH DATABASE
-- Run this file in Neon DB PostgreSQL Editor
-- Created: 2026-01-06
-- ============================================================================

-- ============================================================================
-- STAGE 1: DELETE ALL EXISTING DATA (in reverse dependency order)
-- ============================================================================

-- Delete from join/link tables first (they depend on products)
DELETE FROM product_buy_links;
DELETE FROM product_philosophy_tags;
DELETE FROM product_primary_concerns;

-- Delete products (depends on categories)
DELETE FROM products;

-- Delete lookup tables
DELETE FROM philosophy_tags;
DELETE FROM primary_concerns;

-- Delete methodologies
DELETE FROM methodologies;

-- Delete categories (base table)
DELETE FROM categories;

-- ============================================================================
-- STAGE 2: INSERT LOOKUP TABLES (primary_concerns & philosophy_tags)
-- ============================================================================

-- Primary concerns (decision drivers for why users buy products)
INSERT INTO primary_concerns (code, label, description, display_order) VALUES
('dandruff_safe', 'Dandruff Safe', 'Controls dandruff without harsh medicated actives', 1),
('hair_fall_support', 'Hair Fall Support', 'Supports hair growth cycle and reduces breakage', 2),
('dry_frizzy', 'Dry & Frizzy', 'Addresses dryness and frizz without silicone coating', 3),
('oily_scalp', 'Oily Scalp', 'Cleanses without triggering rebound oil production', 4),
('sensitive_scalp', 'Sensitive Scalp', 'Ultra-gentle for reactive or irritated scalps', 5),
('sensitivity', 'Tooth Sensitivity', 'Reduces tooth sensitivity and enamel repair', 6),
('enamel_repair', 'Enamel Repair', 'Supports natural remineralization of enamel', 7),
('gum_health', 'Gum Health', 'Supports healthy gums and reduces bleeding', 8),
('whitening', 'Whitening', 'Natural teeth whitening without harsh chemicals', 9),
('bad_breath', 'Bad Breath', 'Freshens breath naturally', 10),
('acne_prone', 'Acne Prone Skin', 'Suitable for acne-prone skin without clogging pores', 11),
('dry_skin', 'Dry Skin', 'Moisturizing and gentle for dry skin', 12),
('sensitive_skin', 'Sensitive Skin', 'Gentle formulation for sensitive skin', 13),
('oily_skin', 'Oily Skin', 'Controls excess oil without over-stripping', 14),
('anti_microbial', 'Anti-Microbial', 'Natural antimicrobial properties', 15),
('hard_water_friendly', 'Hard Water Friendly', 'Performs well in hard water conditions', 16),
('hair_growth', 'Hair Growth', 'Promotes healthy hair growth', 17),
('premature_greying', 'Premature Greying', 'Helps manage early greying', 18),
('scalp_health', 'Scalp Health', 'Overall scalp nourishment and health', 19),
('uv_protection', 'UV Protection', 'Broad spectrum UV protection', 20),
('melasma', 'Melasma Safe', 'Safe for melasma and hyperpigmentation prone skin', 21),
('blue_light', 'Blue Light Protection', 'Protects against visible blue light damage', 22);

-- Philosophy tags (brand positioning - how products are made)
INSERT INTO philosophy_tags (code, label, description, display_order) VALUES
('ayurvedic', 'Ayurvedic', 'Traditional Indian herbal formulation', 1),
('modern_clean', 'Modern Clean', 'Science-backed gentle surfactants', 2),
('certified_organic', 'Certified Organic', 'Third-party organic certification (BDIH, ECOCERT)', 3),
('zero_chemical', 'Zero Chemical', '100% botanical, no synthetic ingredients', 4),
('solid_bar', 'Solid Bar', 'Plastic-free bar format', 5),
('premium_clean', 'Premium Clean', 'Luxury positioning with clean ingredients', 6),
('cold_processed', 'Cold Processed', 'Traditional cold process manufacturing', 7),
('mineral_only', 'Mineral Only', '100% mineral UV filters', 8),
('fragrance_free', 'Fragrance Free', 'No added synthetic or natural fragrance', 9),
('vegan', 'Vegan', 'No animal-derived ingredients', 10),
('cruelty_free', 'Cruelty Free', 'Not tested on animals', 11),
('sustainable', 'Sustainable', 'Eco-friendly and sustainable practices', 12),
('made_in_india', 'Made in India', 'Proudly manufactured in India', 13),
('small_batch', 'Small Batch', 'Handcrafted in small batches for quality', 14),
('waterless', 'Waterless', 'Water-free formulation for sustainability', 15),
('women_led', 'Women Led', 'Women-led brand or business', 16),
('plastic_free', 'Plastic Free', 'Plastic-free packaging', 17),
('clinically_tested', 'Clinically Tested', 'Clinically tested for safety and efficacy', 18),
('reef_safe', 'Reef Safe', 'Safe for coral reefs and marine life', 19),
('dermat_tested', 'Dermatologist Tested', 'Tested and approved by dermatologists', 20);

-- ============================================================================
-- STAGE 3: INSERT CATEGORIES (5 categories with criteria_content)
-- ============================================================================

INSERT INTO categories (slug, title, description, long_description, status) VALUES
('shampoo', 'Shampoo', 
 'Clean hair care products evaluated for scalp health and ingredient safety.',
 'India''s shampoo market is crowded, confusing, and often misleading. Most products are designed to look effective in the short term—high foam, instant smoothness—while quietly compromising long-term scalp and hair health. Our role is simple: act as a strict filter.',
 'active'),
('toothpaste', 'Toothpaste',
 'Natural and effective oral care products analyzed for safety and efficacy.',
 'Oral care is unique because of sublingual absorption—the tissues in your mouth absorb ingredients directly into your bloodstream. Most mass-market toothpastes in India prioritize cost and "freshness" over biocompatibility. Our role is to ensure that what goes in your mouth is as safe as what goes in your stomach.',
 'active'),
('soap', 'Soap', 
 'Natural body soaps and cleansing bars analyzed for skin-friendly ingredients and pH balance.', 
 'India has one of the oldest soap traditions in the world, from Reetha and Shikakai to cold-processed Ayurvedic bars. But the modern market is filled with industrial detergent bars marketed as "natural" or "herbal." Our role is simple: separate real, skin-friendly soaps from synthetic detergent bars disguised as gentle products.',
 'active'),
('hair_oil', 'Hair Oil', 
 'Premium hair oils evaluated for nourishment, scalp health, and natural ingredient quality.', 
 'India''s hair oil tradition is perhaps the richest in the world—from grandmother''s coconut oil to complex Ayurvedic formulations. But modern commercial oils are often mineral oil with "herbal extracts" sprayed on for marketing. Our role is to identify authentic, beneficial hair oils and filter out petroleum-based imposters.',
 'active'),
('sunscreen', 'Sunscreen', 
 'Sun protection products analyzed for UVA/UVB coverage, reef safety, and skin compatibility.', 
 'India receives intense UV radiation year-round, yet most sunscreens sold here contain filters that are either unsafe for long-term use or unsuitable for our humid climate and diverse skin tones. Our role is to identify sunscreens that protect without compromising health.',
 'active');

-- ============================================================================
-- STAGE 4: INSERT METHODOLOGY
-- ============================================================================

INSERT INTO methodologies (version, summary, scoring_weights, last_updated_at) VALUES
('v1', 
 'Content-first evaluation focusing on ingredient safety, efficacy for stated concerns, and long-term health. All products must pass a strict safety gate before scoring. We evaluate: 1) Ingredient Safety & Transparency - Full INCI disclosure required, no hidden bases, 2) Formulation Quality - Appropriate actives at meaningful concentrations, 3) Efficacy for Concern - Evidence-based effectiveness for primary concerns, 4) Long-term Health - No dependency cycles, rebound effects, or cumulative harm, 5) Certifications & Trust Signals - Third-party validations valued.',
 '{
     "ingredient_safety": {"weight": 0.40, "description": "Harsh chemicals, disqualifiers, safety testing"},
     "efficacy_for_concern": {"weight": 0.30, "description": "Effectiveness for primary concern"},
     "long_term_health": {"weight": 0.20, "description": "No rebound, dependency, or damage"},
     "transparency": {"weight": 0.10, "description": "INCI clarity, certifications, honest positioning"}
 }'::jsonb,
 '2026-01-06');

-- ============================================================================
-- STAGE 5: INSERT SHAMPOO PRODUCTS (8 products)
-- ============================================================================

INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications, excluded_ingredients) VALUES
-- 1. Forest Essentials
('forest-essentials-bhringraj-shikakai-hair-cleanser',
 'Forest Essentials Hair Cleanser, Bhringraj & Shikakai',
 'Forest Essentials',
 'shampoo',
 '/images/products/forest_essentials_bhringraj_shikakai_hair_cleanser.jpg',
 'active', true, false,
 88, 'v1', '2025-11-01',
 'alternate_day', 'premium',
 'Ayurvedic, sulphate-free cleanser aimed at reducing hair fall and supporting scalp health without harsh stripping.',
 ARRAY['Formulated with traditional Ayurvedic herbs like bhringraj and shikakai.', 'SLS/SLES free and gentle for regular cleansing without dryness.', 'Supports reduction in hair thinning, breakage and promotes scalp nourishment.'],
 ARRAY['Herbal formulation', 'Gentle cleansing', 'Supports hair strength'],
 ARRAY['Premium pricing', 'Herbal scent not for everyone'],
 'Shikakai, Bhringraj, Reetha, Coconut Milk, Hydrolyzed Wheat Protein, Licorice, Kalonji Seed Oil',
 ARRAY['Ayurvedic formulation'],
 ARRAY['SLS', 'SLES', 'Parabens', 'Mineral Oil']),

-- 2. Just Herbs
('just-herbs-amla-neem-shampoo',
 '8-in-1 Root Nourishing Amla & Neem Shampoo',
 'Just Herbs',
 'shampoo',
 '/images/products/just_herbs_8_in_1_shampoo.jpg',
 'active', false, true,
 82, 'v1', '2026-01-02',
 'alternate_day', 'mid_range',
 'Herbal, ingredient-transparent anti-hairfall/dandruff shampoo that is SLS/SLES- and paraben-free.',
 ARRAY['Brand and product pages list active botanicals (Amla, Neem, Hibiscus, Henna, Fenugreek, Vetiver).', 'Explicit claims show the product is free from SLS/SLES and parabens.', 'Formulation is plant-forward and positioned for routine use for oily/dandruff-prone scalps.'],
 ARRAY['Transparent ingredient listing', 'SLS/SLES & paraben free', 'Herbal actives for dandruff/hair fall'],
 ARRAY['No major ECOCERT/COSMOS certification', 'May include mild synthetic emulsifiers'],
 'Amla, Hibiscus, Henna, Fenugreek, Neem, Vetiver, Wheatgerm Oil, Soy Lecithin',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'SLES', 'Parabens', 'PEG/PPG', 'Petrochemicals']),

-- 3. SoulTree
('soultree-licorice-bhringraj-shampoo',
 'SoulTree Licorice Hair Repair Shampoo with Bhringraj',
 'SoulTree',
 'shampoo',
 '/images/products/soultree_licorice_bhringraj_shampoo.jpg',
 'active', true, true,
 90, 'v1', '2026-01-02',
 'alternate_day', 'premium',
 'BDIH-certified, herb-forward shampoo using mild surfactants that avoid sulfates and parabens.',
 ARRAY['Full ingredient panel published (no hidden base q.s.).', 'Uses mild surfactants (Coco glucoside, Lauryl glucoside) rather than SLS/SLES.', 'Contains functional Ayurvedic botanicals (Licorice, Bhringraj, Shikakai, Amla).', 'Certified Natural under BDIH - a strong trust signal.'],
 ARRAY['BDIH certified (natural)', 'Transparent INCI', 'Mild surfactants and preservatives'],
 ARRAY['Contains fragrance with Linalool/Limonene', 'Premium price point'],
 'Coco-glucoside, Lauryl glucoside, Sodium cocoyl glutamate, Licorice, Bhringraj, Shikakai, Amla, Hibiscus, Henna, Aloe, Hydrolysed wheat protein',
 ARRAY['BDIH'],
 ARRAY['SLS', 'SLES', 'Parabens', 'Silicones', 'Mineral oil', 'Phthalates', 'Formaldehyde releasers']),

-- 4. Kama Ayurveda
('kama-ayurveda-bringadi-cleanser',
 'Bringadi Hair Cleanser (Nourishing Shampoo)',
 'Kama Ayurveda',
 'shampoo',
 '/images/products/kama_ayurveda_bringadi_cleanser.jpg',
 'active', true, true,
 88, 'v1', '2026-01-02',
 'alternate_day', 'premium',
 '96% natural-origin cleanser using mild surfactants - suitable for coloured/treated hair.',
 ARRAY['Full INCI published; surfactants are mild glucosides rather than sulfates.', 'Contains functional Ayurvedic actives (Bhringraj, Amla, Indigo, Licorice, Shikakai).', 'Product marketed for treated/coloured hair (lower risk of stripping).'],
 ARRAY['Transparent INCI', 'Mild surfactant system', 'Ayurvedic actives'],
 ARRAY['Premium price point', 'Contains fragrance'],
 'Lauryl Glucoside, Disodium Cocoyl Glutamate, Sodium Cocoamphoacetate, Bhringraj, Amla, Indigo, Licorice, Shikakai, Hibiscus',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']),

-- 5. Vilvah
('vilvah-goat-milk-shampoo',
 'Goat Milk Shampoo (with Ceramides & Pea Protein)',
 'Vilvah',
 'shampoo',
 '/images/products/vilvah_goat_milk_shampoo.jpg',
 'active', false, true,
 80, 'v1', '2026-01-02',
 'alternate_day', 'affordable',
 'pH-balanced, sulphate-free shampoo with ceramides and pea protein for dry/frizzy hair.',
 ARRAY['Brand publishes ingredient panel and markets as pH-balanced and sulphate-free.', 'Key actives - Goat Milk, Ceramides, Pea Protein - support moisture and barrier repair.', 'Uses mild surfactants (cocamidopropyl betaine, coco-glucoside) rather than SLS/SLES.'],
 ARRAY['Transparent INCI', 'Mild surfactant system', 'Functional actives for frizz control'],
 ARRAY['Contains fragrance', 'Not positioned as anti-dandruff'],
 'Goat Milk, Jasmine Hydrosol, Cocamidopropyl Betaine, Coco-Glucoside, Pea Protein, Ceramides, Hydrolysed Wheat Protein',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde releasers']),

-- 6. Arata
('arata-super-shampoo',
 'Arata Super Shampoo (Onion + Argan + Apple Cider Vinegar)',
 'Arata',
 'shampoo',
 '/images/products/arata_super_shampoo.jpg',
 'active', false, true,
 84, 'v1', '2026-01-02',
 'alternate_day', 'affordable',
 'Mild, pH-friendly shampoo with onion oil, argan oil and apple-cider vinegar for hair-fall and scalp balance.',
 ARRAY['Full ingredient list published on brand page (transparent INCI).', 'Uses gentle surfactants (Sodium Cocoyl Isethionate, Cocamidopropyl Betaine) instead of SLS/SLES.', 'Contains functional actives for hair fall and scalp balance (Onion oil, Argan oil, Apple Cider Vinegar).'],
 ARRAY['Transparent INCI', 'Mild surfactant system (SCI)', 'Functional botanicals for scalp support'],
 ARRAY['Contains fragrance', 'Not ECOCERT/BDIH certified'],
 'Sodium Cocoyl Isethionate, Sodium Cocoyl Glycinate, Cocamidopropyl Betaine, Aloe Vera, Bhringraj, Pea Protein, Apple Cider Vinegar, Argan Oil, Onion Oil',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']),

-- 7. Tribe Concepts
('tribe-concepts-hair-cleanser-powder',
 'Organic Hair Cleanser (Powdered Shikakai, Amla & Hibiscus)',
 'The Tribe Concepts',
 'shampoo',
 '/images/products/tribe_concepts_hair_cleanser_powder.jpg',
 'active', false, true,
 78, 'v1', '2026-01-02',
 'weekly_detox', 'mid_range',
 '100% botanical powdered cleanser - chemical-free and suitable as a gentle weekly detox.',
 ARRAY['Pure botanical powders (Shikakai, Amla, Hibiscus) - no synthetic surfactants.', 'Claims chemical-free, paraben/sulphate/SLS free with Godavari farms sourcing.', 'Good match for sensitive scalps or users seeking zero-chemical weekly cleanse.'],
 ARRAY['Maximum ingredient purity', 'Transparent botanical list', 'Eco/sustainable packaging'],
 ARRAY['Inconvenient for daily use', 'Limited efficacy for heavy/oily scalps'],
 'Powdered Reetha, Shikakai, Amla, Hibiscus (organic herbs from Godavari region)',
 ARRAY[]::TEXT[],
 ARRAY['All synthetic surfactants', 'Parabens', 'Preservatives']),

-- 8. Earth Rhythm
('earth-rhythm-murumuru-shampoo-bar',
 'Murumuru Butter Shampoo Bar',
 'Earth Rhythm',
 'shampoo',
 '/images/products/earth_rhythm_murumuru_shampoo_bar.jpg',
 'active', false, true,
 82, 'v1', '2026-01-02',
 'alternate_day', 'mid_range',
 'Plastic-free, SCI-based shampoo bar - gentle, pH-friendly cleansing for dry/frizzy hair.',
 ARRAY['Formulated with Sodium Cocoyl Isethionate (SCI) rather than SLS, reducing scalp irritation.', 'Murumuru butter provides conditioning lipids for dry, frizzy hair without silicone residue.', 'Solid bar format reduces plastic waste and is travel-friendly.'],
 ARRAY['Low waste / plastic-free', 'SCI-based (gentle)', 'Conditioning murumuru butter'],
 ARRAY['Learning curve for bar use', 'May contain fragrance'],
 'Murumuru butter, Sodium Cocoyl Isethionate, Glycerin, Botanical oils, Tocopherol (vitamin E)',
 ARRAY[]::TEXT[],
 ARRAY['Soap base', 'SLS', 'SLES', 'Parabens']);

-- ============================================================================
-- STAGE 6: INSERT TOOTHPASTE PRODUCTS (8 products)
-- ============================================================================

INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications, excluded_ingredients) VALUES
-- 1. Perfora
('perfora-dream-relief-sensitive-toothpaste',
 'Dream Relief (Sensitive Toothpaste)',
 'Perfora',
 'toothpaste',
 '/images/products/prefora_dream_white_toothpaste.webp',
 'active', true, true,
 88, 'v1', '2026-01-02',
 'daily_use', 'mid_range',
 'A modern, SLS-free formula using Nano-Hydroxyapatite for enamel repair.',
 ARRAY['Contains Nano-Hydroxyapatite for natural remineralization', 'Uses Xylitol to prevent cavities without toxic fluoride levels', 'Very low abrasivity (RDA) score'],
 ARRAY['Effective for sensitivity', 'Pleasant modern flavor'],
 ARRAY['Contains mild synthetic stabilizers'],
 'Nano-Hydroxyapatite, Xylitol, Aloe Vera, Vitamin C',
 ARRAY['Made Safe Certified'],
 ARRAY['SLS', 'Parabens', 'Saccharin', 'Triclosan']),

-- 2. Salt Oral Care
('salt-oral-care-dawn-dusk-set',
 'Dawn & Dusk Toothpaste Set',
 'Salt Oral Care',
 'toothpaste',
 '/images/products/salt_oral_care_toothpaste_set.jpg',
 'active', true, false,
 86, 'v1', '2026-01-02',
 'daily_use', 'premium',
 'High-end lifestyle toothpaste using N-HAp and charcoal for specific day/night needs.',
 ARRAY['Specific night formula with charcoal for deep detox', 'Day formula with Saffron for brightening', 'Uses high-grade Nano-Hydroxyapatite'],
 ARRAY['Aesthetic packaging', 'Great texture and flavor'],
 ARRAY['High price point'],
 'Nano-Hydroxyapatite, Charcoal, Saffron, Aloe Vera',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'Fluoride', 'Parabens']),

-- 3. Herbal Botanical
('herbal-botanical-toothpaste',
 'Herbal Botanical Toothpaste',
 'Botanical',
 'toothpaste',
 '/images/products/herbal_botanical_toothpaste.webp',
 'active', false, true,
 83, 'v1', '2026-01-02',
 'daily_use', 'affordable',
 'A budget-friendly daily paste that successfully avoids the Toxic-Five gate.',
 ARRAY['SLS and Fluoride-free maintenance', 'Uses traditional Neem and Clove for germ protection', 'Non-abrasive formula safe for long-term use'],
 ARRAY['Highly affordable', 'Simple ingredient list'],
 ARRAY['Basic packaging', 'Limited brand recognition'],
 'Neem, Clove, Babool, Peppermint',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'Fluoride', 'Saccharin', 'Parabens']),

-- 4. Bentodent
('bentodent-premium-mint-natural-toothpaste',
 'Natural Toothpaste (Premium Mint)',
 'Bentodent',
 'toothpaste',
 '/images/products/bentodent_natural_toothpaste.jpg',
 'active', false, true,
 84, 'v1', '2026-01-02',
 'daily_use', 'affordable',
 'Clay-based, glycerin-free toothpaste focused on natural remineralization and toxin removal.',
 ARRAY['Glycerin-free to allow teeth to remineralize naturally', 'Bentonite clay absorbs toxins without harsh abrasion', 'Purely earth-based and chemical-free'],
 ARRAY['Zero synthetic foam', 'Highly affordable'],
 ARRAY['Earthy texture may feel unusual'],
 'Bentonite Clay, Salt, Tea Tree Oil, Menthol',
 ARRAY[]::TEXT[],
 ARRAY['Glycerin', 'SLS', 'Fluoride', 'Saccharin']),

-- 5. Vicco
('vicco-vajradanti-toothpaste-herbal',
 'Vajradanti Ayurvedic Toothpaste',
 'Vicco',
 'toothpaste',
 '/images/products/vicco_vajradanti_ayurvedic_toothpaste.jpg',
 'active', false, false,
 82, 'v1', '2026-01-02',
 'daily_use', 'affordable',
 'Legacy Indian herbal paste with 18 herbs proven for gum health and tooth tightening.',
 ARRAY['Time-tested formula for tightening loose teeth', 'Purely herbal with 18 traditional medicinal barks', 'Effective at stopping gum bleeding'],
 ARRAY['Effective for gum issues', 'Budget friendly'],
 ARRAY['Medicinal taste', 'Strong brown color'],
 'Babool, Bakul, Lavang, Dalchini, Manjishtha',
 ARRAY['AYUSH'],
 ARRAY['Animal products', 'Synthetic dyes', 'Sugar']),

-- 6. Dente91
('dente91-cool-mint-toothpaste',
 'Cool Mint Toothpaste',
 'Dente91',
 'toothpaste',
 '/images/products/dente_91_enamel_pro.jpg',
 'active', false, true,
 85, 'v1', '2026-01-02',
 'daily_use', 'mid_range',
 'Science-led paste using Lactoferrin and nHAp for oral ecosystem balance.',
 ARRAY['Contains Lactoferrin to kill bad bacteria naturally', 'Uses nHAp for enamel remineralization', 'Completely SLS and Paraben free'],
 ARRAY['Advanced remineralization', 'Fights bad bacteria specifically'],
 ARRAY['Modern medicinal flavor'],
 'Nano-Hydroxyapatite, Lactoferrin, Xylitol',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'Fluoride', 'Parabens']),

-- 7. Purexa
('purexa-super-sensitive-toothpaste',
 'Super Sensitive Toothpaste',
 'Purexa',
 'toothpaste',
 '/images/products/purexa_sensitive_toothpaste.jpg',
 'active', false, true,
 81, 'v1', '2026-01-02',
 'daily_use', 'affordable',
 'A clinical-yet-natural paste designed as a safe alternative for moving away from mass-market brands.',
 ARRAY['Strictly follows the Toxic-Five gate', 'Low abrasion formula safe for enamel', 'Balanced botanical and scientific base for sensitivity'],
 ARRAY['Excellent starting point for clean oral care', 'Gentle on gums'],
 ARRAY['Standard mint flavor (not unique)'],
 'Xylitol, Meswak, Clove oil',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'Fluoride', 'Parabens', 'Triclosan']),

-- 8. Ayudant (Baidyanath)
('ayudant-herbal-toothpaste',
 'Ayudant Herbal Toothpaste',
 'Baidyanath',
 'toothpaste',
 '/images/products/ayudant_toothpaste.jpg',
 'active', false, false,
 78, 'v1', '2026-01-02',
 'daily_use', 'affordable',
 'Traditional germ protection relying on Neem and Clove with zero added sugar.',
 ARRAY['100% herbal germ protection', 'Relies on Neem and Clove for deep cleaning', 'Completely sugar-free formula'],
 ARRAY['Pure Ayurvedic lineage', 'No added sugar'],
 ARRAY['Lower availability'],
 'Neem, Pudina, Triphala, Babool, Clove',
 ARRAY['AYUSH'],
 ARRAY['Fluoride', 'Saccharin', 'Added Sugar', 'SLS']);

-- ============================================================================
-- STAGE 7: INSERT SOAP PRODUCTS (5 products)
-- ============================================================================

INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications, excluded_ingredients) VALUES
-- 1. Juicy Chemistry
('juicy-chemistry-tea-tree-neem-rosemary-soap',
 'Tea Tree, Neem and Rosemary Organic Soap',
 'Juicy Chemistry',
 'soap',
 '/images/products/TeaTreeRosemary_1024x1024.webp',
 'active', true, true,
 94, 'v1', '2025-12-10',
 'daily_use', 'mid_range',
 'EcoCert COSMOS Organic cold-process soap with neem + tea-tree for antimicrobial, acne-prone skin — fully ingredient-transparent.',
 ARRAY['EcoCert COSMOS Organic certified (third-party audited) and uses cold-process saponification.', 'Formulation uses Neem, Tea Tree and Rosemary at meaningful concentrations for antimicrobial support.', 'Anhydrous cold-process method and transparent supply chain reduce microbiological risk.', 'Dermatologically tested for safety and irritation.'],
 ARRAY['EcoCert COSMOS Organic certification', 'Full INCI disclosure and cold-process formulation', 'Effective botanical antimicrobial synergy for acne-prone skin'],
 ARRAY['Shorter shelf-life than highly preserved commercial bars', 'May be softer in humid storage conditions'],
 'Sodium Oliviate (saponified olive oil), Sodium Cocoate (saponified coconut oil), Neem Leaf Extract, Aqua, Sodium Shea Butterate, Sodium Mango Butterate, Sodium Castorate, Lavender Oil, Rosemary Oil, Tea Tree Oil',
 ARRAY['EcoCert COSMOS Organic'],
 ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']),

-- 2. SoulTree
('soultree-healing-turmeric-tulsi-soap',
 'SoulTree Healing Soap Turmeric and Tulsi',
 'SoulTree',
 'soap',
 '/images/products/Soultree_healing_soap.jpg',
 'active', true, true,
 90, 'v1', '2025-11-20',
 'daily_use', 'mid_range',
 'BDIH Certified Natural formulation using turmeric and tulsi in a high-TFM vegetable-oil soap base.',
 ARRAY['Listed as Certified Natural by BDIH — enforces exclusion of many questionable synthetics.', 'Brand publishes INCI and positions the soap as high-TFM with turmeric and tulsi for anti-inflammatory benefits.', 'Product pages indicate absence of parabens and SLS/SLES.'],
 ARRAY['BDIH / Certified Natural trust signal', 'Botanical actives with anti-inflammatory rationale', 'High-TFM vegetable-oil soap base preserves glycerin'],
 ARRAY['May contain natural fragrance allergens', 'Alkaline pH inherent to soap bars'],
 'High-TFM vegetable oil soap base, Turmeric extract, Tulsi extract, glycerin, moisturizing vegetable oils/butters',
 ARRAY['BDIH (Certified Natural)'],
 ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']),

-- 3. Rustic Art
('rustic-art-lemon-charcoal-soap',
 'Lemon Charcoal Soap',
 'Rustic Art',
 'soap',
 '/images/products/RusticArt.jpg',
 'active', true, true,
 88, 'v1', '2025-12-01',
 'daily_use', 'mid_range',
 'Cold-process, high-TFM bar with activated charcoal and lemon for oil-control and gentle exfoliation.',
 ARRAY['Cold-process formulation using balanced blend of hard and soft oils that preserves glycerin.', 'Activated charcoal provides gentle adsorption of surface oil and impurities.', 'Brand publishes full ingredient disclosure and emphasizes sustainable packaging.'],
 ARRAY['Good oil-control profile for oily/acne-prone skin', 'Cold-process preserves glycerin', 'Sustainable, plastic-free packaging'],
 ARRAY['Contains citrus-derived ingredients — potential sensitizer', 'Alkaline pH — users may need transition period'],
 'Organic Oils of Coconut, Castor, Sunflower, Rice bran, Linseed, Sesame, Karanja, Olive, Hemp, Kokum Butter, Activated Charcoal, Lemon Peel Powder, Lemongrass Oil',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']),

-- 4. Vilvah
('vilvah-classic-goat-milk-soap',
 'Classic Goat Milk Soap',
 'Vilvah',
 'soap',
 '/images/products/VilvahGoatMilk.webp',
 'active', false, true,
 87, 'v1', '2025-11-30',
 'daily_use', 'mid_range',
 'Handmade cold-processed goat-milk soap with a high-TFM vegetable oil base for dry and sensitive skin.',
 ARRAY['Vilvah documents the product as cold-processed goat-milk soap with farm-fresh goat milk.', 'Ingredient analysis shows key emollients: Extra-virgin olive oil, coconut oil and castor oil.', 'Retail listing confirms positioning for face and body use.'],
 ARRAY['Excellent moisturizing profile (goat milk + olive/coconut oils)', 'Cold-processed method preserves natural glycerin', 'Good match for dry or sensitive skin'],
 ARRAY['Alkaline pH — users switching from syndet may need transition', 'Perishable in very humid storage'],
 'Goat Milk, Extra Virgin Olive Oil, Coconut Oil, Castor Oil, Lavender essential oil, Sodium Hydroxide (Lye)',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']),

-- 5. Kaprica
('kaprica-100pct-coconut-soap',
 '100 Percent Coconut Oil Soap Lavender and Tea Tree',
 'Kaprica Naturals',
 'soap',
 '/images/products/Kaprica.webp',
 'active', false, true,
 85, 'v1', '2025-10-15',
 'daily_use', 'affordable',
 'Artisanal cold-pressed 100% coconut oil soap with high TFM for strong lather in hard water.',
 ARRAY['Formulated from pure cold-pressed coconut oil producing strong lather in hard water — TFM around 80.', 'Minimalist INCI (cold-pressed coconut oil, vegan glycerin, essential oils) reduces hidden additives.', 'Brand lists product as preservative-free and free from sulfates/parabens.'],
 ARRAY['Excellent lather in hard water due to high-lauric coconut oil', 'Very simple, short INCI list', 'Affordable artisan option'],
 ARRAY['Very cleansing (can be drying) — follow with moisturizer', 'Contains essential oils which may be sensitizers'],
 'Pure Cold Pressed Coconut Oil, Vegan Glycerin, Lavender Essential Oil, Tea Tree Essential Oil, Sodium Hydroxide (fully reacted)',
 ARRAY[]::TEXT[],
 ARRAY['SLS', 'SLES', 'Parabens', 'Formaldehyde donors']);

-- ============================================================================
-- STAGE 8: INSERT HAIR OIL PRODUCTS (10 products)
-- ============================================================================

INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications, excluded_ingredients) VALUES
-- 1. Kama Ayurveda Bringadi
('kama-ayurveda-bringadi-intensive-hair-treatment',
 'Bringadi Intensive Hair Treatment',
 'Kama Ayurveda',
 'hair_oil',
 '/images/products/kama_ayurvedha_brigandi_intensive_hair_oil.jpg',
 'active', true, false,
 96, 'v1', '2026-01-04',
 'daily_use', 'premium',
 'The gold standard of Ayurvedic hair care, using a 100% natural traditional base and extraction method.',
 ARRAY['Uses the traditional Kshir Pak Vidhi extraction method', 'Indigo and Bhringraj effectively manage early greying', 'Completely free of any chemical preservatives or synthetic scents'],
 ARRAY['Exceptional quality ingredients', 'Authentic clinical results'],
 ARRAY['High price point', 'Strong medicinal scent'],
 'Indigo, Bhringraj, Amla, Sesame Oil, Milk',
 ARRAY['100% Natural'],
 ARRAY['Mineral Oil', 'Synthetic Fragrance', 'Silicones', 'BHT', 'Artificial Colors']),

-- 2. Sesa Ayurvedic
('sesa-ayurvedic-hair-oil-traditional-gold',
 'Ayurvedic Hair Oil (Traditional Gold)',
 'Sesa',
 'hair_oil',
 '/images/products/sesa_ayurvedhic_hair_oil.jpg',
 'active', false, true,
 88, 'v1', '2026-01-04',
 'daily_use', 'affordable',
 'A budget-friendly legacy oil that maintains strict Ayurvedic integrity without mineral oils.',
 ARRAY['Boils 18 herbs in milk for 22 hours (Kshir Pak Vidhi)', 'Excellent value for a mineral-oil-free formula', 'Includes 5 essential oils for added scalp stimulation'],
 ARRAY['Very affordable', 'Time-tested formulation'],
 ARRAY['Texture is quite thick/heavy'],
 '18 Herbs (Bhringraj, Triphala), Milk, Sesame Oil, Coconut Oil',
 ARRAY['Ayurvedic Proprietary Medicine'],
 ARRAY['Mineral Oil', 'Parabens', 'BHT', 'Silicones']),

-- 3. Nat Habit Daasabuti
('nat-habit-daasabuti-hibiscus-amla-summer-oil',
 'Daasabuti Hibiscus Amla Summer Oil',
 'Nat Habit',
 'hair_oil',
 '/images/products/nat_habit_amla_hair_oil.jpg',
 'active', true, true,
 94, 'v1', '2026-01-04',
 'daily_use', 'mid_range',
 'Freshly prepared oil using whole flowers and leaves with zero chemical shelf-life extenders.',
 ARRAY['Made fresh in Ayurvedic kitchens and shipped within days', 'Infused with fresh Hibiscus flowers for natural conditioning', 'Zero preservatives; purely plant-based stability'],
 ARRAY['Very fresh feel', 'Non-greasy penetration'],
 ARRAY['Shorter shelf life (uses no preservatives)'],
 'Fresh Hibiscus, Amla, Curry Leaves, Coconut Oil, Castor Oil',
 ARRAY['100% Fresh Botanical'],
 ARRAY['Mineral Oil', 'Fragrance', 'BHT', 'Preservatives']),

-- 4. Avimee Herbal Keshpallav
('avimee-herbal-keshpallav-hair-oil',
 'Keshpallav Hair Oil',
 'Avimee Herbal',
 'hair_oil',
 '/images/products/avimee_herbal_hair_oil.jpg',
 'active', true, true,
 92, 'v1', '2026-01-04',
 'daily_use', 'mid_range',
 'A high-potency blend of 50+ herbs and cold-pressed oils focusing on modern scalp nutrition.',
 ARRAY['Contains Rosemary oil which is a proven circulation booster', 'Uses a complex variety of 50+ herbs for multi-action care', 'Extremely transparent about the lack of fillers'],
 ARRAY['Highly concentrated', 'Excellent for hair fall'],
 ARRAY['Lighter scent might not feel traditional to some'],
 'Rosemary Oil, Kalonji, Amla, Bhringraj, Seed Oil Blend',
 ARRAY[]::TEXT[],
 ARRAY['Mineral Oil', 'Silicones', 'Artificial Fragrance', 'Parabens']),

-- 5. Blue Nectar Briganantadi
('blue-nectar-briganantadi-hair-repair-treatment',
 'Briganantadi Hair Repair and Treatment',
 'Blue Nectar',
 'hair_oil',
 '/images/products/blue_nectar_hair_oil.jpg',
 'active', false, true,
 89, 'v1', '2026-01-04',
 'daily_use', 'premium',
 'A lighter, luxury Ayurvedic oil that focuses on aromatherapy and root-level repair.',
 ARRAY['Uses natural essential oils for a calming sensory experience', 'Rich in Bhringraj and Malkangani for follicle health', 'Superior glass packaging to prevent UV oxidation'],
 ARRAY['Pleasant natural aroma', 'Absorbs faster than traditional oils'],
 ARRAY['More expensive per ml than mass brands'],
 'Bhringraj, Rosemary, Lavender Oil, Sesame Oil, Coconut Oil',
 ARRAY['Ayurvedic Proprietary Medicine'],
 ARRAY['Mineral Oil', 'BHT', 'Synthetic Dyes', 'Phthalates']),

-- 6. Tribe Concepts 90 Day Miracle
('tribe-concepts-90-day-miracle-hair-oil',
 '90 Day Miracle Hair Oil',
 'The Tribe Concepts',
 'hair_oil',
 '/images/products/tribe_concepts_hair_oil.jpg',
 'active', true, false,
 93, 'v1', '2026-01-04',
 'daily_use', 'mid_range',
 'A minimalist, zero-chemical South Indian oil focused on long-term hair quality improvement.',
 ARRAY['Uses nutrient-dense Black Sesame oil as a base', 'No added fragrance; relies on the raw potency of the herbs', 'Eco-friendly tin packaging ensures no plastic leaching'],
 ARRAY['Visibly improves hair thickness', 'Eco-conscious packaging'],
 ARRAY['Earthy, raw scent is polarizing'],
 'Black Sesame Oil, Hibiscus, Amla, Indian Gooseberry',
 ARRAY['100% Chemical Free'],
 ARRAY['Mineral Oil', 'Fragrance', 'Parabens', 'Silicones']),

-- 7. Soulflower Rosemary Lavender
('soulflower-rosemary-lavender-healthy-hair-oil',
 'Rosemary Lavender Healthy Hair Oil',
 'Soulflower',
 'hair_oil',
 '/images/products/soulflower_rosemary_hair_oil.jpg',
 'active', false, true,
 87, 'v1', '2026-01-04',
 'daily_use', 'affordable',
 'A simple but effective cold-pressed blend focused on essential oil therapy for the scalp.',
 ARRAY['Hexane-free extraction of all carrier oils', 'Rosemary and Lavender provide antimicrobial scalp protection', 'Rich in Jojoba and Castor for deep moisture'],
 ARRAY['Refreshing cooling sensation', 'Good value for volume'],
 ARRAY['Strong herbal/lavender aroma'],
 'Rosemary Essential Oil, Lavender Oil, Castor Oil, Jojoba Oil',
 ARRAY['ECOCERT Raw Ingredients'],
 ARRAY['Mineral Oil', 'Hexane', 'Artificial Fragrance', 'Synthetic Colors']),

-- 8. Indulekha Bringha
('indulekha-bringha-ayurvedic-oil',
 'Bringha Ayurvedic Oil',
 'Indulekha',
 'hair_oil',
 '/images/products/indulekha_hair_oil.jpg',
 'active', false, true,
 85, 'v1', '2026-01-04',
 'daily_use', 'affordable',
 'A clinically designed Ayurvedic medicine with a patented applicator for better scalp penetration.',
 ARRAY['Virgin Coconut Oil base for maximum shaft penetration', 'Proprietary Appli-comb ensures oil reaches roots without mess', 'High concentration of Bhringraj (Eclipta Alba)'],
 ARRAY['Mess-free applicator', 'Easy to find in stores'],
 ARRAY['Distinctive medicinal smell'],
 'Bhringraj, Svetakutaja, Amla, Virgin Coconut Oil',
 ARRAY['Ayurvedic Proprietary Medicine'],
 ARRAY['Mineral Oil', 'Synthetic Dyes', 'Artificial Perfume']),

-- 9. Rustic Art Deep Conditioning
('rustic-art-deep-conditioning-hair-oil',
 'Deep Conditioning Hair Oil',
 'Rustic Art',
 'hair_oil',
 '/images/products/rustic_hair_oil.jpg',
 'active', false, true,
 91, 'v1', '2026-01-04',
 'daily_use', 'affordable',
 'A high-penetration oil using advanced plant lipids like Moringa and Avocado to deep-condition dry hair.',
 ARRAY['Uses Avocado oil which penetrates the hair cortex better than regular oils', '100% Vegan and Organic certified ingredients', 'Free of all synthetic stabilizers and silicone coatings'],
 ARRAY['Excellent for managing frizz', 'Ultra-clean ingredient list'],
 ARRAY['Standard bottle design (non-applicator)'],
 'Moringa Oil, Avocado Oil, Argan Oil, Flaxseed Oil',
 ARRAY['Organic', 'Vegan'],
 ARRAY['Mineral Oil', 'Silicones', 'Synthetic Scent', 'Parabens']),

-- 10. Khadi Natural Amla Bhringraj
('khadi-natural-amla-bhringraj-powered-botanics',
 'Amla and Bhringraj (Powered Botanics)',
 'Khadi Natural',
 'hair_oil',
 '/images/products/khadi_natural_hair_oil.jpg',
 'active', false, true,
 84, 'v1', '2026-01-04',
 'daily_use', 'affordable',
 'The specific mineral-oil-free variant of Khadi famous Amla-Bhringraj blend.',
 ARRAY['Great starting point for those moving away from commercial paraffin oils', 'Uses a pure sesame and almond base for nutrition', 'Traditional Amla infusion for vitamin C and scalp health'],
 ARRAY['Very budget friendly', 'Widely available'],
 ARRAY['Must check label to ensure it is the Powered Botanics version'],
 'Amla, Bhringraj, Neem, Henna, Sesame Oil',
 ARRAY[]::TEXT[],
 ARRAY['Mineral Oil', 'Silicones', 'Synthetic Fragrance', 'Parabens']);

-- ============================================================================
-- STAGE 9: INSERT SUNSCREEN PRODUCTS (10 products)
-- ============================================================================

INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications, excluded_ingredients) VALUES
-- 1. Re'equil Sheer Zinc Tinted
('reequil-sheer-zinc-tinted-sunscreen',
 'Sheer Zinc Tinted Sunscreen (SPF 50 PA+++)',
 'Re''equil',
 'sunscreen',
 '/images/products/re_equil_sunscrren.jpg',
 'active', true, true,
 95, 'v1', '2026-01-04',
 'daily_use', 'mid_range',
 'A high-performance 100% mineral shield with a universal tint to prevent blue-light induced pigmentation.',
 ARRAY['Uses 25% non-nano Zinc Oxide as the sole UV filter', 'Iron oxides in the tint provide essential protection against visible blue light', 'Completely free of Oxybenzone, OMC, and synthetic fragrances'],
 ARRAY['Zero white cast due to tint', 'Excellent for sensitive skin'],
 ARRAY['Thick texture requires patting to blend'],
 '25% Zinc Oxide, Physalis Angulata Extract, Vitamin E',
 ARRAY['Dermatologically Tested'],
 ARRAY['Oxybenzone', 'Octinoxate', 'Parabens', 'Fragrance']),

-- 2. Minimalist SPF 60
('minimalist-spf-60-silymarin-sunscreen',
 'Minimalist SPF 60 PA++++ Sunscreen',
 'Minimalist',
 'sunscreen',
 '/images/products/minimalist_sunscreen.jpg',
 'active', true, true,
 92, 'v1', '2026-01-04',
 'daily_use', 'mid_range',
 'Uses next-gen photostable filters and antioxidants for an invisible, weightless finish.',
 ARRAY['Features Tinosorb S and Uvinul A Plus which do not disrupt hormones', 'Infused with Silymarin (Milk Thistle) to neutralize free radicals', 'Verified SPF 60 rating via independent third-party testing'],
 ARRAY['Completely invisible finish', 'Pregnancy and lactation safe'],
 ARRAY['May feel too light for extremely dry skin'],
 'Tinosorb S, Uvinul A Plus, Silymarin, Hyaluronic Acid',
 ARRAY['Clean Label Project'],
 ARRAY['Oxybenzone', 'Homosalate', 'Octinoxate', 'Fragrance']),

-- 3. Chosen Safescreen Marina
('chosen-safescreen-marina-mineral-sunscreen',
 'Chosen Safescreen Marina (SPF 50+ PA++++)',
 'Chosen by Dermatology',
 'sunscreen',
 '/images/products/chosen_sunscreen.jpg',
 'active', true, false,
 97, 'v1', '2026-01-04',
 'daily_use', 'premium',
 'A medical-grade mineral sunscreen specifically optimized for India humid tropical climate.',
 ARRAY['Formulated to be bloodstream safe with zero systemic absorption', 'Tested for 4 hours of water and sweat resistance', 'Uses non-nano Zinc Oxide in a high-purity mineral base'],
 ARRAY['Superior humidity control', 'Strictly non-absorbed filters'],
 ARRAY['Premium price point'],
 'Non-Nano Zinc Oxide, Natural Clay, C15-19 Alkanes',
 ARRAY['ISO 24443 Tested', 'Reef Safe'],
 ARRAY['All Chemical Filters', 'Silicones', 'Fragrance']),

-- 4. SunScoop 100% Mineral
('sunscoop-100-mineral-sunscreen',
 'SunScoop 100% Mineral Sunscreen (SPF 50 PA++++)',
 'SunScoop',
 'sunscreen',
 '/images/products/sun_scoop_sunscreen.jpg',
 'active', false, true,
 89, 'v1', '2026-01-04',
 'daily_use', 'affordable',
 'A gentle, creamy mineral lotion ideal for children and reactive skin barriers.',
 ARRAY['Paediatrician-approved formula for sensitive young skin', 'Contains Xylitol and Oat extract to soothe inflammation', 'Purely physical blocking with zero chemical penetration'],
 ARRAY['Very soothing on angry skin', 'Budget-friendly mineral option'],
 ARRAY['Slight white cast on darker skin tones'],
 'Zinc Oxide, Oat Kernel Extract, Xylitol, Ceramides',
 ARRAY['FDA Approved'],
 ARRAY['Oxybenzone', 'Parabens', 'Fragrance', 'Sulphates']),

-- 5. La Shield Fisico
('la-shield-fisico-spf-50-matte-gel',
 'La Shield Fisico SPF 50+ PA+++',
 'Glenmark (La Shield)',
 'sunscreen',
 '/images/products/la_shield_sunscreen.jpg',
 'active', false, true,
 91, 'v1', '2026-01-04',
 'daily_use', 'mid_range',
 'A pharmacy-favorite mineral gel that stays put during heavy sweat and outdoor activity.',
 ARRAY['100% Micronized Zinc Oxide for transparent mineral protection', 'Completely free of preservatives and potential endocrine disruptors', 'High water resistance makes it suitable for swimming'],
 ARRAY['Sweat-proof', 'No medicinal or synthetic smell'],
 ARRAY['Heavy silicone feel'],
 '25% Micronized Zinc Oxide, Vitamin E, Alkyl Benzoate',
 ARRAY['Dermatologically Tested'],
 ARRAY['Parabens', 'Fragrance', 'Oxybenzone', 'Chemical Filters']),

-- 6. Gabit 100% Mineral Prebiotics
('gabit-100-mineral-sunscreen-prebiotics',
 'Gabit 100% Mineral Sunscreen (SPF 50 PA++++)',
 'Gabit',
 'sunscreen',
 '/images/products/gabit_sunscreen.jpg',
 'active', true, true,
 93, 'v1', '2026-01-04',
 'daily_use', 'affordable',
 'A skin-loving mineral sunscreen that uses prebiotics to nurture the skin natural ecosystem.',
 ARRAY['Powered by Prebiotics and Probiotics to improve the skin barrier', 'Contains superfoods like Ashwagandha and Amla for antioxidant support', 'Strictly excludes silicones and endocrine-disrupting filters'],
 ARRAY['Feels like a moisturizer', 'Nurtures skin microbiome'],
 ARRAY['Tint-free version may show on very deep skin tones'],
 'Zinc Oxide, Ashwagandha, Probiotics, Vitamin E, Oat Extract',
 ARRAY['FDA Approved'],
 ARRAY['Silicones', 'Mineral Oils', 'Fragrance', 'Parabens']),

-- 7. Rivela Dermascience
('rivela-dermascience-tinosorb-m-zinc-sunscreen',
 'Rivela Dermascience Tinosorb M + Zinc Oxide',
 'Cipla (Rivela)',
 'sunscreen',
 '/images/products/rivela_sunscreen.jpg',
 'active', false, true,
 88, 'v1', '2026-01-04',
 'daily_use', 'mid_range',
 'A clean hybrid sunscreen from Cipla that combines modern safe filters with botanical healing.',
 ARRAY['Combines Tinosorb M (safe organic filter) with Zinc and Titanium', 'Infused with Gotu Kola (Cica) and Green Tea to calm irritation', 'Pharmaceutical quality assurance from Cipla Health'],
 ARRAY['Acts as a smooth primer', 'Very soothing for redness'],
 ARRAY['Contains a mix of filters, not 100% mineral'],
 'Tinosorb M, Zinc Oxide, Gotu Kola, Green Tea Extract',
 ARRAY['Clinical Dermatology Tested'],
 ARRAY['Parabens', 'SLS', 'Mineral Oils']),

-- 8. UV Doux Mineral Tinted Gel
('uv-doux-mineral-tinted-sunscreen-gel',
 'UV Doux Mineral Sunscreen Gel (SPF 50 PA+++)',
 'Brinton (UV Doux)',
 'sunscreen',
 '/images/products/uv_doux_sunscreen.jpg',
 'active', true, true,
 94, 'v1', '2026-01-04',
 'daily_use', 'mid_range',
 'A water-free mineral gel that provides a weightless matte finish while preventing clogged pores.',
 ARRAY['Water-free (anhydrous) formula naturally resists bacterial growth', '100% Mineral filters with a subtle tint to neutralize white cast', 'Clinically proven non-acnegenic and hypoallergenic'],
 ARRAY['True matte finish', 'Will not sting eyes'],
 ARRAY['Gel texture can feel pasty if over-applied'],
 'Zinc Oxide, Titanium Dioxide, Vitamin E',
 ARRAY['Non-Comedogenic Certified'],
 ARRAY['Water', 'Chemical Filters', 'Parabens', 'Fragrance']),

-- 9. SkinInspired Kidscreen
('skininspired-kidscreen-mineral-sunscreen',
 'SkinInspired Kidscreen (SPF 50+ PA++++)',
 'SkinInspired',
 'sunscreen',
 '/images/products/kidscreen_sunscreen.jpg',
 'active', true, true,
 96, 'v1', '2026-01-04',
 'daily_use', 'premium',
 'The highest safety standard for pediatric and eczema-prone skin, using US FDA-approved safe ingredients.',
 ARRAY['Uses 25% non-nano Zinc Oxide (ZinClear IM) for top-tier safety', 'Packaged in airless pumps to prevent oxidation and contamination', 'Enriched with Pro-Vitamin B5 and Vitamin E to soothe delicate skin'],
 ARRAY['Airless packaging', 'Pediatrician approved'],
 ARRAY['Higher price than standard kids sunscreens'],
 '25% Non-Nano Zinc Oxide, Pro-Vitamin B5, Vitamin E',
 ARRAY['Vegan', 'Cruelty Free'],
 ARRAY['Fragrance', 'Chemical Filters', 'Parabens', 'Essential Oils']),

-- 10. Dr. Sheth's Vitamin C Ceramide
('dr-sheths-vitamin-c-ceramide-mineral-sunscreen',
 'Vitamin C and Ceramide Mineral Sunscreen',
 'Dr. Sheth''s',
 'sunscreen',
 '/images/products/sheth_sunscreen.jpg',
 'active', false, true,
 90, 'v1', '2026-01-04',
 'daily_use', 'affordable',
 'A hydrating mineral sunscreen that repairs the skin barrier while adding a natural glow.',
 ARRAY['Ceramides strengthen the skin barrier against environmental heat', 'Vitamin C helps fade sunspots and boosts overall radiance', 'Specifically formulated for the hydration needs of Indian skin'],
 ARRAY['Moisturizing finish', 'No white cast for a mineral paste'],
 ARRAY['Not water-resistant; requires frequent reapplication if sweating'],
 'Zinc Oxide, Titanium Dioxide, Ceramides, Vitamin C',
 ARRAY['Dermatologically Tested'],
 ARRAY['Oxybenzone', 'Fragrance', 'Parabens']);

-- ============================================================================
-- STAGE 10: INSERT PRODUCT_PRIMARY_CONCERNS (join table)
-- ============================================================================

-- SHAMPOO CONCERNS
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dandruff_safe' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dandruff_safe' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'oily_scalp' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dandruff_safe' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'oily_scalp' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'arata-super-shampoo';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dandruff_safe' FROM products WHERE slug = 'arata-super-shampoo';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'arata-super-shampoo';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitive_scalp' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';

-- TOOTHPASTE CONCERNS
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitivity' FROM products WHERE slug = 'perfora-dream-relief-sensitive-toothpaste';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'enamel_repair' FROM products WHERE slug = 'perfora-dream-relief-sensitive-toothpaste';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'whitening' FROM products WHERE slug = 'salt-oral-care-dawn-dusk-set';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'gum_health' FROM products WHERE slug = 'salt-oral-care-dawn-dusk-set';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'bad_breath' FROM products WHERE slug = 'salt-oral-care-dawn-dusk-set';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'gum_health' FROM products WHERE slug = 'herbal-botanical-toothpaste';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'bad_breath' FROM products WHERE slug = 'herbal-botanical-toothpaste';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'bad_breath' FROM products WHERE slug = 'bentodent-premium-mint-natural-toothpaste';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'gum_health' FROM products WHERE slug = 'vicco-vajradanti-toothpaste-herbal';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'enamel_repair' FROM products WHERE slug = 'dente91-cool-mint-toothpaste';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitivity' FROM products WHERE slug = 'dente91-cool-mint-toothpaste';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitivity' FROM products WHERE slug = 'purexa-super-sensitive-toothpaste';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'enamel_repair' FROM products WHERE slug = 'purexa-super-sensitive-toothpaste';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'gum_health' FROM products WHERE slug = 'ayudant-herbal-toothpaste';

-- SOAP CONCERNS
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'acne_prone' FROM products WHERE slug = 'juicy-chemistry-tea-tree-neem-rosemary-soap';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'anti_microbial' FROM products WHERE slug = 'juicy-chemistry-tea-tree-neem-rosemary-soap';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitive_skin' FROM products WHERE slug = 'soultree-healing-turmeric-tulsi-soap';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'anti_microbial' FROM products WHERE slug = 'soultree-healing-turmeric-tulsi-soap';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'oily_skin' FROM products WHERE slug = 'rustic-art-lemon-charcoal-soap';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'acne_prone' FROM products WHERE slug = 'rustic-art-lemon-charcoal-soap';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_skin' FROM products WHERE slug = 'vilvah-classic-goat-milk-soap';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitive_skin' FROM products WHERE slug = 'vilvah-classic-goat-milk-soap';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hard_water_friendly' FROM products WHERE slug = 'kaprica-100pct-coconut-soap';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_skin' FROM products WHERE slug = 'kaprica-100pct-coconut-soap';

-- HAIR OIL CONCERNS
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'premature_greying' FROM products WHERE slug = 'kama-ayurveda-bringadi-intensive-hair-treatment';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'kama-ayurveda-bringadi-intensive-hair-treatment';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_growth' FROM products WHERE slug = 'sesa-ayurvedic-hair-oil-traditional-gold';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'scalp_health' FROM products WHERE slug = 'sesa-ayurvedic-hair-oil-traditional-gold';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'scalp_health' FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'avimee-herbal-keshpallav-hair-oil';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_growth' FROM products WHERE slug = 'avimee-herbal-keshpallav-hair-oil';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'scalp_health' FROM products WHERE slug = 'blue-nectar-briganantadi-hair-repair-treatment';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'blue-nectar-briganantadi-hair-repair-treatment';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_growth' FROM products WHERE slug = 'tribe-concepts-90-day-miracle-hair-oil';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'scalp_health' FROM products WHERE slug = 'soulflower-rosemary-lavender-healthy-hair-oil';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'soulflower-rosemary-lavender-healthy-hair-oil';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'indulekha-bringha-ayurvedic-oil';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_growth' FROM products WHERE slug = 'indulekha-bringha-ayurvedic-oil';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_frizzy' FROM products WHERE slug = 'rustic-art-deep-conditioning-hair-oil';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'scalp_health' FROM products WHERE slug = 'khadi-natural-amla-bhringraj-powered-botanics';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'hair_fall_support' FROM products WHERE slug = 'khadi-natural-amla-bhringraj-powered-botanics';

-- SUNSCREEN CONCERNS
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'melasma' FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'blue_light' FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'uv_protection' FROM products WHERE slug = 'minimalist-spf-60-silymarin-sunscreen';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'oily_skin' FROM products WHERE slug = 'minimalist-spf-60-silymarin-sunscreen';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'uv_protection' FROM products WHERE slug = 'chosen-safescreen-marina-mineral-sunscreen';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitive_skin' FROM products WHERE slug = 'sunscoop-100-mineral-sunscreen';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'uv_protection' FROM products WHERE slug = 'la-shield-fisico-spf-50-matte-gel';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'acne_prone' FROM products WHERE slug = 'la-shield-fisico-spf-50-matte-gel';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitive_skin' FROM products WHERE slug = 'gabit-100-mineral-sunscreen-prebiotics';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'uv_protection' FROM products WHERE slug = 'rivela-dermascience-tinosorb-m-zinc-sunscreen';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitive_skin' FROM products WHERE slug = 'rivela-dermascience-tinosorb-m-zinc-sunscreen';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'acne_prone' FROM products WHERE slug = 'uv-doux-mineral-tinted-sunscreen-gel';
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'oily_skin' FROM products WHERE slug = 'uv-doux-mineral-tinted-sunscreen-gel';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'sensitive_skin' FROM products WHERE slug = 'skininspired-kidscreen-mineral-sunscreen';

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT id, 'dry_skin' FROM products WHERE slug = 'dr-sheths-vitamin-c-ceramide-mineral-sunscreen';

-- ============================================================================
-- STAGE 11: INSERT PRODUCT_PHILOSOPHY_TAGS (join table)
-- ============================================================================

-- SHAMPOO PHILOSOPHY TAGS
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'certified_organic' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'small_batch' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'arata-super-shampoo';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'arata-super-shampoo';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'waterless' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'women_led' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'plastic_free' FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';

-- TOOTHPASTE PHILOSOPHY TAGS
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'perfora-dream-relief-sensitive-toothpaste';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'clinically_tested' FROM products WHERE slug = 'perfora-dream-relief-sensitive-toothpaste';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'perfora-dream-relief-sensitive-toothpaste';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'salt-oral-care-dawn-dusk-set';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'salt-oral-care-dawn-dusk-set';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'herbal-botanical-toothpaste';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'herbal-botanical-toothpaste';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'bentodent-premium-mint-natural-toothpaste';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'bentodent-premium-mint-natural-toothpaste';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'vicco-vajradanti-toothpaste-herbal';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'vicco-vajradanti-toothpaste-herbal';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'dente91-cool-mint-toothpaste';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'clinically_tested' FROM products WHERE slug = 'dente91-cool-mint-toothpaste';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'dente91-cool-mint-toothpaste';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'purexa-super-sensitive-toothpaste';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'clinically_tested' FROM products WHERE slug = 'purexa-super-sensitive-toothpaste';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'purexa-super-sensitive-toothpaste';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'ayudant-herbal-toothpaste';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'ayudant-herbal-toothpaste';

-- SOAP PHILOSOPHY TAGS
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'certified_organic' FROM products WHERE slug = 'juicy-chemistry-tea-tree-neem-rosemary-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'small_batch' FROM products WHERE slug = 'juicy-chemistry-tea-tree-neem-rosemary-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'juicy-chemistry-tea-tree-neem-rosemary-soap';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'certified_organic' FROM products WHERE slug = 'soultree-healing-turmeric-tulsi-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'soultree-healing-turmeric-tulsi-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'soultree-healing-turmeric-tulsi-soap';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'rustic-art-lemon-charcoal-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'plastic_free' FROM products WHERE slug = 'rustic-art-lemon-charcoal-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'rustic-art-lemon-charcoal-soap';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'vilvah-classic-goat-milk-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'small_batch' FROM products WHERE slug = 'vilvah-classic-goat-milk-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'vilvah-classic-goat-milk-soap';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'kaprica-100pct-coconut-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'fragrance_free' FROM products WHERE slug = 'kaprica-100pct-coconut-soap';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'kaprica-100pct-coconut-soap';

-- HAIR OIL PHILOSOPHY TAGS
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'kama-ayurveda-bringadi-intensive-hair-treatment';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'kama-ayurveda-bringadi-intensive-hair-treatment';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'sesa-ayurvedic-hair-oil-traditional-gold';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'sesa-ayurvedic-hair-oil-traditional-gold';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'small_batch' FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'women_led' FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'avimee-herbal-keshpallav-hair-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'avimee-herbal-keshpallav-hair-oil';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'blue-nectar-briganantadi-hair-repair-treatment';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'blue-nectar-briganantadi-hair-repair-treatment';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'tribe-concepts-90-day-miracle-hair-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'women_led' FROM products WHERE slug = 'tribe-concepts-90-day-miracle-hair-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'tribe-concepts-90-day-miracle-hair-oil';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'soulflower-rosemary-lavender-healthy-hair-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'soulflower-rosemary-lavender-healthy-hair-oil';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'indulekha-bringha-ayurvedic-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'clinically_tested' FROM products WHERE slug = 'indulekha-bringha-ayurvedic-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'indulekha-bringha-ayurvedic-oil';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'rustic-art-deep-conditioning-hair-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'plastic_free' FROM products WHERE slug = 'rustic-art-deep-conditioning-hair-oil';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'rustic-art-deep-conditioning-hair-oil';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'ayurvedic' FROM products WHERE slug = 'khadi-natural-amla-bhringraj-powered-botanics';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'khadi-natural-amla-bhringraj-powered-botanics';

-- SUNSCREEN PHILOSOPHY TAGS
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'reef_safe' FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'dermat_tested' FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'minimalist-spf-60-silymarin-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'dermat_tested' FROM products WHERE slug = 'minimalist-spf-60-silymarin-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'minimalist-spf-60-silymarin-sunscreen';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'chosen-safescreen-marina-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'reef_safe' FROM products WHERE slug = 'chosen-safescreen-marina-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'dermat_tested' FROM products WHERE slug = 'chosen-safescreen-marina-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'chosen-safescreen-marina-mineral-sunscreen';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'sunscoop-100-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'reef_safe' FROM products WHERE slug = 'sunscoop-100-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'fragrance_free' FROM products WHERE slug = 'sunscoop-100-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'sunscoop-100-mineral-sunscreen';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'la-shield-fisico-spf-50-matte-gel';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'dermat_tested' FROM products WHERE slug = 'la-shield-fisico-spf-50-matte-gel';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'la-shield-fisico-spf-50-matte-gel';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'gabit-100-mineral-sunscreen-prebiotics';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'reef_safe' FROM products WHERE slug = 'gabit-100-mineral-sunscreen-prebiotics';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'fragrance_free' FROM products WHERE slug = 'gabit-100-mineral-sunscreen-prebiotics';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'gabit-100-mineral-sunscreen-prebiotics';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'rivela-dermascience-tinosorb-m-zinc-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'dermat_tested' FROM products WHERE slug = 'rivela-dermascience-tinosorb-m-zinc-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'rivela-dermascience-tinosorb-m-zinc-sunscreen';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'uv-doux-mineral-tinted-sunscreen-gel';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'dermat_tested' FROM products WHERE slug = 'uv-doux-mineral-tinted-sunscreen-gel';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'uv-doux-mineral-tinted-sunscreen-gel';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'skininspired-kidscreen-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'reef_safe' FROM products WHERE slug = 'skininspired-kidscreen-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'fragrance_free' FROM products WHERE slug = 'skininspired-kidscreen-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'skininspired-kidscreen-mineral-sunscreen';

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'modern_clean' FROM products WHERE slug = 'dr-sheths-vitamin-c-ceramide-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'dermat_tested' FROM products WHERE slug = 'dr-sheths-vitamin-c-ceramide-mineral-sunscreen';
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT id, 'made_in_india' FROM products WHERE slug = 'dr-sheths-vitamin-c-ceramide-mineral-sunscreen';

-- ============================================================================
-- STAGE 12: INSERT PRODUCT_BUY_LINKS
-- ============================================================================

-- SHAMPOO BUY LINKS
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://a.co/d/3rWo6GR', 'affiliate' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/guRv2SD', 'affiliate' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/60xTpP8', 'affiliate' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/6mmpChY', 'affiliate' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/bGnBqar', 'affiliate' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products WHERE slug = 'vilvah-goat-milk-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/axLaYgb', 'affiliate' FROM products WHERE slug = 'arata-super-shampoo';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products WHERE slug = 'arata-super-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/2YoSmJk', 'affiliate' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/fWlyCj7', 'affiliate' FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';

-- TOOTHPASTE BUY LINKS
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/incxBDP', 'affiliate' FROM products WHERE slug = 'perfora-dream-relief-sensitive-toothpaste';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/perfora-dream-white-fresh-mint-instant-teeth-whitening-sls-free-toothpaste/p/itm1631d551c1f6d', 'affiliate' FROM products WHERE slug = 'perfora-dream-relief-sensitive-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/bevNcna', 'affiliate' FROM products WHERE slug = 'salt-oral-care-dawn-dusk-set';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/salt-dusk-night-toothpaste-french-vanilla-enamel-protection-sls-fluoride-free/p/itm5c8d125923727', 'affiliate' FROM products WHERE slug = 'salt-oral-care-dawn-dusk-set';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/iqc75Lr', 'affiliate' FROM products WHERE slug = 'herbal-botanical-toothpaste';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/herbal-botanical-toothpaste-toothpaste-white-teeth-stronger-teeth-fresh-breath-toothpaste/p/itm0422320ac27d5', 'affiliate' FROM products WHERE slug = 'herbal-botanical-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/f9jAmtW', 'affiliate' FROM products WHERE slug = 'bentodent-premium-mint-natural-toothpaste';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/bentodent-premium-mint-natural-toothpaste/p/itmd9b990e20f4b2', 'affiliate' FROM products WHERE slug = 'bentodent-premium-mint-natural-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/hW0jiZq', 'affiliate' FROM products WHERE slug = 'vicco-vajradanti-toothpaste-herbal';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/vicco-vajradanti-regular-flavour-medicine-gums-teeth-with-18-ayurvedic-herbs-toothpaste/p/itm85769f826aa72', 'affiliate' FROM products WHERE slug = 'vicco-vajradanti-toothpaste-herbal';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/dofFFso', 'affiliate' FROM products WHERE slug = 'dente91-cool-mint-toothpaste';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/dente91-sensitivity-relief-repairs-cavities-free-sls-fluoride-toothpaste/p/itmff107678dd0fd', 'affiliate' FROM products WHERE slug = 'dente91-cool-mint-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/3bZ08mp', 'affiliate' FROM products WHERE slug = 'purexa-super-sensitive-toothpaste';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/purexa-sensitive-toothpaste-pack-2/p/itm4a51290672512', 'affiliate' FROM products WHERE slug = 'purexa-super-sensitive-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/21RJKW7', 'affiliate' FROM products WHERE slug = 'ayudant-herbal-toothpaste';

-- SOAP BUY LINKS
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Juicy Chemistry', 'https://www.juicychemistry.co.za/shop/face-care/tea-tree-neem-rosemary/', 'affiliate' FROM products WHERE slug = 'juicy-chemistry-tea-tree-neem-rosemary-soap';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/cdoYSRz', 'affiliate' FROM products WHERE slug = 'soultree-healing-turmeric-tulsi-soap';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/soultree-healing-soap-turmeric-tulsi/p/itma2164c0f953cc', 'affiliate' FROM products WHERE slug = 'soultree-healing-turmeric-tulsi-soap';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/hHr5f14', 'affiliate' FROM products WHERE slug = 'rustic-art-lemon-charcoal-soap';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/rustic-art-lemon-charcoal-soap/p/itm0c7678419bcaa', 'affiliate' FROM products WHERE slug = 'rustic-art-lemon-charcoal-soap';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/vilvah-classic-goatmilk-soap-dry-skin/p/itm8e16fa72811f8', 'affiliate' FROM products WHERE slug = 'vilvah-classic-goat-milk-soap';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Vilvah Store', 'https://www.vilvahstore.com/products/classic-goatmilk-soap', 'affiliate' FROM products WHERE slug = 'vilvah-classic-goat-milk-soap';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/24aJTwT', 'affiliate' FROM products WHERE slug = 'kaprica-100pct-coconut-soap';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/kaprica-natural-handmade-pure-cold-pressed-coconut-oil-soap/p/itmfgghcuzyrjgee', 'affiliate' FROM products WHERE slug = 'kaprica-100pct-coconut-soap';

-- HAIR OIL BUY LINKS
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/ci8TZoe', 'affiliate' FROM products WHERE slug = 'kama-ayurveda-bringadi-intensive-hair-treatment';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/kama-ayurveda-bringadi-intensive-treatment-hair-oil/p/itmf3jyq4hyxcyjw', 'affiliate' FROM products WHERE slug = 'kama-ayurveda-bringadi-intensive-hair-treatment';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/2X2uCqg', 'affiliate' FROM products WHERE slug = 'sesa-ayurvedic-hair-oil-traditional-gold';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/sesa-ayurvedic-hair-growth-oil-bhringraj/p/itm1a5d629d958f3', 'affiliate' FROM products WHERE slug = 'sesa-ayurvedic-hair-oil-traditional-gold';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/30wYWHt', 'affiliate' FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/nat-habit-hibiscus-amla-hair-growth-summer-dasabuti-oil-fall-massage-dry-frizzy-treatment-ayurvedic-herbal-fresh-made-16-herbs-heat-soaked-castor-coconut-100ml/p/itm3d33b421e332d', 'affiliate' FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/gSx0mnr', 'affiliate' FROM products WHERE slug = 'avimee-herbal-keshpallav-hair-oil';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/avimee-herbal-keshpallav-hair-oil/p/itm343cb3e83bfca', 'affiliate' FROM products WHERE slug = 'avimee-herbal-keshpallav-hair-oil';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://www.amazon.in/Blue-Nectar-Briganantadi-control-Healthy/dp/B07DV8FHD3', 'affiliate' FROM products WHERE slug = 'blue-nectar-briganantadi-hair-repair-treatment';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/blue-nectar-briganantadi-hair-fall-control-treatment-bringha-oil-coconut/p/itm9956b9d082891', 'affiliate' FROM products WHERE slug = 'blue-nectar-briganantadi-hair-repair-treatment';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/5KT5Gje', 'affiliate' FROM products WHERE slug = 'tribe-concepts-90-day-miracle-hair-oil';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/tribe-concepts-90-day-miracle-hair-oil/p/itm8dcaed8f7b89e', 'affiliate' FROM products WHERE slug = 'tribe-concepts-90-day-miracle-hair-oil';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://www.amazon.in/Soulflower-Natural-Rosemary-Lavender-Healthy/dp/B06XFWVWMS', 'affiliate' FROM products WHERE slug = 'soulflower-rosemary-lavender-healthy-hair-oil';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/soulflower-rosemary-lavender-oil-healthy-hair-growth-good-damaged/p/itm774114cbefa01', 'affiliate' FROM products WHERE slug = 'soulflower-rosemary-lavender-healthy-hair-oil';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/9fl0T6d', 'affiliate' FROM products WHERE slug = 'indulekha-bringha-ayurvedic-oil';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/indulekha-bringha-ayurvedic-hair-oil-new-growth-oil/p/itm3857fa0ccfa5f', 'affiliate' FROM products WHERE slug = 'indulekha-bringha-ayurvedic-oil';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/iQ4NZ4W', 'affiliate' FROM products WHERE slug = 'rustic-art-deep-conditioning-hair-oil';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/rustic-art-organic-deep-conditioning-hair-oil/p/itm59ad2dfe14a8c', 'affiliate' FROM products WHERE slug = 'rustic-art-deep-conditioning-hair-oil';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/9RDPQ6x', 'affiliate' FROM products WHERE slug = 'khadi-natural-amla-bhringraj-powered-botanics';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/khadi-natural-amla-bhringraj-hair-oil-powered-botanics-oil/p/itm1bd7cba9ec8d6', 'affiliate' FROM products WHERE slug = 'khadi-natural-amla-bhringraj-powered-botanics';

-- SUNSCREEN BUY LINKS
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/0CoIr34', 'affiliate' FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/re-equil-sheer-zinc-tinted-sunscreen-100-mineral-spf-50-pa/p/itmfd1a4133e5d8a', 'affiliate' FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/7au0jqC', 'affiliate' FROM products WHERE slug = 'minimalist-spf-60-silymarin-sunscreen';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/minimalist-sunscreen-spf-60-pa-sun-cream-sensitive-acne-prone-skin-pregnancy-safe/p/itmc156746b227cf', 'affiliate' FROM products WHERE slug = 'minimalist-spf-60-silymarin-sunscreen';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/aSVkY1b', 'affiliate' FROM products WHERE slug = 'chosen-safescreen-marina-mineral-sunscreen';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/', 'affiliate' FROM products WHERE slug = 'chosen-safescreen-marina-mineral-sunscreen';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/6drg7Bg', 'affiliate' FROM products WHERE slug = 'sunscoop-100-mineral-sunscreen';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'http://flipkart.com/sunscoop-sunscreen-spf-50-pa-kids-lotion-100-mineral/p/itmdc429ac2722d4', 'affiliate' FROM products WHERE slug = 'sunscoop-100-mineral-sunscreen';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/6JBcScs', 'affiliate' FROM products WHERE slug = 'la-shield-fisico-spf-50-matte-gel';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/la-shield-fisico-spf-50-pa/p/itmcd164dae78bc4', 'affiliate' FROM products WHERE slug = 'la-shield-fisico-spf-50-matte-gel';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/9s54I6n', 'affiliate' FROM products WHERE slug = 'gabit-100-mineral-sunscreen-prebiotics';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/gabit-sunscreen-spf-50-pa-100-mineral/p/itmedb53fb2f9a8c', 'affiliate' FROM products WHERE slug = 'gabit-100-mineral-sunscreen-prebiotics';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/1td73Ws', 'affiliate' FROM products WHERE slug = 'rivela-dermascience-tinosorb-m-zinc-sunscreen';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/rivela-sunscreen-spf-50-pa-pa/p/itmd530982cbad25', 'affiliate' FROM products WHERE slug = 'rivela-dermascience-tinosorb-m-zinc-sunscreen';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/0rMB5fB', 'affiliate' FROM products WHERE slug = 'uv-doux-mineral-tinted-sunscreen-gel';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/brinton-sunscreen-spf-50-pa-uv-doux-mineral/p/itmaa14d2e8a9fe8', 'affiliate' FROM products WHERE slug = 'uv-doux-mineral-tinted-sunscreen-gel';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/0IrBHJ4', 'affiliate' FROM products WHERE slug = 'skininspired-kidscreen-mineral-sunscreen';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/skininspired-sunscreen-spf-50-pa-kidscreen-100-mineral-sunscreen-non-greasy-vitamin-e-pro-b5/p/itm63c38a6c7187e', 'affiliate' FROM products WHERE slug = 'skininspired-kidscreen-mineral-sunscreen';

INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Amazon', 'https://amzn.in/d/bVd345F', 'affiliate' FROM products WHERE slug = 'dr-sheths-vitamin-c-ceramide-mineral-sunscreen';
INSERT INTO product_buy_links (product_id, vendor, url, link_type)
SELECT id, 'Flipkart', 'https://www.flipkart.com/dr-sheth-s-sunscreen-spf-50-pa-ceramide-vitamin-c-long-lasting/p/itmb7c79e8efd5d8', 'affiliate' FROM products WHERE slug = 'dr-sheths-vitamin-c-ceramide-mineral-sunscreen';

-- ============================================================================
-- STAGE 13: UPDATE CATEGORIES WITH CRITERIA CONTENT (long_description)
-- ============================================================================

-- SHAMPOO CRITERIA
UPDATE categories SET long_description = '## Shampoo Selection Criteria
### How we decide which shampoos deserve a place here

India''s shampoo market is crowded, confusing, and often misleading. Most products are designed to look effective in the short term—high foam, instant smoothness—while quietly compromising long-term scalp and hair health.

Our role is simple: **act as a strict filter.**

If a shampoo appears on this platform, it has cleared a bar that most mass-market products do not. Below is exactly how that bar is defined.

---

## 1. Our Non-Negotiable Exclusions (Pass/Fail Gate)

Before we evaluate benefits, performance, or price, a shampoo must first pass a safety audit. Any product containing any of the following is **automatically excluded**.

### ❌ Sulfates (SLS / SLES)
- Commonly used for strong foaming and low cost
- Scientifically known to disrupt the scalp''s natural lipid barrier
- Associated with dryness, irritation, rebound oiliness, and long-term scalp inflammation
- SLES additionally carries contamination risk with 1,4-dioxane, a probable carcinogen

**Our position:** A cleanser should clean without stripping. Sulfates fail that test.

### ❌ Formaldehyde Releasers
(e.g. DMDM Hydantoin, Diazolidinyl Urea)
- Release small amounts of formaldehyde over time
- Linked to contact dermatitis, allergic sensitization, and hair fall
- Still widely used in Indian mass brands due to low cost and shelf stability

**Our position:** No health-first product should expose the scalp to a known carcinogen—at any dose.

### ❌ Parabens
- Widely used preservatives
- Act as endocrine disruptors (xenoestrogens)
- Raise concerns around hormonal health with cumulative exposure

**Our position:** With safer preservation systems available, parabens are unnecessary.

### ❌ Hidden or Undisclosed "Base Q.S."
- Common in so-called "Ayurvedic" shampoos
- Allows brands to hide surfactants and preservatives behind vague labeling
- Prevents consumers from verifying safety claims

**Our position:** If ingredients are not fully disclosed, trust is impossible.

---

## 2. Cleansing Agents We Do Allow (And Why)

A shampoo must clean effectively, but gently. We approve only surfactants that meet three criteria:
1. Low irritation potential
2. Biodegradability
3. Compatibility with the scalp''s natural pH (~5.5)

### ✅ Approved Cleansing Systems
- Decyl Glucoside
- Sodium Cocoyl Glutamate
- Sodium Lauroyl Sarcosinate
- Sodium Cocoyl Isethionate (SCI)
- Reetha / Shikakai (traditional saponins)

These agents clean without triggering the damage-and-mask cycle created by sulfates and silicones.

---

## 3. Ingredient Philosophy: Ayurveda, But Verifiable

India has one of the richest hair-care traditions in the world. We value that—but only when it is used transparently and scientifically.

### Ayurvedic Ingredients We Actively Look For
- **Bhringraj** – supports hair growth cycles
- **Amla** – antioxidant protection, hair fall support
- **Shikakai** – natural cleanser with acidic pH
- **Reetha** – mild, hypoallergenic cleansing
- **Neem** – antifungal, dandruff control

### What We Don''t Accept
- Token herbs added for marketing
- "Herbal actives" layered on top of a harsh synthetic base
- Ayurvedic claims without full INCI disclosure

**Our position:** Ayurveda is powerful when done honestly—and misleading when used as a label.

---

## 4. Regulatory Compliance is the Baseline, Not the Badge

All listed shampoos must meet BIS safety standards for:
- pH balance
- Heavy metal limits (Lead, Arsenic)
- Manufacturing hygiene

However, BIS compliance alone is not enough, as it still permits sulfates, parabens, and formaldehyde releasers.

### Additional Trust Signals We Value
- ECOCERT / COSMOS
- BDIH (Certified Natural Cosmetics)
- Export-grade GMP standards
- Full ingredient transparency

---

## 5. Performance is Judged Long-Term, Not on First Wash

Many people transitioning from conventional shampoos experience a short "adjustment period" as silicone buildup washes out. This is normal.

We evaluate shampoos based on:
- Scalp comfort over time
- Reduction in itch, dandruff, or oil rebound
- Hair strength and texture after repeated use
- Absence of dependency cycles

**Instant smoothness is not our goal. Sustainable scalp health is.**

---

## 6. How We Score Shampoos

Every approved shampoo receives a composite score (0–100) based on:
- Ingredient safety & transparency
- Cleansing gentleness
- Active ingredient relevance
- Regulatory & certification strength
- Value for money in its segment

Only products that pass our safety gate are scored. Products that fail are excluded entirely.

---

## 7. What This Means For You

If a shampoo appears here:
- It passed a stricter standard than Indian regulations require
- It is safe for long-term, regular use
- Its ingredients are disclosed and evaluated
- It prioritizes scalp health over cosmetic illusion

You still choose what fits your hair type and budget. We ensure the risk is already removed.

---

## Our Promise

- We do not accept payment to change criteria.
- We do not lower standards for popular brands.
- We review products the way we would for our own families.'
WHERE slug = 'shampoo';

-- TOOTHPASTE CRITERIA
UPDATE categories SET long_description = '## Toothpaste Selection Criteria
### How we decide which oral care products deserve a place here

Oral care is unique because of **sublingual absorption**—the tissues in your mouth absorb ingredients directly into your bloodstream. Most mass-market toothpastes in India prioritize cost and "freshness" over biocompatibility.

Our role is to ensure that what goes in your mouth is as safe as what goes in your stomach.

---

## 1. Our Non-Negotiable Exclusions (The "Toxic-Five" Gate)

Any product containing these is **automatically disqualified**:

### ❌ Sodium Lauryl Sulfate (SLS)
- The primary cause of canker sores (mouth ulcers) and dry mouth
- Used only for foaming; provides zero cleaning benefit to teeth

**Our position:** A toothpaste doesn''t need to be a soap.

### ❌ Triclosan
- An antibacterial pesticide linked to thyroid issues and antibiotic resistance
- Banned by the US FDA for hand soaps but still permitted in many Indian toothpastes

**Our position:** We do not allow endocrine disruptors in daily-use products.

### ❌ Saccharin & Aspartame
- Artificial sweeteners used to mask the bitter taste of chemicals
- Linked to gut microbiome disruption

**Our position:** Sweetness should come from Xylitol or Stevia, which actually help teeth.

### ❌ Microbeads (Plastic)
- Small plastic particles used for "scrubbing" that trap bacteria in gum pockets

**Our position:** Physical cleaning should come from safe clays or minerals.

### ❌ Parabens & Formaldehyde Donors
- Cheap preservatives used for long shelf life in humid Indian conditions

**Our position:** Safe, modern preservation is mandatory.

---

## 2. Approved Actives (What We Look For)

We prioritize ingredients that work with the mouth''s natural ecosystem rather than nuking it with chemicals.

### ✅ Nano-Hydroxyapatite (nHAp)
The gold standard for clean care. It is what your teeth are actually made of. It fills in microscopic cracks to reduce sensitivity and remineralize enamel naturally.

### ✅ Xylitol
A birch-derived sugar that oral bacteria cannot digest, effectively "starving" the bacteria that cause cavities.

### ✅ Bentonite/Kaolin Clay
Natural minerals that polish teeth gently and "adsorb" toxins without stripping enamel.

### ✅ Traditional Indian Botanicals
- **Neem** – antifungal
- **Miswak** – antibacterial
- **Clove** – analgesic
- **Babool** – astringent/gum tightening

---

## 3. The Fluoride Stance

Fluoride is a complex topic in India due to high naturally occurring fluoride in the groundwater of many states (Risk of Fluorosis).

- We **prefer Fluoride-free formulas** for general maintenance
- We only list Fluoride-containing pastes if they are transparent about dosage and use a "Clean Label" base, specifically for those with high cavity risk

---

## 4. Transparency & Origin

### Full Disclosure
We reject brands that list "Paste Base Q.S." or "Herbal Base." Every ingredient, including the surfactant and preservative, must be named (INCI).

### Made in India
We prioritize Indian brands that utilize local Ayurvedic wisdom combined with global manufacturing standards (GMP).

---

## 5. Scoring Logic

Every toothpaste is scored (0–100) on:
- **Enamel Safety:** Low Relative Dentin Abrasivity (RDA)
- **Gum Support:** Presence of anti-inflammatory herbs
- **Biocompatibility:** Absence of synthetic dyes and harsh detergents
- **Taste & Experience:** Stability and "after-clean" feel

---

## What This Means For You

If a toothpaste appears here, you can swallow a small amount accidentally without panic. It will clean your teeth without destroying your oral microbiome or causing long-term hormonal stress.

---

## Our Promise

We don''t take "slotting fees" from dental conglomerates. We recommend only what is bio-available, safe, and effective.'
WHERE slug = 'toothpaste';

-- SOAP CRITERIA
UPDATE categories SET long_description = '## Soap Selection Criteria
### How we decide which soaps belong on this platform

India''s soap market is a mixed landscape: traditional cold-process bars, syndet bars, liquid cleansers, and many "herbal" products that hide their chemistry. Our job is to act as a strict filter — listing only soaps that are safe, transparent, and appropriate for Indian skin and environmental conditions.

If a soap appears here, it has passed a safety and performance gate that most mass-market products do not.

---

## 1. Non-Negotiable Exclusions (Fast Fail)

Before any soap is considered, the product must **pass an ingredient screen**. Any product containing any of the following is **automatically rejected**:

- **Sodium Lauryl Sulfate (SLS) / Sodium Laureth Sulfate (SLES)**
- **Parabens** (methyl/ethyl/propyl/butyl)
- **Formaldehyde releasers** (DMDM Hydantoin, Diazolidinyl Urea, Imidazolidinyl Urea, etc.)
- **Phthalates / Triclosan / microbeads / intentionally added endocrine disruptors**
- **Undisclosed "Base Q.S." or truncated INCI** (no hidden bases allowed)

**Why:** These ingredients are proven risk vectors (irritation, endocrine disruption, contamination). We will not list products that rely on these shortcuts.

---

## 2. Allowed Cleansing Systems (What We Accept)

Soaps must use cleansing systems that balance efficacy with skin barrier health and Indian water conditions:

- **Cold-process saponified bars** (allowed if TFM, pH guidance, and manufacturing documentation provided)
- **Syndets / soap-free surfactants:** SCI (Sodium Cocoyl Isethionate), Sodium Cocoyl Glycinate, Decyl Glucoside — preferred for facial and hard-water contexts
- **Glucosides / sarcosinates / validated botanical saponins** (Reetha, Sapindus) when documented
- **Functional botanical actives** (Neem, Kasturi turmeric, Tulsi, Goat milk, Shea, Kokum) accepted when present at meaningful concentrations and fully declared

**Why:** These families avoid the strip-and-mask cycle of harsh surfactants and perform better in Indian hard water.

---

## 3. Preservation & Shelf Rules (Practical Safety)

- **Anhydrous bars** (cold process) may not require strong preservatives but must publish manufacture date, batch, and shelf guidance
- **Water-containing formulations** must provide a preservative efficacy (challenge) test; parabens are not allowed
- **Short-shelf / fresh formats** must have explicit shelf-life instructions
- **Labeling must include** "best before / use within" and traceable batch number

**Why:** India''s distribution and climate require documented microbial safety for water-containing products.

---

## 4. Testing & Lab Checks (Must-Have Evidence)

### For Cold-Process Bars:
- TFM (Total Fatty Matter) or manufacturing spec
- pH (measured in 10% solution) and user guidance
- Heavy metal report (Pb, As, Hg limits)
- Microbial limit test if processing includes water

### For Syndets / Liquid Soaps:
- Preservative Efficacy Test (Challenge test)
- pH (target 5.5–6.5 where possible)
- Heavy metals certificate
- Hard-water lather / scum test if claiming "hard-water friendly"

---

## 5. Labeling & Transparency (Non-Negotiable)

- **Full INCI disclosure** on product page exactly as on packaging — no "Base Q.S."
- **Clarify origin/form** of botanicals (e.g., "Neem oil (Azadirachta indica) extract 2%")
- **Claims must be evidence-backed**
- **Usage instructions** and transition expectations
- **Shelf life and storage** and **batch number** must be shown

**Why:** Transparency is the strongest defense against greenwashing.

---

## 6. Certification Policy (What Counts)

- **High-trust:** ECOCERT / COSMOS / BDIH — meaningful for organic or natural claims
- **Contextual trust:** AYUSH + WHO-GMP for Ayurvedic therapeutic claims
- **Supportive:** ISO / GMP / cruelty-free seals help but are not sufficient alone
- **"Natural/herbal" labels** without INCI and test documentation are **not** sufficient

---

## 7. Scoring Blueprint (0–100)

- **Safety & Transparency** — 40%
- **Performance / Efficacy** — 25%
- **Formulation Quality** — 15%
- **Manufacturing & Certifications** — 10%
- **Sustainability & Packaging** — 10%

**Why:** Safety dominates for a health-first platform.

---

## Our Promise

We list only soaps that meet a rigorous safety and transparency standard: full INCI disclosure, no SLS/SLES, no parabens or formaldehyde-releasers, documented heavy-metal and microbial testing where applicable, and evidence of formulation suitability for Indian conditions.'
WHERE slug = 'soap';

-- HAIR OIL CRITERIA
UPDATE categories SET long_description = '## Hair Oil Selection Criteria
### How we decide which scalp and hair treatments deserve a place here

Most commercial hair oils in India are actually "Mineral Oil" disguised with 1% herbal extracts and heavy synthetic perfumes. Our role is to ensure your hair oil nourishes the follicle without clogging pores or disrupting your hormones.

---

## 1. Our Non-Negotiable Exclusions (The "Toxic-Five" Gate)

Any product containing these is **automatically disqualified**:

### ❌ Mineral Oil (Liquid Paraffin)
- A petroleum byproduct that creates a plastic-like film
- Clogs scalp pores (folliculitis) and provides zero nutritional value

**Our position:** We use only plant-derived lipids that the skin can actually metabolize.

### ❌ Synthetic Fragrance (Parfum)
- Usually contains Phthalates, which are known endocrine disruptors
- "Jasmine" or "Rose" scents in mass-market oils are almost always chemical mimics

**Our position:** Scent should be a byproduct of the ingredients or pure essential oils.

### ❌ Cyclopentasiloxane & Silicones
- Used to give "instant shine," but they coat the hair shaft
- Prevents moisture from entering, leading to long-term brittleness

**Our position:** True shine comes from a healthy cuticle, not a chemical coating.

### ❌ BHT (Butylated Hydroxytoluene)
- A synthetic antioxidant used to prevent rancidity
- Suspected carcinogen and skin irritant

**Our position:** Stability should come from Vitamin E (Tocopherol) or stable base oils.

### ❌ Artificial Colors
- Dyes like "Sunset Yellow" or "Tartrazine" added to make oils look "herbal"
- Serve no purpose and can cause scalp sensitivity

**Our position:** The color should reflect the natural herbs used.

---

## 2. Approved Actives (What We Look For)

We prioritize oils that penetrate the hair cortex and support the scalp''s microbiome.

### ✅ Cold-Pressed Base Oils
- Virgin Coconut (penetrates the shaft)
- Black Seed (Kalonji)
- Moroccan Argan
- Sesame (deeply warming/penetrating)

### ✅ Hair Growth Promoters
- **Bhringraj** – The "King of Hair"
- **Rosemary Essential Oil** – proven comparable to Minoxidil for blood circulation
- **Brahmi**

### ✅ Scalp Clarifiers
- Tea Tree or Neem for anti-fungal properties (dandruff control) without stripping natural oils

### ✅ Follicle Strengtheners
- **Amla** – Vitamin C powerhouse
- **Hibiscus** – mucilage for conditioning
- **Fenugreek (Methi)** – for protein

---

## 3. The "Extraction Method" Stance

How the oil is made is as important as the ingredients.

### Cold-Pressed/Kacchi Ghani
Mandatory for base oils. Heat-processed oils lose their vital fatty acids and antioxidants.

### Kshir Pak Vidhi
We highly value the traditional Ayurvedic method where herbs are decocted in milk and oil over a slow fire. This ensures the oil "absorbs" the fat-soluble nutrients of the herbs.

### Hexane-Free
We reject any oils extracted using chemical solvents.

---

## 4. Transparency & Purity

### 100% Disclosure
We reject brands that say "Oil Base Q.S." They must specify if the base is Sesame, Coconut, or Sunflower oil.

### Essential Oil Safety
We check that essential oils are within dermal safety limits (usually <2%) to prevent scalp burns or sensitization.

---

## 5. Scoring Logic

Every hair oil is scored (0–100) on:
- **Penetration Ability:** Ratio of small-molecule oils (like Coconut) to sealants
- **Scalp Health:** Absence of comedogenic (pore-clogging) synthetic fillers
- **Nutrient Density:** Concentration of active herbal extracts
- **Rancidity Protection:** Use of dark glass packaging to prevent UV oxidation

---

## What This Means For You

If a hair oil appears here, it won''t just sit on top of your hair making it greasy; it will actually feed the root. You won''t have to worry about "forehead acne" caused by oil runoff or long-term thinning caused by scalp inflammation.'
WHERE slug = 'hair_oil';

-- SUNSCREEN CRITERIA
UPDATE categories SET long_description = '## Sunscreen Selection Criteria
### How we decide which UV protection products deserve a place here

Sun protection is a medical necessity, not just a cosmetic one. However, many mass-market sunscreens use "chemical filters" that penetrate the bloodstream and have been detected in breast milk and urine. Our role is to filter out the hormone-disruptors and prioritize photostable, reef-safe, and skin-compatible formulas.

---

## 1. Our Non-Negotiable Exclusions (The "Endocrine-Gate")

Any product containing these is **automatically disqualified**:

### ❌ Oxybenzone (Benzophenone-3)
A known endocrine disruptor that mimics estrogen and is heavily linked to coral reef bleaching.

### ❌ Octinoxate
Highly unstable when exposed to sunlight (the very thing it''s meant to protect against) and another potent hormone disruptor.

### ❌ Homosalate
Found to accumulate in the body faster than it can be eliminated; linked to cellular toxicity.

### ❌ Benzene-Contaminated Aerosols
We avoid spray sunscreens unless they are certified benzene-free, as this carcinogen is a common contaminant in aerosol propellants.

### ❌ Synthetic Fragrance/Parfums
The #1 cause of contact dermatitis in sunscreens, especially when skin is heated by the sun.

---

## 2. Approved UV Filters (What We Look For)

We prioritize "Physical" (Mineral) filters and "New-Age" Photostable filters that sit on top of the skin or stay in the upper layers.

### ✅ Zinc Oxide (Non-Nano)
The gold standard. It provides true broad-spectrum protection (UVA + UVB) and is anti-inflammatory, making it safe for babies and sensitive skin.

### ✅ Titanium Dioxide
Excellent UVB protection; best when paired with Zinc Oxide.

### ✅ Tinosorb S & M
Modern, "organic" filters common in European and high-end Indian sunscreens. They are highly photostable, do not have the hormone-disrupting profiles of older chemicals, and don''t leave a heavy white cast.

### ✅ Iron Oxides
Crucial for those with melasma or hyperpigmentation, as they protect against Visible Blue Light (from screens and the sun), which mineral/chemical filters alone cannot block.

---

## 3. The "Protection Truth" Standards

We look past the "SPF" number to ensure actual protection:

- **Broad Spectrum:** Must protect against both UVB (burning) and UVA (aging/cancer)
- **PA Rating:** In India, we only recommend products with PA+++ or PA++++
- **Photostability:** The formula must not break down within 30 minutes of sun exposure
- **Water Resistance:** Mandatory for products marketed for sports or humidity

---

## 4. Skin Health & Transparency

### Non-Comedogenic
Sunscreens are notorious for clogging pores. We prioritize "Oil-free" or "Dry-touch" formulations that use safe silica or rice starch rather than heavy silicones.

### Antioxidant Support
We look for the addition of Vitamin C, Vitamin E, or Ferulic Acid, which help neutralize the free radicals that "leak" through even the best UV filters.

### Full INCI Disclosure
No "Base Q.S." or "Sunscreens Base." We demand to see every preservative and stabilizer used.

---

## 5. Scoring Logic (0–100)

Every sunscreen is scored based on:
- **Filter Safety:** Ratio of mineral/new-age filters vs. old-school chemicals
- **White Cast Index:** How well it blends into Indian skin tones without looking ashy
- **Ocular Safety:** Does it sting the eyes when you sweat?
- **Finish & Texture:** Is it wearable under makeup or in 90% humidity?

---

## What This Means For You

If a sunscreen appears here, it means you are protected from DNA damage without sacrificing your hormonal health. It won''t sting your eyes, it won''t cause "sun-acne," and it won''t harm the environment when you wash it off.

---

## Our Promise

We prioritize skin-type specificity. We recommend different formulas for someone with "Monsoon Oily" skin versus "Mountain Dry" skin, ensuring the sunscreen is a product you want to wear every day.'
WHERE slug = 'sunscreen';

-- ============================================================================
-- END OF COMPLETE SEED FILE
-- ============================================================================


