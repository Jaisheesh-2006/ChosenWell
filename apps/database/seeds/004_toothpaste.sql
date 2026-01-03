-- Seed: 004_toothpaste.sql
-- Description: Import toothpaste category and products
-- Created: 2026-01-03

-- =====================
-- TOOTHPASTE CATEGORY
-- =====================

-- Update toothpaste category with criteria content (clean markdown)
UPDATE categories SET 
    long_description = 'Oral care is unique because of sublingual absorption - the tissues in your mouth absorb ingredients directly into your bloodstream. Most mass-market toothpastes in India prioritize cost and "freshness" over biocompatibility. Our role is to ensure that what goes in your mouth is as safe as what goes in your stomach.',
    criteria_content = '## Toothpaste Selection Criteria

### How we decide which oral care products deserve a place here

Oral care is unique because of sublingual absorption - the tissues in your mouth absorb ingredients directly into your bloodstream. Most mass-market toothpastes in India prioritize cost and "freshness" over biocompatibility.

**Our role is to ensure that what goes in your mouth is as safe as what goes in your stomach.**

---

## 1. Our Non-Negotiable Exclusions (The "Toxic-Five" Gate)

Any product containing these is **automatically disqualified**:

### Sodium Lauryl Sulfate (SLS) - EXCLUDED

- The primary cause of canker sores (mouth ulcers) and dry mouth
- Used only for foaming; provides zero cleaning benefit to teeth

**Our position:** A toothpaste does not need to be a soap.

### Triclosan - EXCLUDED

- An antibacterial pesticide linked to thyroid issues and antibiotic resistance
- Banned by the US FDA for hand soaps but still permitted in many Indian toothpastes

**Our position:** We do not allow endocrine disruptors in daily-use products.

### Saccharin and Aspartame - EXCLUDED

- Artificial sweeteners used to mask the bitter taste of chemicals
- Linked to gut microbiome disruption

**Our position:** Sweetness should come from Xylitol or Stevia, which actually help teeth.

### Microbeads (Plastic) - EXCLUDED

- Small plastic particles used for "scrubbing" that trap bacteria in gum pockets

**Our position:** Physical cleaning should come from safe clays or minerals.

### Parabens and Formaldehyde Donors - EXCLUDED

- Cheap preservatives used for long shelf life in humid Indian conditions

**Our position:** Safe, modern preservation is mandatory.

---

## 2. Approved Actives (What We Look For)

We prioritize ingredients that work with the mouth''s natural ecosystem rather than nuking it with chemicals.

### Nano-Hydroxyapatite (nHAp) - APPROVED

The gold standard for clean care. It is what your teeth are actually made of. It fills in microscopic cracks to reduce sensitivity and remineralize enamel naturally.

### Xylitol - APPROVED

A birch-derived sugar that oral bacteria cannot digest, effectively "starving" the bacteria that cause cavities.

### Bentonite/Kaolin Clay - APPROVED

Natural minerals that polish teeth gently and "adsorb" toxins without stripping enamel.

### Traditional Indian Botanicals - APPROVED

- **Neem** - antifungal
- **Miswak** - antibacterial
- **Clove** - analgesic
- **Babool** - astringent/gum tightening

---

## 3. The Fluoride Stance

Fluoride is a complex topic in India due to high naturally occurring fluoride in the groundwater of many states (Risk of Fluorosis).

- We prefer **Fluoride-free formulas** for general maintenance
- We only list Fluoride-containing pastes if they are transparent about dosage and use a "Clean Label" base, specifically for those with high cavity risk

---

## 4. Transparency and Origin

**Full Disclosure:** We reject brands that list "Paste Base Q.S." or "Herbal Base." Every ingredient, including the surfactant and preservative, must be named (INCI).

**Made in India:** We prioritize Indian brands that utilize local Ayurvedic wisdom combined with global manufacturing standards (GMP).

---

## 5. Scoring Logic

Every toothpaste is scored (0-100) on:

- **Enamel Safety:** Low Relative Dentin Abrasivity (RDA)
- **Gum Support:** Presence of anti-inflammatory herbs
- **Biocompatibility:** Absence of synthetic dyes and harsh detergents
- **Taste and Experience:** Stability and "after-clean" feel

---

## 6. What This Means For You

