-- ============================================
-- COMPLETE SEED DATA FOR CHOSENWELL
-- Run AFTER 001_v1_schema.sql
-- ============================================

-- =====================
-- ADDITIONAL PRIMARY CONCERNS (beyond what's in schema)
-- =====================
INSERT INTO primary_concerns (code, label, description, display_order) VALUES
('sensitivity', 'Sensitivity', 'For sensitive teeth or gums', 6),
('whitening', 'Whitening', 'Natural teeth whitening', 7),
('cavity_protection', 'Cavity Protection', 'Prevents cavities naturally', 8),
('gum_health', 'Gum Health', 'Supports healthy gums', 9),
('dry_skin', 'Dry Skin', 'For dry or dehydrated skin', 10),
('oily_skin', 'Oily Skin', 'For oily or combination skin', 11),
('acne_prone', 'Acne Prone', 'Safe for acne-prone skin', 12),
('sun_protection', 'Sun Protection', 'UV protection', 13),
('hair_nourishment', 'Hair Nourishment', 'Deep nourishment for hair', 14),
('scalp_health', 'Scalp Health', 'Promotes healthy scalp', 15)
ON CONFLICT (code) DO NOTHING;

-- =====================
-- ADDITIONAL PHILOSOPHY TAGS (beyond what's in schema)
-- =====================
INSERT INTO philosophy_tags (code, label, description, display_order) VALUES
('vegan', 'Vegan', 'No animal-derived ingredients', 7),
('cruelty_free', 'Cruelty Free', 'Not tested on animals', 8),
('reef_safe', 'Reef Safe', 'Safe for marine ecosystems', 9),
('fragrance_free', 'Fragrance Free', 'No added fragrances', 10),
('dermat_tested', 'Dermatologist Tested', 'Tested by dermatologists', 11),
('eco_friendly', 'Eco-Friendly', 'Sustainable and eco-conscious', 12),
('cold_pressed', 'Cold Pressed', 'Cold-pressed extraction method', 13)
ON CONFLICT (code) DO NOTHING;

-- =====================
-- UPDATE EXISTING CATEGORIES + ADD NEW ONES
-- =====================

-- Update shampoo with criteria_content (criteria field is in schema, we need to add criteria_content column first)
-- Actually, looking at schema, there's no criteria_content column. Let's use long_description for criteria.

UPDATE categories SET 
    long_description = 'India''s shampoo market is crowded, confusing, and often misleading. Most products are designed to look effective in the short term—high foam, instant smoothness—while quietly compromising long-term scalp and hair health.

## How We Evaluate Shampoos

### Must Have (Non-Negotiable)
- Gentle, sulfate-free cleansing agents (approved surfactants only)
- Full INCI ingredient disclosure on packaging
- Scalp-compatible pH level (4.5-5.5)
- No hidden "Base Q.S." or vague ingredient labeling

### Good to Have
- Ayurvedic herbs like Bhringraj, Amla, Shikakai
- ECOCERT, COSMOS, or BDIH certification
- Biodegradable formula
- Sustainable packaging

### Automatic Disqualifiers
- SLS/SLES sulfates
- Parabens (any variant)
- Formaldehyde releasers
- Synthetic fragrances masking as "parfum"
- Silicones that build up (Dimethicone, Cyclomethicone)'
WHERE slug = 'shampoo';

UPDATE categories SET 
    long_description = 'We evaluate toothpaste based on cleaning efficacy, ingredient safety, and transparency. Most mainstream toothpastes contain ingredients we believe are unnecessary or potentially harmful.

## How We Evaluate Toothpaste

### Must Have (Non-Negotiable)
- Safe abrasive levels (RDA under 250)
- Full ingredient transparency
- Effective cleaning agents
- No triclosan or microbeads

### Good to Have
- Natural whitening agents (like hydroxyapatite)
- Sensitivity relief ingredients
- Fresh breath without artificial sweeteners
- Remineralizing ingredients

### Automatic Disqualifiers
- Triclosan
- Plastic microbeads
- Excessive SLS
- Artificial colors (especially for kids)
- Hidden ingredients'
WHERE slug = 'toothpaste';

-- Add new categories
INSERT INTO categories (slug, title, description, long_description, criteria, status) VALUES
('soap', 'Soap', 
 'Natural body soaps and cleansing bars analyzed for skin-friendly ingredients and pH balance.',
 'We analyze soaps for their cleansing effectiveness, skin compatibility, and ingredient transparency. Our evaluation focuses on pH balance, moisturizing properties, and absence of harsh synthetic detergents.

## How We Evaluate Soaps

### Must Have (Non-Negotiable)
- Skin-friendly pH (5.5-6.5)
- Gentle cleansing base
- Full ingredient disclosure
- No synthetic detergents (SLS/SLES)

### Good to Have
- Natural oils and butters (coconut, olive, shea)
- Essential oils for fragrance
- Handcrafted or cold-process method
- Glycerin retained (not removed)

### Automatic Disqualifiers
- Synthetic detergents as primary cleanser
- Artificial colors
- Harsh preservatives
- Triclosan or antibacterial chemicals',
 ARRAY['Skin-friendly pH', 'No synthetic detergents', 'Natural oils and butters', 'Full ingredient disclosure'],
 'active'),

('hair_oil', 'Hair Oil',
 'Premium hair oils evaluated for nourishment, scalp health, and natural ingredient quality.',
 'Hair oiling is a time-tested Indian tradition. We evaluate oils based on their absorption, nourishing properties, and authenticity of traditional formulations.

## How We Evaluate Hair Oils

### Must Have (Non-Negotiable)
- Pure, cold-pressed base oils
- Transparent ingredient sourcing
- No mineral oil fillers
- Full INCI disclosure

### Good to Have
- Traditional Ayurvedic herbs (Bhringraj, Brahmi, Amla)
- Organic certification
- Sustainable packaging
- Single-origin ingredients

### Automatic Disqualifiers
- Mineral oil as base or filler
- Synthetic fragrances
- Artificial colors
- Silicones',
 ARRAY['Cold-pressed oils', 'No mineral oil', 'Traditional herbs', 'Transparent sourcing'],
 'active'),

('sunscreen', 'Sunscreen',
 'Sun protection products analyzed for UVA/UVB coverage, reef safety, and skin compatibility.',
 'Sunscreen is essential for Indian skin, but many products contain ingredients that are harmful to both skin and environment. We evaluate for effective protection without compromise.

## How We Evaluate Sunscreens

### Must Have (Non-Negotiable)
- Broad spectrum UVA/UVB protection
- SPF accuracy (tested claims)
- Non-comedogenic formula
- Stable UV filters

### Good to Have
- Reef-safe ingredients (no oxybenzone/octinoxate)
- Water resistance
- Antioxidant benefits
- No white cast on Indian skin tones

### Automatic Disqualifiers
- Oxybenzone
- Octinoxate
- Uncoated nano particles
- Misleading SPF claims',
 ARRAY['Broad spectrum protection', 'Reef-safe ingredients', 'No white cast', 'SPF accuracy'],
 'active')
ON CONFLICT (slug) DO UPDATE SET
    description = EXCLUDED.description,
    long_description = EXCLUDED.long_description,
    criteria = EXCLUDED.criteria;

-- =====================
-- SHAMPOO PRODUCTS
-- =====================
INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications) VALUES

('soultree-licorice-bhringraj-shampoo', 'Licorice Hair Repair Shampoo with Bhringraj', 'SoulTree', 'shampoo', '/images/products/soultree_licorice_shampoo.jpg', 'active', true, true, 90, 'v1', '2026-01-01', 'alternate_day', 'premium', 'Excellent Ayurvedic formulation with proven herbs for hair repair and scalp health.', 
ARRAY['BDIH certified organic', 'Traditional Ayurvedic herbs', 'No sulfates or parabens'], 
ARRAY['Genuine Ayurvedic herbs', 'BDIH certified', 'No sulfates', 'Repairs damaged hair'], 
ARRAY['Premium pricing', 'Limited availability'], 
'Licorice, Bhringraj, Shikakai in gentle coconut-based surfactant', 
ARRAY['BDIH Certified']),

('kama-ayurveda-bringadi-cleanser', 'Bringadi Hair Cleanser', 'Kama Ayurveda', 'shampoo', '/images/products/kama_bringadi_cleanser.jpg', 'active', true, false, 88, 'v1', '2026-01-01', 'alternate_day', 'premium', 'Traditional Ayurvedic formula backed by heritage brand reputation.',
ARRAY['Authentic Ayurvedic recipe', 'Premium quality herbs', 'Trusted heritage brand'],
ARRAY['Authentic Ayurvedic recipe', 'No synthetic additives', 'Gentle cleansing'],
ARRAY['Expensive', 'Requires oil pre-treatment for best results'],
'Bringadi, Indigo, Balloon Vine in mild surfactant base',
ARRAY['Ayurvedic']),

('forest-essentials-bhringraj-shikakai', 'Hair Cleanser Bhringraj & Shikakai', 'Forest Essentials', 'shampoo', '/images/products/forest_essentials_bhringraj_shikakai_hair_cleanser.jpg', 'active', false, false, 88, 'v1', '2026-01-01', 'alternate_day', 'premium', 'Luxury Ayurvedic formulation with premium quality ingredients.',
ARRAY['Premium quality herbs', 'Luxury experience', 'Sulfate-free'],
ARRAY['Premium quality herbs', 'Sulfate-free', 'Pleasant natural fragrance'],
ARRAY['Very expensive', 'Small bottle size'],
'Bhringraj, Shikakai, Amla in coconut-derived cleansers',
ARRAY['Ayurvedic']),

('arata-super-shampoo', 'Super Shampoo (Onion + Argan)', 'Arata', 'shampoo', '/images/products/arata_zero_chemicals_shampoo.jpg', 'active', false, true, 84, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Clean label with effective plant-based ingredients at accessible price.',
ARRAY['Zero harsh chemicals', 'Plant-based formula', 'Affordable clean option'],
ARRAY['Zero chemicals', 'Plant-based', 'Affordable'],
ARRAY['May not lather much', 'Needs adjustment period'],
'Olive Oil, Onion Extract, Argan Oil, Maple',
ARRAY['Vegan', 'Cruelty-Free']),

('earth-rhythm-murumuru-shampoo-bar', 'Murumuru Butter Shampoo Bar', 'Earth Rhythm', 'shampoo', '/images/products/earth_rhythm_murumuru_shampoo_bar.jpg', 'active', false, false, 82, 'v1', '2026-01-01', 'alternate_day', 'mid_range', 'Sustainable solid format with effective cleansing and zero plastic.',
ARRAY['Plastic-free packaging', 'Travel-friendly format', 'Long-lasting bar'],
ARRAY['Plastic-free', 'Travel-friendly', 'Long-lasting'],
ARRAY['Learning curve for use', 'Needs proper storage'],
'Murumuru Butter, SCI (gentle surfactant), Essential oils',
ARRAY['Eco-Friendly', 'Vegan']),

('just-herbs-amla-neem-shampoo', '8-in-1 Root Nourishing Amla Neem Shampoo', 'Just Herbs', 'shampoo', '/images/products/just_herbs_shampoo.jpg', 'active', false, true, 82, 'v1', '2026-01-01', 'alternate_day', 'mid_range', 'Good Ayurvedic blend at accessible price point for regular use.',
ARRAY['8 Ayurvedic herbs', 'Affordable pricing', 'Widely available'],
ARRAY['8 Ayurvedic herbs', 'Affordable', 'Widely available'],
ARRAY['Contains some mild surfactants', 'Strong herbal smell'],
'Amla, Neem, Bhringraj, Brahmi and 4 other herbs',
ARRAY['Ayurvedic']),

('vilvah-goatmilk-shampoo', 'Goatmilk Shampoo', 'Vilvah', 'shampoo', '/images/products/vilvah_goat_milk_shampoo.jpg', 'active', false, false, 80, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Unique goat milk formula for ultra-gentle cleansing.',
ARRAY['Unique goat milk ingredient', 'Very gentle formula', 'Good for sensitive scalp'],
ARRAY['Unique ingredient', 'Very gentle', 'Good for sensitive scalp'],
ARRAY['Not vegan', 'Mild cleansing only'],
'Goat Milk, Aloe Vera, Coconut-derived surfactants',
ARRAY['Natural']),

('tribe-concepts-hair-cleanser', 'Hair Cleanser Powder', 'The Tribe Concepts', 'shampoo', '/images/products/the_tribe_concepts_hair_cleanser_powder.jpg', 'active', false, false, 78, 'v1', '2026-01-01', 'weekly_detox', 'affordable', 'Traditional powder format for chemical-free cleansing experience.',
ARRAY['100% natural powder', 'No preservatives needed', 'Very affordable'],
ARRAY['100% natural', 'No preservatives needed', 'Very affordable'],
ARRAY['Inconvenient to use', 'Requires preparation', 'Gritty texture'],
'Shikakai, Reetha, Amla powder blend',
ARRAY['Natural', 'Chemical-Free']);

-- =====================
-- TOOTHPASTE PRODUCTS
-- =====================
INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications) VALUES

