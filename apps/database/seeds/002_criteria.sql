-- Update category criteria content

-- Update shampoo category with criteria content
UPDATE categories SET criteria_content = '## Shampoo Selection Criteria
### How we decide which shampoos deserve a place here

India''s shampoo market is crowded, confusing, and often misleading. Most products are designed to look effective in the short term—high foam, instant smoothness—while quietly compromising long-term scalp and hair health.

Our role is simple: **act as a strict filter.**

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

## Our Promise

- We do not accept payment to change criteria.
- We do not lower standards for popular brands.
- We review products the way we would for our own families.'
WHERE slug = 'shampoo';

-- Update toothpaste category with criteria content
UPDATE categories SET criteria_content = '## Toothpaste Selection Criteria
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