If a toothpaste appears here, you can swallow a small amount accidentally without panic. It will clean your teeth without destroying your oral microbiome or causing long-term hormonal stress.

---

## Our Promise

- We do not take "slotting fees" from dental conglomerates
- We recommend only what is bio-available, safe, and effective'
WHERE slug = 'toothpaste';

-- =====================
-- TOOTHPASTE PRODUCTS (8 products)
-- =====================

-- 1. Perfora Dream Relief Sensitive Toothpaste
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'perfora-dream-relief-sensitive-toothpaste',
    'Dream Relief (Sensitive Toothpaste)',
    'Perfora',
    'toothpaste',
    '/images/products/prefora_dream_white_toothpaste.webp',
    'active', true, true,
    88, 'v1', '2026-01-02',
    'daily_use', 'mid_range',
    'A modern, SLS-free formula using Nano-Hydroxyapatite for enamel repair.',
    ARRAY[
        'Contains Nano-Hydroxyapatite for natural remineralization',
        'Uses Xylitol to prevent cavities without toxic fluoride levels',
        'Very low abrasivity (RDA) score'
    ],
    ARRAY['Effective for sensitivity', 'Pleasant modern flavor'],
    ARRAY['Contains mild synthetic stabilizers'],
    'Nano-Hydroxyapatite, Xylitol, Aloe Vera, Vitamin C',
    ARRAY['Made Safe Certified'],
    ARRAY['SLS', 'Parabens', 'Saccharin', 'Triclosan']
);

-- 2. Salt Oral Care Dawn & Dusk Set
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'salt-oral-care-dawn-dusk-set',
    'Dawn & Dusk Toothpaste Set',
    'Salt Oral Care',
    'toothpaste',
    '/images/products/salt_oral_care_toothpaste_set.jpg',
    'active', true, false,
    86, 'v1', '2026-01-02',
    'daily_use', 'premium',
    'High-end lifestyle toothpaste using N-HAp and charcoal for specific day/night needs.',
    ARRAY[
        'Specific night formula with charcoal for deep detox',
        'Day formula with Saffron for brightening',
        'Uses high-grade Nano-Hydroxyapatite'
    ],
    ARRAY['Aesthetic packaging', 'Great texture and flavor'],
    ARRAY['High price point'],
    'Nano-Hydroxyapatite, Charcoal, Saffron, Aloe Vera',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'Fluoride', 'Parabens']
);

-- 3. Herbal Botanical Toothpaste
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'herbal-botanical-toothpaste',
    'Herbal Botanical Toothpaste',
    'Botanical',
    'toothpaste',
    '/images/products/herbal_botanical_toothpaste.webp',
    'active', false, true,
    83, 'v1', '2026-01-02',
    'daily_use', 'affordable',
    'A budget-friendly daily paste that successfully avoids the Toxic-Five gate.',
    ARRAY[
        'SLS and Fluoride-free maintenance',
        'Uses traditional Neem and Clove for germ protection',
        'Non-abrasive formula safe for long-term use'
    ],
    ARRAY['Highly affordable', 'Simple ingredient list'],
    ARRAY['Basic packaging', 'Limited brand recognition'],
    'Neem, Clove, Babool, Peppermint',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'Fluoride', 'Saccharin', 'Parabens']
);

-- 4. Bentodent Premium Mint Natural Toothpaste
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'bentodent-premium-mint-natural-toothpaste',
    'Natural Toothpaste (Premium Mint)',
    'Bentodent',
    'toothpaste',
    '/images/products/bentodent_natural_toothpaste.jpg',
    'active', false, true,
    84, 'v1', '2026-01-02',
    'daily_use', 'affordable',
    'Clay-based, glycerin-free toothpaste focused on natural remineralization and toxin removal.',
    ARRAY[
        'Glycerin-free to allow teeth to remineralize naturally',
        'Bentonite clay absorbs toxins without harsh abrasion',
        'Purely earth-based and chemical-free'
    ],
    ARRAY['Zero synthetic foam', 'Highly affordable'],
    ARRAY['Earthy texture may feel unusual'],
    'Bentonite Clay, Salt, Tea Tree Oil, Menthol',
    ARRAY[]::TEXT[],
    ARRAY['Glycerin', 'SLS', 'Fluoride', 'Saccharin']
);