('perfora-dream-white', 'Dream White Toothpaste', 'Perfora', 'toothpaste', '/images/products/prefora_dream_white_toothpaste.webp', 'active', true, true, 88, 'v1', '2026-01-01', 'daily_use', 'premium', 'Modern clean formula with effective whitening using hydroxyapatite.',
ARRAY['No SLS formula', 'Hydroxyapatite for enamel', 'Fresh natural taste'],
ARRAY['No SLS', 'Hydroxyapatite for enamel', 'Fresh taste'],
ARRAY['Premium price', 'Limited flavors'],
'Hydroxyapatite, Papain, Natural mint',
ARRAY['Cruelty-Free']),

('salt-oral-care-dawn-dusk', 'Dawn to Dusk Set', 'Salt Oral Care', 'toothpaste', '/images/products/salt_oral_care_toothpaste_set.jpg', 'active', false, false, 86, 'v1', '2026-01-01', 'daily_use', 'premium', 'Innovative day/night formula concept for complete oral care.',
ARRAY['AM/PM specific formulas', 'Natural ingredients', 'Premium design'],
ARRAY['AM/PM formulas', 'Natural ingredients', 'Good design'],
ARRAY['Expensive for two tubes', 'Niche brand availability'],
'Sea Salt, Natural Minerals, Essential oils',
ARRAY['Natural']),

