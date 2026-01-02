-- Migration: 005_v1_schema
-- Description: Minimal, correct v1 schema for curated product platform
-- Created: 2026-01-01
-- Philosophy: Separate what changes rarely (taxonomy) from what changes often (content, links)

-- =====================
-- DROP OLD SCHEMA IF EXISTS (clean slate for v1)
-- =====================

-- Drop in reverse dependency order
DROP TABLE IF EXISTS product_content_versions CASCADE;
DROP TABLE IF EXISTS product_score_breakdown CASCADE;
DROP TABLE IF EXISTS product_prices CASCADE;
DROP TABLE IF EXISTS product_buy_links CASCADE;
DROP TABLE IF EXISTS product_certifications CASCADE;
DROP TABLE IF EXISTS product_philosophy_tags CASCADE;
DROP TABLE IF EXISTS product_primary_concerns CASCADE;
DROP TABLE IF EXISTS philosophy_tags CASCADE;
DROP TABLE IF EXISTS primary_concerns CASCADE;
DROP TABLE IF EXISTS category_criteria CASCADE;
DROP TABLE IF EXISTS methodologies CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

-- Drop old types if they exist
DROP TYPE IF EXISTS product_status CASCADE;
DROP TYPE IF EXISTS primary_concern CASCADE;
DROP TYPE IF EXISTS philosophy_tag CASCADE;
DROP TYPE IF EXISTS usage_pattern_enum CASCADE;
DROP TYPE IF EXISTS price_tier CASCADE;
DROP TYPE IF EXISTS certification_name CASCADE;
DROP TYPE IF EXISTS score_version CASCADE;

-- =====================
-- ENUMS - Discipline where it matters
-- =====================

-- Product lifecycle
CREATE TYPE product_status AS ENUM ('draft', 'active', 'archived', 'under_review');

-- Usage pattern - exactly one per product
CREATE TYPE usage_pattern AS ENUM ('daily_use', 'alternate_day', 'weekly_detox');

-- Price tier - exactly one per product  
CREATE TYPE price_tier AS ENUM ('premium', 'mid_range', 'affordable');

-- Buy link type
CREATE TYPE link_type AS ENUM ('affiliate', 'direct');

-- =====================
-- 1️⃣ CATEGORIES
-- Purpose: Defines the aisles (Shampoo, Toothpaste, Cooking Oil)
-- Why: SEO pages, Navigation, Category-level methodology
-- =====================

