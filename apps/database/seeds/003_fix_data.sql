-- Fix: 003_fix_data.sql
-- Description: Fix product images and criteria content
-- Created: 2026-01-02

-- =====================
-- FIX PRODUCT IMAGES (use local paths served from frontend public folder)
-- =====================

UPDATE products SET image_url = '/images/products/forest_essentials_bhringraj_shikakai_hair_cleanser.jpg'
WHERE slug = 'forest-essentials-bhringraj-shikakai-hair-cleanser';

UPDATE products SET image_url = '/images/products/just_herbs_8_in_1_shampoo.jpg'
WHERE slug = 'just-herbs-amla-neem-shampoo';

UPDATE products SET image_url = '/images/products/soultree_licorice_bhringraj_shampoo.jpg'
WHERE slug = 'soultree-licorice-bhringraj-shampoo';

UPDATE products SET image_url = '/images/products/kama_ayurveda_bringadi_cleanser.jpg'
WHERE slug = 'kama-ayurveda-bringadi-cleanser';

UPDATE products SET image_url = '/images/products/vilvah_goat_milk_shampoo.jpg'
WHERE slug = 'vilvah-goat-milk-shampoo';

UPDATE products SET image_url = '/images/products/arata_super_shampoo.jpg'
WHERE slug = 'arata-super-shampoo';

UPDATE products SET image_url = '/images/products/tribe_concepts_hair_cleanser_powder.jpg'
WHERE slug = 'tribe-concepts-hair-cleanser-powder';

UPDATE products SET image_url = '/images/products/earth_rhythm_murumuru_shampoo_bar.jpg'
WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';

-- =====================
-- FIX CRITERIA CONTENT (clean markdown without special unicode issues)
-- =====================

UPDATE categories SET criteria_content = '## Shampoo Selection Criteria

### How we decide which shampoos deserve a place here

India''s shampoo market is crowded, confusing, and often misleading. Most products are designed to look effective in the short term - high foam, instant smoothness - while quietly compromising long-term scalp and hair health.

**Our role is simple: act as a strict filter.**

If a shampoo appears on this platform, it has cleared a bar that most mass-market products do not. Below is exactly how that bar is defined.

---

## 1. Our Non-Negotiable Exclusions (Pass/Fail Gate)

Before we evaluate benefits, performance, or price, a shampoo must first pass a safety audit. Any product containing any of the following is **automatically excluded**.

### Sulfates (SLS / SLES) - EXCLUDED

- Commonly used for strong foaming and low cost
- Scientifically known to disrupt the scalp''s natural lipid barrier
- Associated with dryness, irritation, rebound oiliness, and long-term scalp inflammation
- SLES additionally carries contamination risk with 1,4-dioxane, a probable carcinogen

**Our position:** A cleanser should clean without stripping. Sulfates fail that test.

### Formaldehyde Releasers - EXCLUDED

Examples: DMDM Hydantoin, Diazolidinyl Urea

- Release small amounts of formaldehyde over time
- Linked to contact dermatitis, allergic sensitization, and hair fall
- Still widely used in Indian mass brands due to low cost and shelf stability

**Our position:** No health-first product should expose the scalp to a known carcinogen - at any dose.

### Parabens - EXCLUDED

- Widely used preservatives
- Act as endocrine disruptors (xenoestrogens)
- Raise concerns around hormonal health with cumulative exposure

**Our position:** With safer preservation systems available, parabens are unnecessary.

### Hidden or Undisclosed "Base Q.S." - EXCLUDED

- Common in so-called "Ayurvedic" shampoos
- Allows brands to hide surfactants and preservatives behind vague labeling
- Prevents consumers from verifying safety claims

**Our position:** If ingredients are not fully disclosed, trust is impossible.

---

## 2. Cleansing Agents We Allow (And Why)

A shampoo must clean effectively, but gently. We approve only surfactants that meet three criteria:

1. Low irritation potential
2. Biodegradability
3. Compatibility with the scalp''s natural pH (~5.5)

### Approved Cleansing Systems

- Decyl Glucoside
- Sodium Cocoyl Glutamate
- Sodium Lauroyl Sarcosinate
- Sodium Cocoyl Isethionate (SCI)
- Reetha / Shikakai (traditional saponins)

These agents clean without triggering the damage-and-mask cycle created by sulfates and silicones.

---

## 3. Ingredient Philosophy: Ayurveda, But Verifiable

India has one of the richest hair-care traditions in the world. We value that - but only when it is used transparently and scientifically.

### Ayurvedic Ingredients We Actively Look For

- **Bhringraj** - supports hair growth cycles
- **Amla** - antioxidant protection, hair fall support
- **Shikakai** - natural cleanser with acidic pH
- **Reetha** - mild, hypoallergenic cleansing
- **Neem** - antifungal, dandruff control

### What We Do Not Accept

- Token herbs added for marketing
- "Herbal actives" layered on top of a harsh synthetic base
- Ayurvedic claims without full INCI disclosure

**Our position:** Ayurveda is powerful when done honestly - and misleading when used as a label.

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

Every approved shampoo receives a composite score (0-100) based on:

- Ingredient safety and transparency
- Cleansing gentleness
- Active ingredient relevance
- Regulatory and certification strength
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

- We do not accept payment to change criteria
- We do not lower standards for popular brands
- We review products the way we would for our own families'
WHERE slug = 'shampoo';