('dente91-cool-mint', 'Cool Mint Toothpaste', 'Dente91', 'toothpaste', '/images/products/dente91_cool_mint_toothpaste.webp', 'active', true, false, 85, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Science-backed formula with innovative lactoferrin for gum health.',
ARRAY['Lactoferrin for gums', 'Nano hydroxyapatite', 'Fresh mint flavor'],
ARRAY['Lactoferrin for gums', 'No fluoride option', 'Fresh mint'],
ARRAY['May not suit everyone', 'Newer brand'],
'Nano Hydroxyapatite, Lactoferrin, Natural mint',
ARRAY['Clinically Tested']),

('bentodent-premium-mint', 'Premium Mint Toothpaste', 'Bentodent', 'toothpaste', '/images/products/bentodent_natural_toothpaste.jpg', 'active', false, true, 84, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Unique bentonite clay-based cleansing for natural detox.',
ARRAY['Bentonite clay detox', 'Natural formula', 'No fluoride'],
ARRAY['Bentonite clay detox', 'Natural', 'No fluoride'],
ARRAY['Unusual taste initially', 'Gray color may surprise'],
'Bentonite Clay, Mint, Natural binders',
ARRAY['Natural', 'Vegan']),

('herbal-botanical-toothpaste', 'Botanical Toothpaste', 'Herbal', 'toothpaste', '/images/products/herbal_botanical_toothpaste.webp', 'active', false, true, 83, 'v1', '2026-01-01', 'daily_use', 'affordable', 'Traditional herbal formula with proven Ayurvedic ingredients.',
ARRAY['Affordable pricing', 'Traditional herbs', 'Widely available'],
ARRAY['Affordable', 'Traditional herbs', 'Widely available'],
ARRAY['Strong herbal taste', 'Basic packaging'],
'Neem, Clove, Babool extracts',
ARRAY['Ayurvedic']),

