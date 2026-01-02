# Editorial-First PostgreSQL Schema for Curated Product Platform

## Design Philosophy

This schema prioritizes **editorial control** and **data discipline** over flexibility. It's designed for a content-first platform where:

- Products are **read-only curated content** (no user submissions)
- **ENUMs enforce consistency** across structured filters
- **JSONB is minimal** - used only where intentional flexibility is required
- **Strong constraints** prevent data chaos and enable trust signals

---

## ENUM Definitions (Data Discipline)

### 1. **product_status** - Workflow Control

```sql
CREATE TYPE product_status AS ENUM ('draft', 'active', 'archived', 'under_review');
```

**Purpose**: Editorial workflow control - prevents accidental publishing

- `draft`: In preparation, not visible in API
- `active`: Published and visible to users
- `archived`: Removed from catalog but retained for history
- `under_review`: Pending editorial review

---

### 2. **primary_concern** - Fixed Concern Tags

```sql
CREATE TYPE primary_concern AS ENUM (
    'dandruff_safe',
    'hair_fall_support',
    'dry_frizzy',
    'oily_scalp',
    'sensitive_scalp',
    'sensitivity_relief',
    'cavity_prevention',
    'whitening',
    'stain_removal',
    'kids_safe'
);
```

**Purpose**: NO free-form tags - exact product concern classification

- **Why it matters**: Prevents tag pollution (no "hair_fall", "hairfall", "fall_hair" chaos)
- **Array field**: `primary_concerns primary_concern[]` - products can address 1-3 concerns
- **Filtering**: GIN index enables fast multi-concern filtering

---

### 3. **philosophy_tag** - Ingredient Philosophy

```sql
CREATE TYPE philosophy_tag AS ENUM (
    'ayurvedic',
    'certified_organic',
    'modern_clean',
    'zero_chemical',
    'solid_bar',
    'premium_clean'
);
```

**Purpose**: Brand positioning and ingredient philosophy (mutually aware, not exclusive)

- Multiple philosophy tags per product (e.g., "ayurvedic" + "modern_clean")
- Enables cross-cutting filters: "show me ayurvedic products that are also modern clean"

---

### 4. **usage_pattern_enum** - Usage Frequency

```sql
CREATE TYPE usage_pattern_enum AS ENUM (
    'daily_use',
    'alternate_day',
    'weekly_detox'
);
```

**Purpose**: Single enum value (NOT array) - exactly one usage pattern per product

- Stored as: `usage_pattern usage_pattern_enum NOT NULL`
- Constraint: `NOT NULL` ensures every product has exactly one usage pattern

---

### 5. **price_tier** - Budget Classification

```sql
CREATE TYPE price_tier AS ENUM (
    'premium',
    'mid_range',
    'affordable'
);
```

**Purpose**: Fixed budget classification (NO free-form pricing logic)

- Stored as: `price_tier price_tier NOT NULL`
- Prevents ambiguity: Is ₹500 "premium" or "mid_range"? Editorial decision, enforced.

---

### 6. **certification_name** - Verified Certifications

```sql
CREATE TYPE certification_name AS ENUM (
    'BDIH', 'AYUSH', 'ECOCERT', 'COSMOS', 'EWG_Verified',
    'Leaping_Bunny', 'Vegan_Certified', 'Made_Safe', ...
);
```

**Purpose**: Only recognized certifications stored - prevents typos and fake certs

- Separate `product_certifications` table with `UNIQUE(product_id, certification)` constraint
- Each cert is verified with `verified_at` date

---

### 7. **score_version** - Methodology Tracking

```sql
CREATE TYPE score_version AS ENUM ('v1', 'v2', 'v3');
```

**Purpose**: Track which methodology version was used to score each product

- If methodology changes, all products get new scores tagged `v2`
- Old `v1` products still visible, but users see "scored with v1 methodology"
- Enables gradual transitions without breaking data

---

## Core Tables

### **products** - Editorial Content Hub

```sql
CREATE TABLE products (
    -- Identity
    id UUID PRIMARY KEY,
    slug VARCHAR(100) UNIQUE NOT NULL,
    category_slug VARCHAR(100) NOT NULL,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(255) NOT NULL,

    -- Editorial Control
    status product_status NOT NULL DEFAULT 'draft',
    editorial_pick BOOLEAN NOT NULL DEFAULT false,
    safe_starting_point BOOLEAN NOT NULL DEFAULT false,
    edit_log JSONB DEFAULT '[]'::jsonb,

    -- Scoring
    score DECIMAL(5,2) NOT NULL CHECK (score >= 0 AND score <= 100),
    score_version score_version NOT NULL DEFAULT 'v1',
    last_reviewed_at DATE NOT NULL,

    -- Structured Filtering (No free-form)
    primary_concerns primary_concern[] NOT NULL,
    philosophy_tags philosophy_tag[] NOT NULL,
    usage_pattern usage_pattern_enum NOT NULL,
    price_tier price_tier NOT NULL,

    -- Editorial Content
    short_reason VARCHAR(255) NOT NULL,
    why_recommended TEXT[] DEFAULT '{}',
    pros TEXT[] DEFAULT '{}',
    cons TEXT[] DEFAULT '{}',

    -- Ingredient Transparency
    ingredient_summary TEXT,
    excluded_ingredients TEXT[] DEFAULT '{}',

    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
);
```

