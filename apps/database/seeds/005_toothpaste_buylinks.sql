-- Fix: 005_toothpaste_buylinks.sql
-- Description: Add buy links for toothpaste products
-- Created: 2026-01-03

-- =====================
-- TOOTHPASTE BUY LINKS
-- =====================

-- 1. Perfora Dream Relief Sensitive Toothpaste
INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Amazon', 'https://amzn.in/d/incxBDP', 1
FROM products WHERE slug = 'perfora-dream-relief-sensitive-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Flipkart', 'https://www.flipkart.com/perfora-dream-white-fresh-mint-instant-teeth-whitening-sls-free-toothpaste/p/itm1631d551c1f6d', 2
FROM products WHERE slug = 'perfora-dream-relief-sensitive-toothpaste';

-- 2. Salt Oral Care Dawn & Dusk Set
INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Amazon', 'https://amzn.in/d/bevNcna', 1
FROM products WHERE slug = 'salt-oral-care-dawn-dusk-set';

INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Flipkart', 'https://www.flipkart.com/salt-dusk-night-toothpaste-french-vanilla-enamel-protection-sls-fluoride-free/p/itm5c8d125923727', 2
FROM products WHERE slug = 'salt-oral-care-dawn-dusk-set';

-- 3. Herbal Botanical Toothpaste
INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Amazon', 'https://amzn.in/d/iqc75Lr', 1
FROM products WHERE slug = 'herbal-botanical-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Flipkart', 'https://www.flipkart.com/herbal-botanical-toothpaste-toothpaste-white-teeth-stronger-teeth-fresh-breath-toothpaste/p/itm0422320ac27d5', 2
FROM products WHERE slug = 'herbal-botanical-toothpaste';

-- 4. Bentodent Premium Mint Natural Toothpaste
INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Amazon', 'https://amzn.in/d/f9jAmtW', 1
FROM products WHERE slug = 'bentodent-premium-mint-natural-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Flipkart', 'https://www.flipkart.com/bentodent-premium-mint-natural-toothpaste/p/itmd9b990e20f4b2', 2
FROM products WHERE slug = 'bentodent-premium-mint-natural-toothpaste';

-- 5. Vicco Vajradanti Ayurvedic Toothpaste
INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Amazon', 'https://amzn.in/d/hW0jiZq', 1
FROM products WHERE slug = 'vicco-vajradanti-toothpaste-herbal';

INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Flipkart', 'https://www.flipkart.com/vicco-vajradanti-regular-flavour-medicine-gums-teeth-with-18-ayurvedic-herbs-toothpaste/p/itm85769f826aa72', 2
FROM products WHERE slug = 'vicco-vajradanti-toothpaste-herbal';

-- 6. Dente91 Cool Mint Toothpaste
INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Amazon', 'https://amzn.in/d/dofFFso', 1
FROM products WHERE slug = 'dente91-cool-mint-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Flipkart', 'https://www.flipkart.com/dente91-sensitivity-relief-repairs-cavities-free-sls-fluoride-toothpaste/p/itmff107678dd0fd', 2
FROM products WHERE slug = 'dente91-cool-mint-toothpaste';

-- 7. Purexa Super Sensitive Toothpaste
INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Amazon', 'https://amzn.in/d/3bZ08mp', 1
FROM products WHERE slug = 'purexa-super-sensitive-toothpaste';

INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Flipkart', 'https://www.flipkart.com/purexa-sensitive-toothpaste-pack-2/p/itm4a51290672512', 2
FROM products WHERE slug = 'purexa-super-sensitive-toothpaste';

-- 8. Ayudant Herbal Toothpaste (Baidyanath) - only Amazon available
INSERT INTO product_buy_links (product_id, vendor, url, display_order)
SELECT id, 'Amazon', 'https://amzn.in/d/21RJKW7', 1
FROM products WHERE slug = 'ayudant-herbal-toothpaste';