('vicco-vajradanti', 'Vajradanti Toothpaste', 'Vicco', 'toothpaste', '/images/products/vicco_vajradanti_toothpaste.jpg', 'active', false, false, 82, 'v1', '2026-01-01', 'daily_use', 'affordable', 'Heritage Ayurvedic brand with 18 herbs and proven track record.',
ARRAY['18 herbs formula', 'Very affordable', 'Trusted heritage brand'],
ARRAY['18 herbs formula', 'Very affordable', 'Trusted brand'],
ARRAY['Old-fashioned taste', 'Basic formulation'],
'18 Ayurvedic Herbs including Vajradanti',
ARRAY['Ayurvedic']),

('purexa-sensitive', 'Sensitive Toothpaste', 'Purexa', 'toothpaste', '/images/products/purexa_herbal_sensitive_toothpaste.webp', 'active', false, false, 81, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Effective sensitivity relief with clean, gentle ingredients.',
ARRAY['Good for sensitivity', 'Gentle formula', 'No harsh chemicals'],
ARRAY['Good for sensitivity', 'Gentle formula', 'No harsh chemicals'],
ARRAY['Less widely available', 'Mild taste'],
'Potassium Nitrate, Aloe Vera, Gentle abrasives',
ARRAY['Natural']),

('ayudant-herbal', 'Herbal Toothpaste', 'Ayudant', 'toothpaste', '/images/products/ayudant_toothpaste.jpg', 'active', false, false, 78, 'v1', '2026-01-01', 'daily_use', 'affordable', 'Basic Ayurvedic formula at entry-level price point.',
ARRAY['Very affordable', 'Basic Ayurvedic herbs', 'Accessible option'],
ARRAY['Very affordable', 'Basic Ayurvedic herbs'],
ARRAY['Basic formula', 'Less refined taste'],
'Miswak, Neem, Clove extracts',
ARRAY['Ayurvedic']);