-- 5. Vicco Vajradanti Ayurvedic Toothpaste
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'vicco-vajradanti-toothpaste-herbal',
    'Vajradanti Ayurvedic Toothpaste',
    'Vicco',
    'toothpaste',
    '/images/products/vicco_vajradanti_ayurvedic_toothpaste.jpg',
    'active', false, false,
    82, 'v1', '2026-01-02',
    'daily_use', 'affordable',
    'Legacy Indian herbal paste with 18 herbs proven for gum health and tooth tightening.',
    ARRAY[
        'Time-tested formula for tightening loose teeth',
        'Purely herbal with 18 traditional medicinal barks',
        'Effective at stopping gum bleeding'
    ],
    ARRAY['Effective for gum issues', 'Budget friendly'],
    ARRAY['Medicinal taste', 'Strong brown color'],
    'Babool, Bakul, Lavang, Dalchini, Manjishtha',
    ARRAY['AYUSH'],
    ARRAY['Animal products', 'Synthetic dyes', 'Sugar']
);

-- 6. Dente91 Cool Mint Toothpaste
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'dente91-cool-mint-toothpaste',
    'Cool Mint Toothpaste',
    'Dente91',
    'toothpaste',
    '/images/products/dente_91_enamel_pro.jpg',
    'active', false, true,
    85, 'v1', '2026-01-02',
    'daily_use', 'mid_range',
    'Science-led paste using Lactoferrin and nHAp for oral ecosystem balance.',
    ARRAY[
        'Contains Lactoferrin to kill bad bacteria naturally',
        'Uses nHAp for enamel remineralization',
        'Completely SLS and Paraben free'
    ],
    ARRAY['Advanced remineralization', 'Fights bad bacteria specifically'],
    ARRAY['Modern medicinal flavor'],
    'Nano-Hydroxyapatite, Lactoferrin, Xylitol',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'Fluoride', 'Parabens']
);

-- 7. Purexa Super Sensitive Toothpaste
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'purexa-super-sensitive-toothpaste',
    'Super Sensitive Toothpaste',
    'Purexa',
    'toothpaste',
    '/images/products/purexa_sensitive_toothpaste.jpg',
    'active', false, true,
    81, 'v1', '2026-01-02',
    'daily_use', 'affordable',
    'A clinical-yet-natural paste designed as a safe alternative for moving away from mass-market brands.',
    ARRAY[
        'Strictly follows the Toxic-Five gate',
        'Low abrasion formula safe for enamel',
        'Balanced botanical and scientific base for sensitivity'
    ],
    ARRAY['Excellent starting point for clean oral care', 'Gentle on gums'],
    ARRAY['Standard mint flavor (not unique)'],
    'Xylitol, Meswak, Clove oil',
    ARRAY[]::TEXT[],
    ARRAY['SLS', 'Fluoride', 'Parabens', 'Triclosan']
);

-- 8. Ayudant Herbal Toothpaste (Baidyanath)
INSERT INTO products (
    slug, name, brand, category_slug, image_url,
    status, editorial_pick, safe_starting_point,
    score, score_version, last_reviewed_at,
    usage_pattern, price_tier,
    short_reason, why_recommended, pros, cons,
    ingredient_summary, certifications, excluded_ingredients
) VALUES (
    'ayudant-herbal-toothpaste',
    'Ayudant Herbal Toothpaste',
    'Baidyanath',
    'toothpaste',
    '/images/products/ayudant_toothpaste.jpg',
    'active', false, false,
    78, 'v1', '2026-01-02',
    'daily_use', 'affordable',
    'Traditional germ protection relying on Neem and Clove with zero added sugar.',
    ARRAY[
        '100% herbal germ protection',
        'Relies on Neem and Clove for deep cleaning',
        'Completely sugar-free formula'
    ],
    ARRAY['Pure Ayurvedic lineage', 'No added sugar'],
    ARRAY['Lower availability'],
    'Neem, Pudina, Triphala, Babool, Clove',
    ARRAY['AYUSH'],
    ARRAY['Fluoride', 'Saccharin', 'Added Sugar', 'SLS']
);

-- =====================
-- ADD PRIMARY CONCERNS FOR TOOTHPASTE PRODUCTS
-- =====================

