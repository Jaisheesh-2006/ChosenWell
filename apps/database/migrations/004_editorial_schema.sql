-- Migration: 004_editorial_schema
-- Description: Content-first curated product platform schema with strong editorial control
-- Created: 2026-01-01
-- Author: Senior Backend Engineer

-- =====================
-- ENUMS - Enforce discipline for structured filtering
-- =====================

-- Product status enum
CREATE TYPE product_status AS ENUM (
    'draft',
    'active',
    'archived',
    'under_review'
);

-- Primary concern tags - fixed set for dandruff/hair health/dryness/oiliness/sensitivity
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

-- Philosophy tags - ingredient & brand philosophy
CREATE TYPE philosophy_tag AS ENUM (
    'ayurvedic',
    'certified_organic',
    'modern_clean',
    'zero_chemical',
    'solid_bar',
    'premium_clean'
);

-- Usage pattern - how often to use
CREATE TYPE usage_pattern_enum AS ENUM (
    'daily_use',
    'alternate_day',
    'weekly_detox'
);

-- Price tier - budget classification (exactly one per product)
CREATE TYPE price_tier AS ENUM (
    'premium',
    'mid_range',
    'affordable'
);

-- Certification names - curated list of recognized certifications
CREATE TYPE certification_name AS ENUM (
    'BDIH',
    'AYUSH',
    'ECOCERT',
    'COSMOS',
    'EWG_Verified',
    'Leaping_Bunny',
    'Vegan_Certified',
    'Made_Safe',
    'Non_GMO_Project',
    'NSF_Certified',
    'USDA_Organic',
    'BIS_Compliant',
    'GMP_Certified'
);

-- Score version for methodology tracking
CREATE TYPE score_version AS ENUM (
    'v1',
    'v2',
    'v3'
);

-- =====================
-- CATEGORIES - Content organization (reference only)
-- =====================

CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug VARCHAR(100) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    long_description TEXT,
    criteria_version VARCHAR(20),
    display_order INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_categories_slug ON categories(slug);
COMMENT ON TABLE categories IS 'Product categories (e.g., toothpaste, shampoo) - read-only content container';

-- =====================
-- CORE PRODUCT TABLE - Content-first design
-- =====================

CREATE TABLE products (
    -- Identity & Organization
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug VARCHAR(100) UNIQUE NOT NULL,
    category_slug VARCHAR(100) NOT NULL,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(255) NOT NULL,

    -- Editorial Control - strong governance
    status product_status NOT NULL DEFAULT 'draft',
    editorial_pick BOOLEAN NOT NULL DEFAULT false,
    safe_starting_point BOOLEAN NOT NULL DEFAULT false,
    edit_log JSONB DEFAULT '[]'::jsonb,

    -- Scoring & Transparency
    score DECIMAL(5,2) NOT NULL CHECK (score >= 0 AND score <= 100),
    score_version score_version NOT NULL DEFAULT 'v1',
    last_reviewed_at DATE NOT NULL,

    -- Structured Filtering (No free-form tags)
    primary_concerns primary_concern[] NOT NULL DEFAULT '{}',
    philosophy_tags philosophy_tag[] NOT NULL DEFAULT '{}',
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
    CONSTRAINT category_slug_valid CHECK (category_slug ~ '^[a-z0-9-]+$'),
    CONSTRAINT slug_valid CHECK (slug ~ '^[a-z0-9-]+$'),
    CONSTRAINT score_precision CHECK (score::text ~ '^\d+(\.\d{1,2})?$')
);

COMMENT ON TABLE products IS 'Editorial content products with strong governance - read-only curated catalog';
COMMENT ON COLUMN products.primary_concerns IS 'Array of fixed concern enums - NO free-form tags';
COMMENT ON COLUMN products.philosophy_tags IS 'Array of fixed philosophy enums - enforced consistency';
COMMENT ON COLUMN products.editorial_pick IS 'Editorial flag: true if recommended for first-time buyers';
COMMENT ON COLUMN products.safe_starting_point IS 'Trust signal: true if validated as safe entry point';
COMMENT ON COLUMN products.edit_log IS 'Audit trail: JSONB array of {timestamp, editor, change}';

-- =====================
-- PRODUCT FILTERING INDEXES
-- =====================

-- Filtering by status and discovery
CREATE INDEX idx_products_status_score ON products(status, score DESC)
    WHERE status = 'active';

-- Category-based filtering
CREATE INDEX idx_products_category_slug ON products(category_slug)
    WHERE status = 'active';

-- Structured tag filtering - GIN indexes for array containment
CREATE INDEX idx_products_primary_concerns ON products USING GIN(primary_concerns)
    WHERE status = 'active';

CREATE INDEX idx_products_philosophy_tags ON products USING GIN(philosophy_tags)
    WHERE status = 'active';

-- Single-value filtering (exact match)
CREATE INDEX idx_products_usage_pattern ON products(usage_pattern)
    WHERE status = 'active';

CREATE INDEX idx_products_price_tier ON products(price_tier)
    WHERE status = 'active';