-- =====================
-- SOAP PRODUCTS
-- =====================
INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications) VALUES

('rustic-art-aloe-vera-soap', 'Aloe Vera Organic Soap', 'Rustic Art', 'soap', '/images/products/rustic_art_aloevera_soap.jpg', 'active', true, true, 88, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Excellent organic soap with superior moisturizing properties.',
ARRAY['Organic certified', 'Very moisturizing', 'Gentle cleansing'],
ARRAY['Organic certified', 'Very moisturizing', 'Gentle'],
ARRAY['Soft bar needs dry storage', 'Premium price'],
'Aloe Vera, Coconut Oil, Olive Oil',
ARRAY['Organic', 'Vegan']),

('kama-ayurveda-sugar-soap', 'Red Sandalwood Ayurvedic Soap', 'Kama Ayurveda', 'soap', '/images/products/kama_ayurveda_sugar_soap.jpg', 'active', false, false, 86, 'v1', '2026-01-01', 'daily_use', 'premium', 'Luxury Ayurvedic soap with premium sandalwood.',
ARRAY['Luxury experience', 'Natural fragrance', 'Skin brightening'],
ARRAY['Luxury experience', 'Natural fragrance', 'Skin brightening'],
ARRAY['Expensive', 'Small size'],
'Red Sandalwood, Cane Sugar, Natural oils',
ARRAY['Ayurvedic']),

('soulflower-charcoal-soap', 'Activated Charcoal Soap', 'Soulflower', 'soap', '/images/products/soulflower_charcoal_soap.webp', 'active', false, false, 84, 'v1', '2026-01-01', 'alternate_day', 'mid_range', 'Effective deep cleansing for oily and acne-prone skin.',
ARRAY['Deep cleansing', 'Good for acne', 'Detoxifying'],
ARRAY['Deep cleansing', 'Good for acne', 'Detoxifying'],
ARRAY['Can be drying', 'Not for daily use on dry skin'],
'Activated Charcoal, Tea Tree, Coconut Oil',
ARRAY['Natural', 'Vegan']),

('vilvah-goatmilk-soap', 'Classic Goat Milk Soap', 'Vilvah', 'soap', '/images/products/VilvahGoatMilk.webp', 'active', false, true, 82, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Gentle cleansing with unique goat milk formula.',
ARRAY['Very gentle', 'Moisturizing', 'Good for sensitive skin'],
ARRAY['Very gentle', 'Moisturizing', 'Good for babies'],
ARRAY['Not vegan', 'Mild cleansing'],
'Goat Milk, Shea Butter, Coconut Oil',
ARRAY['Natural']),

('kaprica-coconut-soap', '100% Coconut Oil Soap', 'Kaprica', 'soap', '/images/products/kaprica_100_coconut_soap.jpg', 'active', false, true, 80, 'v1', '2026-01-01', 'daily_use', 'affordable', 'Simple single-ingredient soap done right.',
ARRAY['Single ingredient', 'Very affordable', 'Good lather'],
ARRAY['Single ingredient', 'Very affordable', 'Good lather'],
ARRAY['Can be drying for some', 'Basic formula'],
'100% Virgin Coconut Oil',
ARRAY['Natural']);

-- =====================
-- HAIR OIL PRODUCTS
-- =====================
INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications) VALUES

('kama-bringadi-oil', 'Bringadi Intensive Hair Treatment Oil', 'Kama Ayurveda', 'hair_oil', '/images/products/kama_bringadi_oil.jpg', 'active', true, true, 92, 'v1', '2026-01-01', 'alternate_day', 'premium', 'Gold standard Ayurvedic hair oil with proven results.',
ARRAY['Authentic recipe', 'Proven efficacy', 'Premium quality herbs'],
ARRAY['Authentic recipe', 'Proven efficacy', 'Premium quality'],
ARRAY['Very expensive', 'Strong herbal smell'],
'Bhringraj, Indigo, Sesame Oil base',
ARRAY['Ayurvedic']),

