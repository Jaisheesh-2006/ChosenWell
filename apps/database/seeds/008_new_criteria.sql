-- Criteria content for new categories: Soap, Hair Oil, Sunscreen

-- =====================
-- SOAP CRITERIA
-- =====================
UPDATE categories SET criteria_content = '## Soap Selection Criteria
### How we decide which soaps deserve a place here

India has one of the oldest soap traditions in the world, from Reetha and Shikakai to cold-processed Ayurvedic bars. But the modern market is filled with industrial detergent bars marketed as "natural" or "herbal."

Our role is simple: **separate real, skin-friendly soaps from synthetic detergent bars (syndets) disguised as gentle products.**

---

## 1. Our Non-Negotiable Exclusions (Pass/Fail Gate)

Before we evaluate moisturizing benefits or fragrance, a soap must first pass a safety audit. Any product containing any of the following is **automatically excluded**.

### ❌ SLS / SLES (Sodium Lauryl/Laureth Sulfate)
- Harsh synthetic surfactants used for cheap foaming
- Strip the skin of natural oils and disrupt the lipid barrier
- Can cause long-term dryness and irritation

**Our position:** These belong in industrial cleaners, not on human skin.

### ❌ Parabens
- Widely used preservatives that act as xenoestrogens
- Linked to hormonal disruption with cumulative exposure

**Our position:** Modern preservation systems make parabens unnecessary.

### ❌ Formaldehyde Releasers
(e.g. DMDM Hydantoin, Imidazolidinyl Urea)
- Release formaldehyde slowly over time
- Known skin sensitizers and potential carcinogens

**Our position:** No amount of carcinogen exposure is acceptable.

### ❌ Synthetic Dyes (D&C, FD&C Colors)
- Added purely for visual appeal; no functional benefit
- Many are derived from coal tar and linked to sensitivity

**Our position:** Skin care products should not contain cosmetic dyes.

### ❌ Hidden "Base Q.S."
- Common in Ayurvedic soaps to hide cheap synthetic surfactants
- Prevents verification of safety claims

**Our position:** Full ingredient transparency is mandatory.

---

## 2. Soap Types We Approve

### ✅ Cold-Processed Soaps
- Made by saponifying oils at low temperature
- Preserves natural glycerin (a powerful humectant)
- Super-fatted formulations leave skin moisturized
- Naturally high TFM (Total Fatty Matter)

### ✅ High-TFM Vegetable Oil Soaps
- TFM above 70% indicates quality
- Made from plant-based oils (coconut, olive, palm kernel)
- Gentle cleansing without stripping

### ✅ Traditional Saponin Cleansers
- Reetha (Soapnut)
- Shikakai
- Natural surfactants with a long safety history

---

## 3. Ingredient Philosophy: Clean But Effective

We look for soaps that combine effective cleansing with skin barrier support:

### Key Ingredients We Value
- **Coconut Oil** - antimicrobial, great lather
- **Olive Oil** - deeply moisturizing
- **Castor Oil** - conditioning, stable lather
- **Shea Butter** - barrier repair
- **Neem** - antifungal, antimicrobial
- **Turmeric** - anti-inflammatory
- **Activated Charcoal** - oil adsorption for oily skin
- **Goat Milk** - lactic acid for gentle exfoliation

### What We Do Not Accept
- Petroleum-based moisturizers (mineral oil, petrolatum)
- Triclosan or other antibacterial agents
- Synthetic fragrance (parfum)
- Marketing claims without INCI disclosure

---

## 4. Understanding pH and Skin Compatibility

True soaps are naturally alkaline (pH 9-10), while skin is slightly acidic (pH 4.5-5.5).

### Our Position
- Alkaline soaps are acceptable for healthy skin with proper post-wash care
- Users with very sensitive or compromised skin may prefer syndet bars (pH-balanced)
- We clearly indicate which products are true soaps vs. syndets

---

## 5. Certifications We Value

- **EcoCert COSMOS** - rigorous organic certification
- **BDIH Certified Natural** - German standard for natural cosmetics
- **USDA Organic** - for food-grade ingredients
- **Cruelty-Free certifications** - no animal testing

BIS certification alone is insufficient as it still permits harmful ingredients.

---

## 6. How We Score Soaps

Every approved soap receives a score (0-100) based on:
- Ingredient safety and transparency
- TFM quality and oil composition
- Skin compatibility and moisturizing potential
- Manufacturing method (cold-process preferred)
- Certification strength
- Value for money in its segment

---

## Our Promise

- We do not accept payment to change criteria.
- We do not lower standards for popular brands.
- We review soaps as we would for our own families.'
WHERE slug = 'soap';


-- =====================
-- HAIR OIL CRITERIA
-- =====================
UPDATE categories SET criteria_content = '## Hair Oil Selection Criteria
### How we decide which hair oils deserve a place here

