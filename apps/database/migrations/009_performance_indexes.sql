-- Migration: 009_performance_indexes
-- Description: Add critical indexes for query performance
-- Created: 2026-01-08
-- Purpose: Fix slow queries (40s → 50ms target)

-- =====================
-- CRITICAL INDEXES FOR PERFORMANCE
-- =====================

-- 1. Categories - Fast lookup by slug (primary access pattern)
-- This is the MOST IMPORTANT index for category pages
CREATE INDEX IF NOT EXISTS idx_categories_slug_active 
ON categories(slug) 
WHERE status = 'active';

-- 2. Products by category_slug - This is the main JOIN point
-- Critical for /categories/:slug and /products?category=X
CREATE INDEX IF NOT EXISTS idx_products_category_slug_score 
ON products(category_slug, score DESC) 
WHERE status = 'active';

-- 3. Products by slug - Fast single product lookup
CREATE INDEX IF NOT EXISTS idx_products_slug_active 
ON products(slug) 
WHERE status = 'active';

-- 4. Product primary concerns - Both directions for JOIN performance
CREATE INDEX IF NOT EXISTS idx_product_concerns_product_id 
ON product_primary_concerns(product_id);

CREATE INDEX IF NOT EXISTS idx_product_concerns_concern_code 
ON product_primary_concerns(concern_code);

-- 5. Product philosophy tags - Both directions for JOIN performance
CREATE INDEX IF NOT EXISTS idx_product_philosophy_product_id 
ON product_philosophy_tags(product_id);

CREATE INDEX IF NOT EXISTS idx_product_philosophy_code 
ON product_philosophy_tags(philosophy_code);

-- 6. Buy links by product - Fast lookup for product details
CREATE INDEX IF NOT EXISTS idx_buy_links_product_id_order 
ON product_buy_links(product_id, display_order);

-- 7. Composite index for common filter patterns
-- Used when filtering by category + price tier
CREATE INDEX IF NOT EXISTS idx_products_category_price_score 
ON products(category_slug, price_tier, score DESC) 
WHERE status = 'active';

-- 8. Composite index for category + usage pattern
CREATE INDEX IF NOT EXISTS idx_products_category_usage_score 
ON products(category_slug, usage_pattern, score DESC) 
WHERE status = 'active';

-- =====================
-- ANALYZE TABLES
-- Update statistics for query planner
-- =====================

ANALYZE categories;
ANALYZE products;
ANALYZE product_primary_concerns;
ANALYZE product_philosophy_tags;
ANALYZE product_buy_links;

-- =====================
-- VERIFY INDEXES WERE CREATED
-- =====================

-- You can run this to verify:
-- SELECT indexname, indexdef FROM pg_indexes WHERE tablename IN ('products', 'categories', 'product_primary_concerns', 'product_philosophy_tags', 'product_buy_links');