('forest-essentials-bhringraj-oil', 'Bhringraj Hair Oil', 'Forest Essentials', 'hair_oil', '/images/products/forest_essentials_bhringraj_oil.jpg', 'active', true, false, 90, 'v1', '2026-01-01', 'alternate_day', 'premium', 'Luxury Ayurvedic oil with premium sourcing.',
ARRAY['Premium ingredients', 'Beautiful packaging', 'Effective formula'],
ARRAY['Premium ingredients', 'Beautiful packaging', 'Effective'],
ARRAY['Premium pricing', 'Heavy oil texture'],
'Bhringraj, Coconut Oil, Amla',
ARRAY['Ayurvedic']),

('juicy-chemistry-rosemary-oil', 'Rosemary Hair Oil', 'Juicy Chemistry', 'hair_oil', '/images/products/juicy_chemistry_rosemary_oil.jpg', 'active', false, true, 86, 'v1', '2026-01-01', 'alternate_day', 'mid_range', 'Modern clean formula with effective botanicals.',
ARRAY['Organic certified', 'Light texture', 'Pleasant fragrance'],
ARRAY['Organic certified', 'Light texture', 'Pleasant smell'],
ARRAY['Less traditional approach', 'Smaller quantity'],
'Rosemary, Jojoba Oil, Argan Oil',
ARRAY['Organic', 'Cruelty-Free']),

('soulflower-castor-oil', 'Cold Pressed Castor Oil', 'Soulflower', 'hair_oil', '/images/products/soulflower_castor_oil.jpg', 'active', false, false, 84, 'v1', '2026-01-01', 'weekly_detox', 'affordable', 'Simple single-ingredient oil for hair growth.',
ARRAY['Pure and simple', 'Affordable', 'Multi-use (hair, brows, lashes)'],
ARRAY['Pure and simple', 'Affordable', 'Multi-use'],
ARRAY['Very thick texture', 'Hard to wash out'],
'100% Cold-Pressed Castor Oil',
ARRAY['Natural', 'Cold-Pressed']),

('indulekha-bringha-oil', 'Bringha Hair Oil', 'Indulekha', 'hair_oil', '/images/products/indulekha_bringha_oil.jpg', 'active', false, true, 82, 'v1', '2026-01-01', 'alternate_day', 'mid_range', 'Popular Ayurvedic oil with innovative applicator.',
ARRAY['Unique selfie applicator', 'Good herb blend', 'Trusted brand'],
ARRAY['Unique applicator', 'Good herb blend', 'Trusted brand'],
ARRAY['Strong smell', 'Contains some additives'],
'Bringharaj, Virgin Coconut Oil, Amla',
ARRAY['Ayurvedic']),

('biotique-bhringraj-oil', 'Bhringraj Therapeutic Hair Oil', 'Biotique', 'hair_oil', '/images/products/biotique_bhringraj_oil.jpg', 'active', false, true, 80, 'v1', '2026-01-01', 'alternate_day', 'affordable', 'Accessible Ayurvedic oil at mass-market price.',
ARRAY['Very affordable', 'Widely available', 'Decent herb content'],
ARRAY['Very affordable', 'Widely available', 'Decent herbs'],
ARRAY['May contain some additives', 'Less potent than premium'],
'Bhringraj, Amla, Centella',
ARRAY['Ayurvedic']),

('parachute-advansed-coconut', 'Advanced Coconut Hair Oil', 'Parachute', 'hair_oil', '/images/products/parachute_advansed_oil.jpg', 'active', false, false, 75, 'v1', '2026-01-01', 'daily_use', 'affordable', 'Mass market option with basic nourishment.',
ARRAY['Very affordable', 'Available everywhere', 'Light texture'],
ARRAY['Very affordable', 'Everywhere available', 'Light texture'],
ARRAY['Mostly just coconut oil', 'Basic formula'],
'Coconut Oil, Vitamin E',
ARRAY['Natural']);

-- =====================
-- SUNSCREEN PRODUCTS
-- =====================
INSERT INTO products (slug, name, brand, category_slug, image_url, status, editorial_pick, safe_starting_point, score, score_version, last_reviewed_at, usage_pattern, price_tier, short_reason, why_recommended, pros, cons, ingredient_summary, certifications) VALUES