India''s hair oil tradition is perhaps the richest in the world - from grandmother''s coconut oil to complex Ayurvedic formulations. But modern commercial oils are often mineral oil with "herbal extracts" sprayed on for marketing.

Our role is to **identify authentic, beneficial hair oils and filter out petroleum-based imposters.**

---

## 1. Our Non-Negotiable Exclusions (Pass/Fail Gate)

Any hair oil containing these is **automatically excluded**:

### ❌ Mineral Oil (Liquid Paraffin/Paraffinum Liquidum)
- A petroleum byproduct that coats hair without penetration
- Creates an illusion of shine while blocking actual nourishment
- Cannot carry nutrients into the hair shaft
- Over time, leads to brittle, dependent hair

**Our position:** Hair oils should nourish, not coat. Mineral oil fails this test.

### ❌ Silicones (Dimethicone, Cyclomethicone, etc.)
- Synthetic polymers that create artificial smoothness
- Build up over time, preventing moisture absorption
- Require harsh sulfate shampoos to remove

**Our position:** Silicones create a dependency cycle. Natural oils do not.

### ❌ Synthetic Fragrance (Parfum)
- Hidden cocktail of potentially hundreds of chemicals
- Common cause of scalp irritation and allergic reactions
- No disclosure of individual components

**Our position:** Fragrance should come from natural essential oils only.

### ❌ BHT/BHA (Synthetic Antioxidants)
- Cheap preservatives linked to hormonal disruption
- Used to extend shelf life of low-quality oils

**Our position:** Fresh, quality oils use natural vitamin E or are packaged to prevent oxidation.

### ❌ Artificial Colors
- Added for visual appeal; zero hair benefit
- Potential sensitizers

**Our position:** Hair oil should look like... oil.

---

## 2. Base Oils We Approve

The foundation of any quality hair oil is its base. We prioritize:

### ✅ Coconut Oil (Cold-Pressed/Virgin)
- Only oil scientifically proven to penetrate the hair shaft
- Rich in lauric acid for antimicrobial protection
- Ideal for Indian hair types

### ✅ Sesame Oil (Til/Gingelly)
- Traditional Ayurvedic base
- Excellent carrier for herb infusions
- Natural sunscreen properties (SPF 4-6)

### ✅ Castor Oil
- High ricinoleic acid content
- Promotes scalp circulation
- Excellent for thinning hair

### ✅ Other Quality Bases
- Argan Oil, Jojoba Oil, Sweet Almond Oil
- Avocado Oil (high penetration)
- Moringa Oil, Hemp Seed Oil

---

## 3. Traditional Extraction Methods We Value

### Kshir Pak Vidhi (Milk Decoction)
- Herbs boiled in milk, then added to oil
- Milk proteins help extract fat-soluble actives
- Gold standard for premium Ayurvedic oils

### Taila Pak (Direct Oil Infusion)
- Herbs heated in oil over multiple cycles
- Traditional method for medicated oils

### Cold-Pressed Extraction
- Mechanical extraction without heat or chemicals
- Preserves maximum nutritional value

---

## 4. Ayurvedic Actives We Look For

### For Hair Growth & Strength
- **Bhringraj** (False Daisy) - the "King of Hair"
- **Amla** - vitamin C and antioxidants
- **Brahmi** - scalp soothing
- **Neem** - antifungal, dandruff control

### For Premature Greying
- **Indigo** - natural pigment support
- **Curry Leaves** - melanin protection
- **Black Sesame** - traditional anti-greying

### For Conditioning
- **Hibiscus** - natural conditioning
- **Coconut Milk** - protein and moisture
- **Fenugreek** - lecithin-rich

---

## 5. Transparency Requirements

### Full INCI Disclosure
Every ingredient must be listed. We reject "Proprietary Blend" or "Base Q.S." labeling.

### Manufacturing Standards
- GMP certification preferred
- Batch numbers and manufacturing dates visible
- Clear shelf-life guidance

### Packaging
- Dark glass or UV-protective containers preferred
- Prevents oxidation and maintains potency

---

## 6. How We Score Hair Oils

Every approved oil receives a score (0-100) based on:
- Base oil quality (no mineral oil)
- Herb potency and extraction method
- Ingredient transparency
- Packaging and stability
- Certifications (Ayurvedic, Organic, etc.)
- Value for intended use case

---

## Our Promise

- We do not accept payment to feature products.
- We personally test or verify each recommendation.
- We recommend only what we would use on our own families.'
WHERE slug = 'hair_oil';


-- =====================
-- SUNSCREEN CRITERIA
-- =====================
UPDATE categories SET criteria_content = '## Sunscreen Selection Criteria
### How we decide which sunscreens deserve a place here

