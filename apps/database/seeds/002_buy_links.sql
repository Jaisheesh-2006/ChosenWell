-- Seed: 004_buy_links.sql
-- Description: Affiliate buy links for all products
-- Created: 2026-01-01
-- Schema: v1 (005_v1_schema.sql)

-- =====================
-- BUY LINKS
-- =====================

-- Forest Essentials
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Forest Essentials', 'https://www.forestessentialsindia.com/hair-cleanser-bhringraj-shikakai.html', 'direct', 1
FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-cleanser';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', 'https://amazon.in/dp/B07XXX', 'affiliate', 2
FROM products WHERE slug = 'forest-essentials-bhringraj-shikakai-cleanser';

-- Sadhev
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Sadhev', 'https://sadhev.com/anti-dandruff-shampoo', 'direct', 1
FROM products WHERE slug = 'sadhev-ayurvedic-anti-dandruff-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', 'https://amazon.in/dp/B08XXX', 'affiliate', 2
FROM products WHERE slug = 'sadhev-ayurvedic-anti-dandruff-shampoo';

-- Just Herbs
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Just Herbs', 'https://justherbs.in/amla-neem-shampoo', 'direct', 1
FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', 'https://amazon.in/dp/B09XXX', 'affiliate', 2
FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Nykaa', 'https://nykaa.com/just-herbs-shampoo', 'affiliate', 3
FROM products WHERE slug = 'just-herbs-amla-neem-shampoo';

-- SoulTree
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'SoulTree', 'https://soultree.in/licorice-shampoo', 'direct', 1
FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', 'https://amazon.in/dp/B0AXXX', 'affiliate', 2
FROM products WHERE slug = 'soultree-licorice-bhringraj-shampoo';

-- Kama Ayurveda
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Kama Ayurveda', 'https://kamaayurveda.com/bringadi-cleanser', 'direct', 1
FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', 'https://amazon.in/dp/B0BXXX', 'affiliate', 2
FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Nykaa', 'https://nykaa.com/kama-bringadi', 'affiliate', 3
FROM products WHERE slug = 'kama-ayurveda-bringadi-cleanser';

-- Vilvah
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Vilvah', 'https://vilvahstore.com/goat-milk-shampoo', 'direct', 1
FROM products WHERE slug = 'vilvah-goat-milk-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', 'https://amazon.in/dp/B0CXXX', 'affiliate', 2
FROM products WHERE slug = 'vilvah-goat-milk-shampoo';

-- Arata
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Arata', 'https://arata.in/super-shampoo', 'direct', 1
FROM products WHERE slug = 'arata-super-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', 'https://amazon.in/dp/B0DXXX', 'affiliate', 2
FROM products WHERE slug = 'arata-super-shampoo';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Nykaa', 'https://nykaa.com/arata-super-shampoo', 'affiliate', 3
FROM products WHERE slug = 'arata-super-shampoo';

-- Tribe Concepts
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'The Tribe Concepts', 'https://thetribeconcepts.com/hair-cleanser', 'direct', 1
FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', 'https://amazon.in/dp/B0EXXX', 'affiliate', 2
FROM products WHERE slug = 'tribe-concepts-hair-cleanser-powder';

-- Earth Rhythm
INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Earth Rhythm', 'https://earthrhythm.com/murumuru-shampoo-bar', 'direct', 1
FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Amazon', 'https://amazon.in/dp/B0FXXX', 'affiliate', 2
FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';

INSERT INTO product_buy_links (product_id, vendor, url, link_type, display_order)
SELECT id, 'Nykaa', 'https://nykaa.com/earth-rhythm-shampoo-bar', 'affiliate', 3
FROM products WHERE slug = 'earth-rhythm-murumuru-shampoo-bar';

-- =====================
-- VERIFY
-- =====================

SELECT 
    p.name,
    COUNT(bl.id) AS link_count
FROM products p
LEFT JOIN product_buy_links bl ON bl.product_id = p.id
GROUP BY p.id, p.name
ORDER BY p.name;