('minimalist-spf50-sunscreen', 'SPF 50 PA++++ Sunscreen', 'Minimalist', 'sunscreen', '/images/products/minimalist_spf50.jpg', 'active', true, true, 90, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Excellent modern formula with skincare benefits.',
ARRAY['High protection SPF 50', 'No white cast', 'Added skincare ingredients'],
ARRAY['High protection', 'No white cast', 'Added skincare'],
ARRAY['Can pill under makeup', 'Needs reapplication'],
'Zinc Oxide, Niacinamide, Hyaluronic Acid',
ARRAY['Dermatologist Tested']),

('reequil-ultra-matte-sunscreen', 'Ultra Matte Dry Touch Sunscreen', 'Re''equil', 'sunscreen', '/images/products/reequil_sunscreen.jpg', 'active', true, true, 88, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Best matte finish for oily Indian skin.',
ARRAY['True matte finish', 'No white cast', 'Long lasting protection'],
ARRAY['True matte finish', 'No white cast', 'Long lasting'],
ARRAY['Chemical filters only', 'Not water resistant'],
'Chemical UV filters, Silica, Mattifying agents',
ARRAY['Dermatologist Tested']),

('aqualogica-glow-sunscreen', 'Glow+ Dewy Sunscreen', 'Aqualogica', 'sunscreen', '/images/products/aqualogica_sunscreen.jpg', 'active', false, true, 85, 'v1', '2026-01-01', 'daily_use', 'affordable', 'Good budget option with hydrating dewy finish.',
ARRAY['Affordable pricing', 'Hydrating formula', 'Glow finish'],
ARRAY['Affordable', 'Hydrating', 'Glow finish'],
ARRAY['Not ideal for oily skin', 'Lower protection than premium'],
'Hyaluronic Acid, Papaya Extract, UV filters',
ARRAY['Vegan']),

('fixderma-shadow-spf50', 'Shadow SPF 50+ Sunscreen', 'Fixderma', 'sunscreen', '/images/products/fixderma_shadow_sunscreen.jpg', 'active', false, false, 86, 'v1', '2026-01-01', 'daily_use', 'mid_range', 'Dermatologist brand with hybrid filters.',
ARRAY['Physical + chemical filters', 'Good protection', 'Pharma quality'],
ARRAY['Physical + chemical', 'Good protection', 'Pharma quality'],
ARRAY['Slight white cast', 'Thick texture'],
'Zinc Oxide, Titanium Dioxide, Chemical filters',
ARRAY['Dermatologist Recommended']),

('lakme-sun-expert-spf50', 'Sun Expert SPF 50', 'Lakme', 'sunscreen', '/images/products/lakme_sunscreen.jpg', 'active', false, false, 82, 'v1', '2026-01-01', 'daily_use', 'affordable', 'Mass market option with decent protection.',
ARRAY['Very affordable', 'Easily available', 'Light texture'],
ARRAY['Very affordable', 'Easily available', 'Light texture'],
ARRAY['Basic formula', 'May irritate sensitive skin'],
'Chemical UV filters, Emollients',
ARRAY['Dermatologist Tested']),

('biotique-morning-nectar-sunscreen', 'Morning Nectar Sun Protect', 'Biotique', 'sunscreen', '/images/products/biotique_sunscreen.jpg', 'active', false, false, 78, 'v1', '2026-01-01', 'daily_use', 'affordable', 'Ayurvedic approach to sun protection.',
ARRAY['Affordable', 'Natural ingredients', 'Ayurvedic brand'],
ARRAY['Affordable', 'Natural ingredients'],
ARRAY['Lower SPF', 'Questionable UV filter efficacy'],
'Sunflower Oil, Wheatgerm, Natural extracts',
ARRAY['Ayurvedic']);

-- =====================
-- PRODUCT PRIMARY CONCERNS (join table)
-- =====================

-- Shampoos
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'soultree-licorice-bhringraj-shampoo' AND c.code IN ('hair_fall_support', 'dry_frizzy');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'kama-ayurveda-bringadi-cleanser' AND c.code IN ('hair_fall_support', 'scalp_health');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'forest-essentials-bhringraj-shikakai' AND c.code IN ('dry_frizzy', 'hair_fall_support');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'arata-super-shampoo' AND c.code IN ('hair_fall_support', 'oily_scalp');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'earth-rhythm-murumuru-shampoo-bar' AND c.code IN ('dry_frizzy', 'sensitive_scalp');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'just-herbs-amla-neem-shampoo' AND c.code IN ('oily_scalp', 'dandruff_safe');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'vilvah-goatmilk-shampoo' AND c.code IN ('sensitive_scalp', 'dry_frizzy');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'tribe-concepts-hair-cleanser' AND c.code IN ('oily_scalp', 'scalp_health');