India receives intense UV radiation year-round, yet most sunscreens sold here contain filters that are either unsafe for long-term use or unsuitable for our humid climate and diverse skin tones.

Our role is to **identify sunscreens that protect without compromising health.**

---

## 1. Our Non-Negotiable Exclusions (Pass/Fail Gate)

Any sunscreen containing these is **automatically excluded**:

### ❌ Oxybenzone (Benzophenone-3)
- Penetrates skin and enters bloodstream within hours
- Detected in breast milk, urine, and blood
- Proven endocrine disruptor affecting estrogen and testosterone
- Banned in Hawaii and Palau for coral reef damage

**Our position:** No level of hormonal disruption is acceptable for daily use.

### ❌ Octinoxate (Ethylhexyl Methoxycinnamate/OMC)
- Another hormone-disrupting UV filter
- Degrades rapidly in sunlight, becoming less effective
- Banned in multiple countries for reef damage

**Our position:** Unstable filters that harm health and environment are not acceptable.

### ❌ Homosalate
- Accumulates in the body faster than it can be eliminated
- Disrupts estrogen, androgen, and progesterone
- Penetrates skin rapidly

**Our position:** Daily-use products should not bioaccumulate.

### ❌ Octocrylene
- Degrades into benzophenone, a known carcinogen
- Increasingly found in contaminated sunscreen products
- High allergy potential

**Our position:** Products should not become more toxic over time.

### ❌ Synthetic Fragrance
- Increases photosensitivity (defeats the purpose)
- Common cause of allergic reactions
- Unnecessary in sun protection

**Our position:** Sunscreens should protect, not irritate.

---

## 2. UV Filters We Approve

### ✅ Mineral/Physical Filters (Gold Standard)

**Zinc Oxide**
- Broad-spectrum protection (UVA + UVB + visible light)
- Sits on skin surface - does not penetrate
- Anti-inflammatory properties
- Reef-safe and biocompatible
- Non-nano preferred for maximum safety

**Titanium Dioxide**
- Excellent UVB protection
- Works well in combination with Zinc Oxide
- Non-nano preferred

### ✅ Next-Generation Organic Filters (Clean Chemical)

These newer filters do not penetrate skin significantly and remain photostable:

**Tinosorb S (Bemotrizinol)**
- Photostable, broad-spectrum
- Does not penetrate skin
- Not an endocrine disruptor

**Tinosorb M (Bisoctrizole)**
- Hybrid organic-inorganic filter
- Excellent UVA protection
- Encapsulated, minimal penetration

**Uvinul A Plus (Diethylamino Hydroxybenzoyl Hexyl Benzoate)**
- Superior UVA protection
- Photostable
- Minimal skin penetration

---

## 3. Important Considerations for Indian Skin

### White Cast
- Mineral sunscreens can leave white residue on darker skin tones
- We prioritize tinted formulas or micronized minerals that minimize cast
- Transparency about white cast in our reviews

### Humidity Performance
- Indian humidity demands sweat-resistant formulas
- We test for performance in high-moisture conditions
- Water resistance ratings are important

### Blue Light Protection
- Visible light (especially blue light) causes pigmentation in Indian skin
- Iron oxides in tinted sunscreens provide this protection
- Especially important for melasma-prone individuals

---

## 4. SPF and PA Ratings

### SPF (Sun Protection Factor)
- Measures UVB protection only
- SPF 30 blocks 97% of UVB; SPF 50 blocks 98%
- Higher SPF has diminishing returns

### PA Rating (Protection Grade of UVA)
- PA+ to PA++++ indicates UVA protection level
- We require minimum PA+++ for recommendation

### Our Position
- SPF 30-50 with PA++++ is the sweet spot
- Proper application (2mg/cm2) matters more than ultra-high SPF
- Reapplication every 2-3 hours is essential

---

## 5. Additional Safety Markers

### Fragrance-Free
- Mandatory for our recommendations
- Reduces photosensitivity risk

### Non-Comedogenic Testing
- Important for acne-prone Indian skin
- Clinical testing preferred

### Dermatologist/Pediatrician Approval
- Additional trust signal
- Especially important for sensitive and children''s products

---

## 6. How We Score Sunscreens

Every approved sunscreen receives a score (0-100) based on:
- Filter safety (mineral or clean chemical)
- Broad-spectrum protection (UVA + UVB)
- Cosmetic elegance (white cast, texture)
- Performance in humidity
- Ingredient transparency
- Testing and certifications
- Value for daily use

---

## Our Promise

- We do not accept payment to recommend products.
- We personally verify protection claims.
- We prioritize Indian skin concerns and climate.
- We recommend only what is safe for daily, long-term use.'
WHERE slug = 'sunscreen';