-- Perfora - sensitivity, enamel_repair
INSERT INTO product_concerns (product_slug, concern_slug) VALUES
    ('perfora-dream-relief-sensitive-toothpaste', 'sensitivity'),
    ('perfora-dream-relief-sensitive-toothpaste', 'enamel_repair');

-- Salt Oral Care - whitening, gum_health, bad_breath
INSERT INTO product_concerns (product_slug, concern_slug) VALUES
    ('salt-oral-care-dawn-dusk-set', 'whitening'),
    ('salt-oral-care-dawn-dusk-set', 'gum_health'),
    ('salt-oral-care-dawn-dusk-set', 'bad_breath');

-- Herbal Botanical - daily_maintenance, plaque_control
INSERT INTO product_concerns (product_slug, concern_slug) VALUES
    ('herbal-botanical-toothpaste', 'daily_maintenance'),
    ('herbal-botanical-toothpaste', 'plaque_control');

-- Bentodent - detoxification, bad_breath
INSERT INTO product_concerns (product_slug, concern_slug) VALUES
    ('bentodent-premium-mint-natural-toothpaste', 'detoxification'),
    ('bentodent-premium-mint-natural-toothpaste', 'bad_breath');

-- Vicco - gum_bleeding, pyorrhea, loose_teeth
INSERT INTO product_concerns (product_slug, concern_slug) VALUES
    ('vicco-vajradanti-toothpaste-herbal', 'gum_bleeding'),
    ('vicco-vajradanti-toothpaste-herbal', 'pyorrhea'),
    ('vicco-vajradanti-toothpaste-herbal', 'loose_teeth');

-- Dente91 - enamel_repair, sensitivity
INSERT INTO product_concerns (product_slug, concern_slug) VALUES
    ('dente91-cool-mint-toothpaste', 'enamel_repair'),
    ('dente91-cool-mint-toothpaste', 'sensitivity');

-- Purexa - daily_safety, enamel_protection, high_sensitivity
INSERT INTO product_concerns (product_slug, concern_slug) VALUES
    ('purexa-super-sensitive-toothpaste', 'daily_safety'),
    ('purexa-super-sensitive-toothpaste', 'enamel_protection'),
    ('purexa-super-sensitive-toothpaste', 'high_sensitivity');

-- Ayudant - germ_protection, cavities
INSERT INTO product_concerns (product_slug, concern_slug) VALUES
    ('ayudant-herbal-toothpaste', 'germ_protection'),
    ('ayudant-herbal-toothpaste', 'cavities');

-- =====================
-- ADD PHILOSOPHY TAGS FOR TOOTHPASTE PRODUCTS
-- =====================

-- Perfora - modern_science, clean_label
INSERT INTO product_philosophies (product_slug, philosophy_slug) VALUES
    ('perfora-dream-relief-sensitive-toothpaste', 'modern_clean'),
    ('perfora-dream-relief-sensitive-toothpaste', 'certified_organic');

-- Salt Oral Care - modern_science, lifestyle
INSERT INTO product_philosophies (product_slug, philosophy_slug) VALUES
    ('salt-oral-care-dawn-dusk-set', 'modern_clean');

-- Herbal Botanical - botanical, affordable_clean
INSERT INTO product_philosophies (product_slug, philosophy_slug) VALUES
    ('herbal-botanical-toothpaste', 'ayurvedic');

-- Bentodent - earth_based, glycerin_free
INSERT INTO product_philosophies (product_slug, philosophy_slug) VALUES
    ('bentodent-premium-mint-natural-toothpaste', 'zero_chemical');

-- Vicco - ayurvedic, legacy_brand
INSERT INTO product_philosophies (product_slug, philosophy_slug) VALUES
    ('vicco-vajradanti-toothpaste-herbal', 'ayurvedic');

-- Dente91 - modern_science, anti_bacterial
INSERT INTO product_philosophies (product_slug, philosophy_slug) VALUES
    ('dente91-cool-mint-toothpaste', 'modern_clean');

-- Purexa - dentist_recommended, clean_label
INSERT INTO product_philosophies (product_slug, philosophy_slug) VALUES
    ('purexa-super-sensitive-toothpaste', 'modern_clean');

-- Ayudant - ayurvedic, zero_sugar
INSERT INTO product_philosophies (product_slug, philosophy_slug) VALUES
    ('ayudant-herbal-toothpaste', 'ayurvedic');