CREATE TABLE categories (
    slug VARCHAR(100) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    long_description TEXT,
    criteria TEXT[] DEFAULT '{}',
    status product_status NOT NULL DEFAULT 'active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE categories IS 'Editorial objects defining product aisles - flexible, not enums';
COMMENT ON COLUMN categories.criteria IS 'Array of evaluation criteria for this category';

-- =====================
-- 4️⃣ PRIMARY_CONCERNS (lookup table)
-- Purpose: Defines the allowed concern vocabulary
-- Why: Guardrail against tag rot
-- =====================

CREATE TABLE primary_concerns (
    code VARCHAR(50) PRIMARY KEY,
    label VARCHAR(100) NOT NULL,
    description TEXT,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE primary_concerns IS 'Controlled vocabulary for decision drivers - NOT marketing tags';

-- =====================
-- 6️⃣ PHILOSOPHY_TAGS (lookup table)
-- Purpose: Controlled vocabulary for formulation philosophy
-- Why: Brand positioning quietly lives here
-- =====================

CREATE TABLE philosophy_tags (
    code VARCHAR(50) PRIMARY KEY,
    label VARCHAR(100) NOT NULL,
    description TEXT,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE philosophy_tags IS 'Controlled vocabulary for how products are made';

-- =====================
-- 2️⃣ PRODUCTS (core table)
-- Purpose: The curated item itself - heart of the system
-- Why: Everything revolves around products - must be stable, auditable, strict
-- =====================

CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(255) NOT NULL,
    category_slug VARCHAR(100) NOT NULL REFERENCES categories(slug) ON DELETE RESTRICT,
    
    -- Editorial control
    status product_status NOT NULL DEFAULT 'draft',
    editorial_pick BOOLEAN NOT NULL DEFAULT false,
    safe_starting_point BOOLEAN NOT NULL DEFAULT false,
    
    -- Scoring & transparency
    score INT NOT NULL CHECK (score >= 0 AND score <= 100),
    score_version VARCHAR(10) NOT NULL DEFAULT 'v1',
    last_reviewed_at DATE NOT NULL,
    
    -- Structured filters (ENUMs - exactly one value)
    usage_pattern usage_pattern NOT NULL,
    price_tier price_tier NOT NULL,
    
    -- Editorial content
    short_reason VARCHAR(500) NOT NULL,
    why_recommended TEXT[] DEFAULT '{}',
    pros TEXT[] DEFAULT '{}',
    cons TEXT[] DEFAULT '{}',
    
    -- Ingredient transparency
    ingredient_summary TEXT,
    certifications TEXT[] DEFAULT '{}',
    excluded_ingredients TEXT[] DEFAULT '{}',
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT slug_format CHECK (slug ~ '^[a-z0-9-]+$')
);

COMMENT ON TABLE products IS 'Heart of the system - encodes trust. Protect from chaos.';
COMMENT ON COLUMN products.editorial_pick IS 'Recommended for first-time buyers';
COMMENT ON COLUMN products.safe_starting_point IS 'Validated as safe entry point - trust signal';
COMMENT ON COLUMN products.score_version IS 'Which methodology version was used to score';

-- =====================
-- 3️⃣ PRODUCT_PRIMARY_CONCERNS (join table)
-- Purpose: Models WHY a user buys a product
-- Why: Prevents invalid values, enables analytics, easier expansion
-- =====================

CREATE TABLE product_primary_concerns (
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    concern_code VARCHAR(50) NOT NULL REFERENCES primary_concerns(code) ON DELETE RESTRICT,
    PRIMARY KEY (product_id, concern_code)
);

COMMENT ON TABLE product_primary_concerns IS 'Decision drivers - NOT marketing tags';

-- =====================
-- 5️⃣ PRODUCT_PHILOSOPHY_TAGS (join table)
-- Purpose: Describes HOW the product is made
-- Why: Different mental model from concerns - users self-identify with philosophy
-- =====================

CREATE TABLE product_philosophy_tags (
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    philosophy_code VARCHAR(50) NOT NULL REFERENCES philosophy_tags(code) ON DELETE RESTRICT,
    PRIMARY KEY (product_id, philosophy_code)
);

COMMENT ON TABLE product_philosophy_tags IS 'Formulation philosophy - brand positioning';

-- =====================
-- 7️⃣ PRODUCT_BUY_LINKS
-- Purpose: Outbound purchase links (affiliate-ready)
-- Why: Links change often, products should not
-- =====================

CREATE TABLE product_buy_links (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    vendor VARCHAR(255) NOT NULL,
    url VARCHAR(2000) NOT NULL,
    link_type link_type NOT NULL DEFAULT 'direct',
    display_order INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT url_format CHECK (url ~ '^https?://')
);

COMMENT ON TABLE product_buy_links IS 'Affiliate-ready purchase links - separate because links change often';

-- =====================
-- 8️⃣ METHODOLOGIES
-- Purpose: Explains how scoring and evaluation works
-- Why: Trust anchor, versioned logic, SEO authority
-- =====================

CREATE TABLE methodologies (
    version VARCHAR(20) PRIMARY KEY,
    summary TEXT NOT NULL,
    scoring_weights JSONB NOT NULL DEFAULT '{}',
    last_updated_at DATE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE methodologies IS 'Trust anchor - protects you when people question scores';

-- =====================
-- INDEXES - Optimized for filtering
-- =====================

-- Categories
CREATE INDEX idx_categories_status ON categories(status) WHERE status = 'active';

-- Products - primary lookups
CREATE INDEX idx_products_category ON products(category_slug) WHERE status = 'active';
CREATE INDEX idx_products_score ON products(score DESC) WHERE status = 'active';
CREATE INDEX idx_products_status ON products(status);

-- Products - editorial discovery
CREATE INDEX idx_products_editorial ON products(category_slug, score DESC) 
    WHERE status = 'active' AND editorial_pick = true;
CREATE INDEX idx_products_safe_start ON products(category_slug, score DESC) 
    WHERE status = 'active' AND safe_starting_point = true;

-- Products - structured filters
CREATE INDEX idx_products_usage ON products(usage_pattern) WHERE status = 'active';
CREATE INDEX idx_products_price_tier ON products(price_tier) WHERE status = 'active';

-- Join tables - enable fast filtering
CREATE INDEX idx_product_concerns_concern ON product_primary_concerns(concern_code);
CREATE INDEX idx_product_philosophy_philosophy ON product_philosophy_tags(philosophy_code);

-- Buy links
CREATE INDEX idx_buy_links_product ON product_buy_links(product_id);

-- =====================
-- TRIGGERS
-- =====================

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_categories_updated_at
    BEFORE UPDATE ON categories
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER trg_products_updated_at
    BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- =====================
-- SEED DATA: Lookup Tables (rarely change)
-- =====================

-- Primary concerns (decision drivers)
INSERT INTO primary_concerns (code, label, description, display_order) VALUES
('dandruff_safe', 'Dandruff Safe', 'Controls dandruff without harsh medicated actives', 1),
('hair_fall_support', 'Hair Fall Support', 'Supports hair growth cycle and reduces breakage', 2),
('dry_frizzy', 'Dry & Frizzy', 'Addresses dryness and frizz without silicone coating', 3),
('oily_scalp', 'Oily Scalp', 'Cleanses without triggering rebound oil production', 4),
('sensitive_scalp', 'Sensitive Scalp', 'Ultra-gentle for reactive or irritated scalps', 5);

-- Philosophy tags (brand positioning)
INSERT INTO philosophy_tags (code, label, description, display_order) VALUES
('ayurvedic', 'Ayurvedic', 'Traditional Indian herbal formulation', 1),
('modern_clean', 'Modern Clean', 'Science-backed gentle surfactants', 2),
('certified_organic', 'Certified Organic', 'Third-party organic certification (BDIH, ECOCERT)', 3),
('zero_chemical', 'Zero Chemical', '100% botanical, no synthetic ingredients', 4),
('solid_bar', 'Solid Bar', 'Plastic-free bar format', 5),
('premium_clean', 'Premium Clean', 'Luxury positioning with clean ingredients', 6);

-- Categories
INSERT INTO categories (slug, title, description, long_description, criteria, status) VALUES
('shampoo', 'Shampoo', 
 'Clean hair care products evaluated for scalp health and ingredient safety.',
 'India''s shampoo market is crowded, confusing, and often misleading. Most products are designed to look effective in the short term—high foam, instant smoothness—while quietly compromising long-term scalp and hair health. Our role is simple: act as a strict filter. If a shampoo appears on this platform, it has cleared a bar that most mass-market products do not.',
 ARRAY[
     'Uses approved gentle cleansing agents only',
     'Full INCI ingredient disclosure',
     'Scalp-compatible pH (~5.5)',
     'No SLS/SLES, parabens, or formaldehyde donors'
 ],
 'active'),
('toothpaste', 'Toothpaste',
 'Natural and effective oral care products analyzed for safety and efficacy.',
 'Natural toothpaste options have evolved significantly, offering effective cleaning without harsh chemicals. We analyze fluoride alternatives, SLS-free formulas, and remineralizing ingredients to help you choose the best option for your family''s oral health.',
 ARRAY[
     'Free from SLS (Sodium Lauryl Sulfate)',
     'No artificial sweeteners or colors',
     'Third-party tested for safety'
 ],
 'active');

-- Methodology
INSERT INTO methodologies (version, summary, scoring_weights, last_updated_at) VALUES
('v1', 
 'Content-first evaluation focusing on ingredient safety, efficacy for stated concerns, and long-term scalp health.',
 '{
     "ingredient_safety": {"weight": 0.40, "description": "Harsh chemicals, disqualifiers, safety testing"},
     "efficacy_for_concern": {"weight": 0.30, "description": "Effectiveness for primary concern"},
     "long_term_health": {"weight": 0.20, "description": "No rebound, dependency, or damage"},
     "transparency": {"weight": 0.10, "description": "INCI clarity, certifications, honest positioning"}
 }'::jsonb,
 '2026-01-01');

-- =====================
-- VIEWS - Common query patterns
-- =====================

-- Active products with concerns and philosophy
CREATE VIEW v_products_full AS
SELECT 
    p.id,
    p.slug,
    p.name,
    p.brand,
    p.category_slug,
    p.status,
    p.editorial_pick,
    p.safe_starting_point,
    p.score,
    p.score_version,
    p.last_reviewed_at,
    p.usage_pattern,
    p.price_tier,
    p.short_reason,
    p.why_recommended,
    p.pros,
    p.cons,
    p.ingredient_summary,
    p.certifications,
    p.excluded_ingredients,
    COALESCE(
        (SELECT array_agg(concern_code) FROM product_primary_concerns WHERE product_id = p.id),
        '{}'
    ) AS primary_concerns,
    COALESCE(
        (SELECT array_agg(philosophy_code) FROM product_philosophy_tags WHERE product_id = p.id),
        '{}'
    ) AS philosophy_tags
FROM products p
WHERE p.status = 'active';

-- Editorial picks
CREATE VIEW v_editorial_picks AS
SELECT * FROM v_products_full
WHERE editorial_pick = true
ORDER BY score DESC;

-- Safe starting points
CREATE VIEW v_safe_starting_points AS
SELECT * FROM v_products_full
WHERE safe_starting_point = true
ORDER BY score DESC;

-- =====================
-- DONE
-- =====================

-- Summary:
-- 8 tables total (as specified)
-- 1. categories
-- 2. products
-- 3. primary_concerns (lookup)
-- 4. product_primary_concerns (join)
-- 5. philosophy_tags (lookup)
-- 6. product_philosophy_tags (join)
-- 7. product_buy_links
-- 8. methodologies