**Key Constraints**:

- `CONSTRAINT primary_concerns_not_empty CHECK (array_length(primary_concerns, 1) > 0)` - Always have at least 1 concern
- `CONSTRAINT philosophy_not_empty CHECK (array_length(philosophy_tags, 1) > 0)` - Always have philosophy
- `slug` and `category_slug` must be lowercase alphanumeric with hyphens

**Editorial Fields**:

- `editorial_pick`: Recommended for first-time buyers
- `safe_starting_point`: Validated as safe entry point (trust signal)
- `edit_log`: JSONB array tracks: `[{timestamp, editor, change}, ...]`

---

### **product_certifications** - Trusted Badges

```sql
CREATE TABLE product_certifications (
    id UUID PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    certification certification_name NOT NULL,
    description TEXT,
    verified_at DATE,
    CONSTRAINT unique_cert_per_product UNIQUE(product_id, certification)
);
```

**Why separate table**:

- Products may have 0-many certifications
- Each certification is verified with date
- `UNIQUE(product_id, certification)` prevents duplicates
- Easy to audit: "List all products with BDIH certification"

---

### **product_buy_links** - Affiliate-Ready URLs

```sql
CREATE TABLE product_buy_links (
    id UUID PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    vendor VARCHAR(255) NOT NULL,
    url VARCHAR(2000) NOT NULL,
    is_affiliate BOOLEAN NOT NULL DEFAULT false,
    display_order INT NOT NULL DEFAULT 0,
    active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT url_valid CHECK (url ~ '^https?://')
);
```

**Key Features**:

- `is_affiliate`: Flag for affiliate vs. direct links
- `display_order`: Control vendor priority (Amazon first, then Nykaa, etc.)
- `active`: Soft-delete for outdated links
- `CONSTRAINT url_valid`: Only HTTPS links

---

### **product_prices** - Localized & Transparent

```sql
CREATE TABLE product_prices (
    id UUID PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    country_code CHAR(2) NOT NULL,
    currency_code CHAR(3) NOT NULL,
    currency_symbol VARCHAR(5),
    min_price DECIMAL(12,2) NOT NULL,
    max_price DECIMAL(12,2) NOT NULL,
    effective_from DATE NOT NULL DEFAULT CURRENT_DATE,
    effective_until DATE,
    CONSTRAINT unique_active_price UNIQUE(product_id, country_code, currency_code)
);
```

**Why separate table**:

- Products have 1-many prices (INR, USD, GBP, etc.)
- Supports price changes over time with `effective_from`/`effective_until`
- Easy filtering: "Show me products under ₹500 in India"

---

### **product_score_breakdown** - Transparent Methodology

```sql
CREATE TABLE product_score_breakdown (
    id UUID PRIMARY KEY,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    factor VARCHAR(100) NOT NULL,
    score INT NOT NULL CHECK (score >= 0 AND score <= 100),
    max_score INT NOT NULL DEFAULT 100,
    weight DECIMAL(5,4) CHECK (weight >= 0 AND weight <= 1),
    explanation TEXT,
    CONSTRAINT unique_factor_per_product UNIQUE(product_id, factor)
);
```

**Example data**:

```
product_id = "forest-essentials-..."
factor = "ingredient_safety", score = 96, weight = 0.40, explanation = "..."
factor = "efficacy_for_concern", score = 93, weight = 0.30
factor = "long_term_scalp_health", score = 91, weight = 0.20
factor = "transparency", score = 90, weight = 0.10
```

When aggregated: `96*0.40 + 93*0.30 + 91*0.20 + 90*0.10 = 93.4 ≈ 94` (shown score)

---

### **methodologies** - Versioned Rules

```sql
CREATE TABLE methodologies (
    id UUID PRIMARY KEY,
    version VARCHAR(20) NOT NULL UNIQUE,
    category_slug VARCHAR(100) NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    scoring_factors JSONB NOT NULL,
    is_current BOOLEAN NOT NULL DEFAULT false,
    published_at TIMESTAMP WITH TIME ZONE,
);
```

**Example `scoring_factors`**:

```json
{
  "ingredient_safety": {
    "weight": 0.4,
    "description": "Harsh chemicals, disqualifiers, safety testing"
  },
  "efficacy_for_concern": {
    "weight": 0.3,
    "description": "Effectiveness for primary concern"
  },
  "long_term_scalp_health": {
    "weight": 0.2,
    "description": "No rebound, dependency, or scalp damage"
  },
  "transparency": {
    "weight": 0.1,
    "description": "INCI clarity, certifications, honest positioning"
  }
}
```

---

## Optimized Indexes

### **Filtering Indexes** (Most Common Queries)

