-- Migration: 002_add_views
-- Description: Create useful views for API queries
-- Created: 2025-12-31

-- View: Category summary (for /categories endpoint)
CREATE OR REPLACE VIEW v_category_summary AS
SELECT 
    c.id,
    c.slug,
    c.title,
    c.description,
    COUNT(p.id) AS product_count
FROM categories c
LEFT JOIN products p ON p.category_id = c.id AND p.is_active = true
GROUP BY c.id, c.slug, c.title, c.description;

-- View: Product summary (for /products listing)
CREATE OR REPLACE VIEW v_product_summary AS
SELECT 
    p.id,
    p.slug,
    p.name,
    p.brand,
    p.score,
    p.short_reason,
    p.price_range,
    c.slug AS category_slug,
    c.title AS category_title
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
WHERE p.is_active = true;

-- View: Full product detail (for /products/{slug})
CREATE OR REPLACE VIEW v_product_detail AS
SELECT 
    p.id,
    p.slug,
    p.name,
    p.brand,
    p.score,
    p.ingredients_summary,
    p.price_range,
    p.last_reviewed,
    c.slug AS category_slug,
    (
        SELECT json_agg(pr.recommendation ORDER BY pr.display_order)
        FROM product_recommendations pr
        WHERE pr.product_id = p.id
    ) AS why_recommended,
    (
        SELECT json_agg(pp.pro ORDER BY pp.display_order)
        FROM product_pros pp
        WHERE pp.product_id = p.id
    ) AS pros,
    (
        SELECT json_agg(pc.con ORDER BY pc.display_order)
        FROM product_cons pc
        WHERE pc.product_id = p.id
    ) AS cons,
    (
        SELECT json_agg(cert.name)
        FROM product_certifications pcert
        JOIN certifications cert ON pcert.certification_id = cert.id
        WHERE pcert.product_id = p.id
    ) AS certifications,
    (
        SELECT json_agg(t.name)
        FROM product_tags pt
        JOIN tags t ON pt.tag_id = t.id
        WHERE pt.product_id = p.id
    ) AS tags,
    (
        SELECT json_agg(json_build_object('vendor', bl.vendor, 'url', bl.url) ORDER BY bl.display_order)
        FROM buy_links bl
        WHERE bl.product_id = p.id
    ) AS buy_links
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
WHERE p.is_active = true;

-- View: Category detail with products (for /categories/{slug})
CREATE OR REPLACE VIEW v_category_detail AS
SELECT 
    c.id,
    c.slug,
    c.title,
    c.long_description,
    (
        SELECT json_agg(cc.criterion ORDER BY cc.display_order)
        FROM category_criteria cc
        WHERE cc.category_id = c.id
    ) AS criteria,
    (
        SELECT json_agg(
            json_build_object(
                'id', p.id,
                'slug', p.slug,
                'name', p.name,
                'brand', p.brand,
                'score', p.score,
                'short_reason', p.short_reason,
                'price_range', p.price_range
            ) ORDER BY p.score DESC
        )
        FROM products p
        WHERE p.category_id = c.id AND p.is_active = true
    ) AS curated_products
FROM categories c;

-- View: Current methodology
CREATE OR REPLACE VIEW v_current_methodology AS
SELECT 
    m.id,
    m.version,
    m.summary,
    m.last_updated,
    (
        SELECT json_object_agg(ms.factor_name, ms.weight)
        FROM methodology_scoring ms
        WHERE ms.methodology_id = m.id
    ) AS scoring
FROM methodology m
WHERE m.is_current = true;