-- Toothpastes
INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'perfora-dream-white' AND c.code IN ('whitening', 'sensitivity');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'salt-oral-care-dawn-dusk' AND c.code IN ('gum_health', 'cavity_protection');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'dente91-cool-mint' AND c.code IN ('gum_health', 'sensitivity');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'bentodent-premium-mint' AND c.code IN ('cavity_protection', 'gum_health');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'herbal-botanical-toothpaste' AND c.code IN ('gum_health', 'cavity_protection');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'vicco-vajradanti' AND c.code IN ('gum_health', 'cavity_protection');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'purexa-sensitive' AND c.code IN ('sensitivity', 'gum_health');

INSERT INTO product_primary_concerns (product_id, concern_code)
SELECT p.id, c.code FROM products p, primary_concerns c 
WHERE p.slug = 'ayudant-herbal' AND c.code IN ('gum_health', 'cavity_protection');

-- =====================
-- PRODUCT PHILOSOPHY TAGS (join table)
-- =====================

-- Shampoos
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'soultree-licorice-bhringraj-shampoo' AND c.code IN ('ayurvedic', 'certified_organic');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'kama-ayurveda-bringadi-cleanser' AND c.code IN ('ayurvedic', 'premium_clean');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'forest-essentials-bhringraj-shikakai' AND c.code IN ('ayurvedic', 'premium_clean');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'arata-super-shampoo' AND c.code IN ('modern_clean', 'vegan', 'cruelty_free');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'earth-rhythm-murumuru-shampoo-bar' AND c.code IN ('solid_bar', 'eco_friendly', 'vegan');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'just-herbs-amla-neem-shampoo' AND c.code IN ('ayurvedic', 'modern_clean');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'vilvah-goatmilk-shampoo' AND c.code IN ('modern_clean');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'tribe-concepts-hair-cleanser' AND c.code IN ('zero_chemical', 'ayurvedic');

-- Toothpastes  
INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'perfora-dream-white' AND c.code IN ('modern_clean', 'cruelty_free');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'salt-oral-care-dawn-dusk' AND c.code IN ('modern_clean', 'premium_clean');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'dente91-cool-mint' AND c.code IN ('modern_clean', 'dermat_tested');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'bentodent-premium-mint' AND c.code IN ('modern_clean', 'vegan');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'herbal-botanical-toothpaste' AND c.code IN ('ayurvedic');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'vicco-vajradanti' AND c.code IN ('ayurvedic');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'purexa-sensitive' AND c.code IN ('modern_clean');

INSERT INTO product_philosophy_tags (product_id, philosophy_code)
SELECT p.id, c.code FROM products p, philosophy_tags c 
WHERE p.slug = 'ayudant-herbal' AND c.code IN ('ayurvedic');

-- =====================
-- PRODUCT BUY LINKS
-- =====================

-- Insert buy links for all products
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', CONCAT('https://www.amazon.in/s?k=', REPLACE(name, ' ', '+')), 'affiliate', 1 
FROM products;

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Flipkart', CONCAT('https://www.flipkart.com/search?q=', REPLACE(name, ' ', '+')), 'affiliate', 2 
FROM products;

-- =====================
-- VERIFICATION QUERIES
-- =====================
SELECT 'Categories' as table_name, COUNT(*) as count FROM categories
UNION ALL SELECT 'Products', COUNT(*) FROM products
UNION ALL SELECT 'Primary Concerns', COUNT(*) FROM primary_concerns
UNION ALL SELECT 'Philosophy Tags', COUNT(*) FROM philosophy_tags
UNION ALL SELECT 'Product Concerns', COUNT(*) FROM product_primary_concerns
UNION ALL SELECT 'Product Philosophies', COUNT(*) FROM product_philosophy_tags
UNION ALL SELECT 'Buy Links', COUNT(*) FROM product_buy_links
UNION ALL SELECT 'Methodologies', COUNT(*) FROM methodologies;

SELECT category_slug, COUNT(*) as product_count 
FROM products 
GROUP BY category_slug 
ORDER BY product_count DESC;