```sql
-- Single-value filters (fast equality lookup)
CREATE INDEX idx_products_usage_pattern ON products(usage_pattern)
    WHERE status = 'active';

CREATE INDEX idx_products_price_tier ON products(price_tier)
    WHERE status = 'active';

-- Array filters (GIN indexes for @> containment operator)
CREATE INDEX idx_products_primary_concerns ON products USING GIN(primary_concerns)
    WHERE status = 'active';

CREATE INDEX idx_products_philosophy_tags ON products USING GIN(philosophy_tags)
    WHERE status = 'active';

-- Combined filters (common multi-filter queries)
CREATE INDEX idx_products_category_concerns ON products(category_slug, primary_concerns)
    WHERE status = 'active';

CREATE INDEX idx_products_category_philosophy ON products(category_slug, philosophy_tags)
    WHERE status = 'active';
```

### **Discovery Indexes**

```sql
-- Editorial picks
CREATE INDEX idx_products_editorial_picks ON products(category_slug, score DESC)
    WHERE status = 'active' AND editorial_pick = true;

-- Safe starting points
CREATE INDEX idx_products_safe_start ON products(category_slug, score DESC)
    WHERE status = 'active' AND safe_starting_point = true;

-- Latest reviews
CREATE INDEX idx_products_reviewed_date ON products(last_reviewed_at DESC)
    WHERE status = 'active';
```

### **Lookup Indexes**

```sql
-- By slug
CREATE UNIQUE INDEX idx_products_slug ON products(slug);

-- By category
CREATE INDEX idx_products_category ON products(category_slug)
    WHERE status = 'active';
```

---

## Key Constraints Enforced

| Constraint                                          | Purpose                                 |
| --------------------------------------------------- | --------------------------------------- |
| `PRIMARY KEY`                                       | Unique identity                         |
| `UNIQUE(slug)`                                      | SEO-friendly URLs must be unique        |
| `UNIQUE(product_id, certification)`                 | No duplicate certifications per product |
| `UNIQUE(product_id, country_code, currency_code)`   | One active price per currency           |
| `CHECK (score >= 0 AND score <= 100)`               | Score always valid                      |
| `CHECK (min_price >= 0 AND max_price >= min_price)` | Price logic valid                       |
| `CHECK (array_length(primary_concerns, 1) > 0)`     | At least 1 concern required             |
| `NOT NULL` on key fields                            | Required data always present            |

---

## Query Examples

### **Filter by Concerns & Philosophy**

```sql
SELECT * FROM products
WHERE status = 'active'
  AND 'dandruff_safe' = ANY(primary_concerns)
  AND 'ayurvedic' = ANY(philosophy_tags)
  AND category_slug = 'shampoo'
ORDER BY score DESC;
```

**Index used**: `idx_products_primary_concerns`, `idx_products_philosophy_tags`

### **Find Safe Starting Points**

```sql
SELECT * FROM safe_starting_points
WHERE category_slug = 'shampoo'
ORDER BY score DESC
LIMIT 5;
```

**Index used**: `idx_products_safe_start`

### **List All Editorial Picks**

```sql
SELECT * FROM editorial_picks
WHERE category_slug = 'shampoo'
ORDER BY score DESC;
```

**Index used**: `idx_products_editorial_picks`

### **Check Product Certifications**

```sql
SELECT p.name, pc.certification, pc.verified_at
FROM products p
LEFT JOIN product_certifications pc ON p.id = pc.product_id
WHERE p.slug = 'forest-essentials-bhringraj-shikakai-cleanser'
ORDER BY pc.verified_at DESC;
```

### **Find Products with Specific Pricing**

```sql
SELECT p.slug, p.name, pp.currency_code, pp.min_price, pp.max_price
FROM products p
JOIN product_prices pp ON p.id = pp.product_id
WHERE p.category_slug = 'shampoo'
  AND pp.country_code = 'IN'
  AND pp.currency_code = 'INR'
  AND pp.min_price <= 500
ORDER BY p.score DESC;
```

---

## Migration Path from Old Schema

1. **Create new tables** with migration `004_editorial_schema.sql`
2. **Migrate existing data** from `mock/data.go` into new schema
3. **Update API handlers** to query new tables
4. **Phase out old schema** tables once API is stable
5. **Keep product_content_versions** table for audit trail

---

## Summary

This schema delivers:
✅ **Editorial control**: ENUMs prevent tag chaos  
✅ **Data discipline**: Constraints enforce consistency  
✅ **Transparent methodology**: Versioned scoring with breakdown  
✅ **Affiliate-ready**: Buy links with tracking flags  
✅ **Scalable filtering**: GIN indexes for array queries  
✅ **Content audit trail**: Edit logs and version history  
✅ **Trust signals**: Editorial picks, safe starting points  
✅ **Localized pricing**: Multi-currency support

**Next steps**:

1. Apply migration to development database
2. Seed with product data from `product_data/shampoos/file.json`
3. Update Go models to match new schema
4. Update API handlers for new filtering logic