-- Combined filtering (most common queries)
CREATE INDEX idx_products_category_concerns ON products(category_slug, primary_concerns)
    WHERE status = 'active';

CREATE INDEX idx_products_category_philosophy ON products(category_slug, philosophy_tags)
    WHERE status = 'active';

-- Editorial discovery
CREATE INDEX idx_products_editorial_picks ON products(category_slug, score DESC)
    WHERE status = 'active' AND editorial_pick = true;

-- Safe starting points
CREATE INDEX idx_products_safe_start ON products(category_slug, score DESC)
    WHERE status = 'active' AND safe_starting_point = true;

-- Date-based queries
CREATE INDEX idx_products_reviewed_date ON products(last_reviewed_at DESC)
    WHERE status = 'active';

-- =====================
-- CERTIFICATIONS - Fixed curated list
-- =====================

CREATE TABLE product_certifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    certification certification_name NOT NULL,
    description TEXT,
    verified_at DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_cert_per_product UNIQUE(product_id, certification)
);

CREATE INDEX idx_product_certifications_product_id ON product_certifications(product_id);
CREATE INDEX idx_product_certifications_cert_type ON product_certifications(certification);

COMMENT ON TABLE product_certifications IS 'Certifications tied to products - enum-constrained for verification';

-- =====================
-- BUY LINKS - Affiliate-ready URLs
-- =====================

CREATE TABLE product_buy_links (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    vendor VARCHAR(255) NOT NULL,
    url VARCHAR(2000) NOT NULL,
    is_affiliate BOOLEAN NOT NULL DEFAULT false,
    display_order INT NOT NULL DEFAULT 0,
    active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT url_valid CHECK (url ~ '^https?://')
);

CREATE INDEX idx_buy_links_product_id ON product_buy_links(product_id);
CREATE INDEX idx_buy_links_vendor ON product_buy_links(vendor) WHERE active = true;

COMMENT ON TABLE product_buy_links IS 'Affiliate-ready purchase links for products';
COMMENT ON COLUMN product_buy_links.is_affiliate IS 'true if URL includes affiliate tracking code';

-- =====================
-- PRICING - Localized & transparent
-- =====================

CREATE TABLE product_prices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    country_code CHAR(2) NOT NULL,
    currency_code CHAR(3) NOT NULL,
    currency_symbol VARCHAR(5),
    min_price DECIMAL(12,2) NOT NULL,
    max_price DECIMAL(12,2) NOT NULL,
    effective_from DATE NOT NULL DEFAULT CURRENT_DATE,
    effective_until DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT price_valid CHECK (min_price >= 0 AND max_price >= min_price),
    CONSTRAINT unique_active_price UNIQUE(product_id, country_code, currency_code)
);

CREATE INDEX idx_product_prices_product_id ON product_prices(product_id);
CREATE INDEX idx_product_prices_country ON product_prices(country_code);

COMMENT ON TABLE product_prices IS 'Localized pricing for transparency and affiliate links';

-- =====================
-- SCORING BREAKDOWN - Transparency into score calculation
-- =====================

CREATE TABLE product_score_breakdown (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    factor VARCHAR(100) NOT NULL,
    score INT NOT NULL CHECK (score >= 0 AND score <= 100),
    max_score INT NOT NULL DEFAULT 100,
    weight DECIMAL(5,4) CHECK (weight >= 0 AND weight <= 1),
    explanation TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_factor_per_product UNIQUE(product_id, factor)
);

CREATE INDEX idx_score_breakdown_product_id ON product_score_breakdown(product_id);

COMMENT ON TABLE product_score_breakdown IS 'Detailed scoring factors for transparent methodology';

-- =====================
-- CONTENT VERSIONS - Editorial audit trail (for future use)
-- =====================

CREATE TABLE product_content_versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    version_number INT NOT NULL,
    content JSONB NOT NULL,
    published_at TIMESTAMP WITH TIME ZONE,
    published_by VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_version UNIQUE(product_id, version_number)
);

CREATE INDEX idx_content_versions_product_id ON product_content_versions(product_id);
CREATE INDEX idx_content_versions_published ON product_content_versions(published_at DESC);

COMMENT ON TABLE product_content_versions IS 'Audit trail of product content changes for editorial control';

-- =====================
-- CATEGORY CRITERIA - Evaluation standards per category
-- =====================

CREATE TABLE category_criteria (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_slug VARCHAR(100) NOT NULL,
    criteria_type VARCHAR(50) NOT NULL,
    criterion TEXT NOT NULL,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT criteria_type_valid CHECK (criteria_type IN ('must_have', 'good_to_have', 'disqualifier')),
    CONSTRAINT unique_criterion UNIQUE(category_slug, criterion)
);

CREATE INDEX idx_category_criteria_slug ON category_criteria(category_slug);
CREATE INDEX idx_category_criteria_type ON category_criteria(category_slug, criteria_type);

COMMENT ON TABLE category_criteria IS 'Evaluation standards and disqualifiers per category - editorial guidelines';

-- =====================
-- EDITORIAL METHODOLOGY - Versioned scoring rules
-- =====================

CREATE TABLE methodologies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    version VARCHAR(20) NOT NULL UNIQUE,
    category_slug VARCHAR(100) NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    scoring_factors JSONB NOT NULL,
    is_current BOOLEAN NOT NULL DEFAULT false,
    published_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_methodologies_category ON methodologies(category_slug);
CREATE INDEX idx_methodologies_current ON methodologies(category_slug) WHERE is_current = true;

COMMENT ON TABLE methodologies IS 'Versioned methodology documentation for scoring transparency';

-- =====================
-- TRIGGERS & FUNCTIONS
-- =====================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_products_updated_at
    BEFORE UPDATE ON products
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_buy_links_updated_at
    BEFORE UPDATE ON product_buy_links
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- =====================
-- VIEWS - For common queries
-- =====================

-- Active products with full editorial data
CREATE VIEW active_products AS
SELECT 
    p.id,
    p.slug,
    p.category_slug,
    p.name,
    p.brand,
    p.status,
    p.editorial_pick,
    p.safe_starting_point,
    p.score,
    p.score_version,
    p.last_reviewed_at,
    p.primary_concerns,
    p.philosophy_tags,
    p.usage_pattern,
    p.price_tier,
    p.short_reason,
    p.why_recommended,
    p.pros,
    p.cons,
    p.ingredient_summary,
    p.excluded_ingredients
FROM products
WHERE status = 'active'
ORDER BY p.score DESC;

-- Editorial picks by category
CREATE VIEW editorial_picks AS
SELECT 
    p.category_slug,
    p.slug,
    p.name,
    p.brand,
    p.score,
    p.primary_concerns,
    p.philosophy_tags,
    p.price_tier
FROM products p
WHERE p.status = 'active' AND p.editorial_pick = true
ORDER BY p.category_slug, p.score DESC;

-- Safe starting points for beginners
CREATE VIEW safe_starting_points AS
SELECT 
    p.category_slug,
    p.slug,
    p.name,
    p.brand,
    p.score,
    p.price_tier,
    p.short_reason
FROM products p
WHERE p.status = 'active' AND p.safe_starting_point = true
ORDER BY p.category_slug, p.score DESC;

-- =====================
-- CONSTRAINTS & DOCUMENTATION
-- =====================

COMMENT ON SCHEMA public IS 'Content-first curated product platform - editorial control enforced via ENUMs and constraints';

-- Ensure primary concerns are not empty (except for rare cases)
ALTER TABLE products
ADD CONSTRAINT primary_concerns_not_empty CHECK (array_length(primary_concerns, 1) > 0);

-- Ensure at least one philosophy tag
ALTER TABLE products
ADD CONSTRAINT philosophy_not_empty CHECK (array_length(philosophy_tags, 1) > 0);

-- =====================
-- SAMPLE INSERTS FOR VALIDATION
-- =====================

-- Insert categories
INSERT INTO categories (slug, title, description, long_description) VALUES
('shampoo', 'Shampoo', 'Clean hair care products evaluated for scalp health and ingredient safety.',
 'India''s shampoo market is crowded, confusing, and often misleading. Most products are designed to look effective in the short term—high foam, instant smoothness—while quietly compromising long-term scalp and hair health. Our role is simple: act as a strict filter. If a shampoo appears on this platform, it has cleared a bar that most mass-market products do not.')
ON CONFLICT (slug) DO NOTHING;

-- Insert category criteria for shampoo
INSERT INTO category_criteria (category_slug, criteria_type, criterion, display_order) VALUES
('shampoo', 'must_have', 'Uses approved gentle cleansing agents only', 1),
('shampoo', 'must_have', 'Full INCI ingredient disclosure', 2),
('shampoo', 'must_have', 'BIS safety standards compliance', 3),
('shampoo', 'must_have', 'Scalp-compatible pH (~5.5)', 4),
('shampoo', 'good_to_have', 'Contains verified Ayurvedic ingredients', 1),
('shampoo', 'good_to_have', 'ECOCERT / COSMOS certification', 2),
('shampoo', 'disqualifier', 'Sulfates (SLS/SLES)', 1),
('shampoo', 'disqualifier', 'Formaldehyde releasers', 2),
('shampoo', 'disqualifier', 'Parabens', 3)
ON CONFLICT (category_slug, criterion) DO NOTHING;

-- Insert methodology
INSERT INTO methodologies (version, category_slug, title, description, scoring_factors, is_current) VALUES
('v1', 'shampoo', 'Shampoo Scoring Methodology v1',
 'Content-first evaluation focusing on ingredient safety, efficacy for stated concerns, and long-term scalp health.',
 jsonb_build_object(
     'ingredient_safety', jsonb_build_object('weight', 0.4, 'description', 'Harsh chemicals, disqualifiers, safety testing'),
     'efficacy_for_concern', jsonb_build_object('weight', 0.3, 'description', 'Effectiveness for primary concern'),
     'long_term_scalp_health', jsonb_build_object('weight', 0.2, 'description', 'No rebound, dependency, or scalp damage'),
     'transparency', jsonb_build_object('weight', 0.1, 'description', 'INCI clarity, certifications, honest positioning')
 ),
 true)
ON CONFLICT (version) DO NOTHING;
