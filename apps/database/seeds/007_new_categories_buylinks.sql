-- Buy links for new categories: Soap, Hair Oil, Sunscreen

-- =====================
-- SOAP BUY LINKS
-- =====================

-- Juicy Chemistry Tea Tree Neem Rosemary Soap
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Juicy Chemistry', 'https://www.juicychemistry.co.za/shop/face-care/tea-tree-neem-rosemary/'
FROM products WHERE slug = 'juicy-chemistry-tea-tree-neem-rosemary-soap'
ON CONFLICT DO NOTHING;

-- SoulTree Healing Turmeric Tulsi Soap
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/cdoYSRz'
FROM products WHERE slug = 'soultree-healing-turmeric-tulsi-soap'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/soultree-healing-soap-turmeric-tulsi/p/itma2164c0f953cc'
FROM products WHERE slug = 'soultree-healing-turmeric-tulsi-soap'
ON CONFLICT DO NOTHING;

-- Rustic Art Lemon Charcoal Soap
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/hHr5f14'
FROM products WHERE slug = 'rustic-art-lemon-charcoal-soap'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/rustic-art-lemon-charcoal-soap/p/itm0c7678419bcaa'
FROM products WHERE slug = 'rustic-art-lemon-charcoal-soap'
ON CONFLICT DO NOTHING;

-- Vilvah Classic Goat Milk Soap
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/vilvah-classic-goatmilk-soap-dry-skin/p/itm8e16fa72811f8'
FROM products WHERE slug = 'vilvah-classic-goat-milk-soap'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Vilvah Store', 'https://www.vilvahstore.com/products/classic-goatmilk-soap'
FROM products WHERE slug = 'vilvah-classic-goat-milk-soap'
ON CONFLICT DO NOTHING;

-- Kaprica 100% Coconut Soap
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/24aJTwT'
FROM products WHERE slug = 'kaprica-100pct-coconut-soap'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/kaprica-natural-handmade-pure-cold-pressed-coconut-oil-soap/p/itmfgghcuzyrjgee'
FROM products WHERE slug = 'kaprica-100pct-coconut-soap'
ON CONFLICT DO NOTHING;


-- =====================
-- HAIR OIL BUY LINKS
-- =====================

-- Kama Ayurveda Bringadi
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/ci8TZoe'
FROM products WHERE slug = 'kama-ayurveda-bringadi-intensive-hair-treatment'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/kama-ayurveda-bringadi-intensive-treatment-hair-oil/p/itmf3jyq4hyxcyjw'
FROM products WHERE slug = 'kama-ayurveda-bringadi-intensive-hair-treatment'
ON CONFLICT DO NOTHING;

-- Sesa Ayurvedic Hair Oil
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/2X2uCqg'
FROM products WHERE slug = 'sesa-ayurvedic-hair-oil-traditional-gold'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/sesa-ayurvedic-hair-growth-oil-bhringraj/p/itm1a5d629d958f3'
FROM products WHERE slug = 'sesa-ayurvedic-hair-oil-traditional-gold'
ON CONFLICT DO NOTHING;

-- Nat Habit Daasabuti
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/30wYWHt'
FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/nat-habit-hibiscus-amla-hair-growth-summer-dasabuti-oil-fall-massage-dry-frizzy-treatment-ayurvedic-herbal-fresh-made-16-herbs-heat-soaked-castor-coconut-100ml/p/itm3d33b421e332d'
FROM products WHERE slug = 'nat-habit-daasabuti-hibiscus-amla-summer-oil'
ON CONFLICT DO NOTHING;

-- Avimee Herbal Keshpallav
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/gSx0mnr'
FROM products WHERE slug = 'avimee-herbal-keshpallav-hair-oil'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/avimee-herbal-keshpallav-hair-oil/p/itm343cb3e83bfca'
FROM products WHERE slug = 'avimee-herbal-keshpallav-hair-oil'
ON CONFLICT DO NOTHING;

-- Blue Nectar Briganantadi
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://www.amazon.in/Blue-Nectar-Briganantadi-control-Healthy/dp/B07DV8FHD3'
FROM products WHERE slug = 'blue-nectar-briganantadi-hair-repair-treatment'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/blue-nectar-briganantadi-hair-fall-control-treatment-bringha-oil-coconut/p/itm9956b9d082891'
FROM products WHERE slug = 'blue-nectar-briganantadi-hair-repair-treatment'
ON CONFLICT DO NOTHING;

-- Tribe Concepts 90 Day Miracle
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/5KT5Gje'
FROM products WHERE slug = 'tribe-concepts-90-day-miracle-hair-oil'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/tribe-concepts-90-day-miracle-hair-oil/p/itm8dcaed8f7b89e'
FROM products WHERE slug = 'tribe-concepts-90-day-miracle-hair-oil'
ON CONFLICT DO NOTHING;

-- Soulflower Rosemary Lavender
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://www.amazon.in/Soulflower-Natural-Rosemary-Lavender-Healthy/dp/B06XFWVWMS'
FROM products WHERE slug = 'soulflower-rosemary-lavender-healthy-hair-oil'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/soulflower-rosemary-lavender-oil-healthy-hair-growth-good-damaged/p/itm774114cbefa01'
FROM products WHERE slug = 'soulflower-rosemary-lavender-healthy-hair-oil'
ON CONFLICT DO NOTHING;

-- Indulekha Bringha
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/9fl0T6d'
FROM products WHERE slug = 'indulekha-bringha-ayurvedic-oil'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/indulekha-bringha-ayurvedic-hair-oil-new-growth-oil/p/itm3857fa0ccfa5f'
FROM products WHERE slug = 'indulekha-bringha-ayurvedic-oil'
ON CONFLICT DO NOTHING;

-- Rustic Art Deep Conditioning
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/iQ4NZ4W'
FROM products WHERE slug = 'rustic-art-deep-conditioning-hair-oil'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/rustic-art-organic-deep-conditioning-hair-oil/p/itm59ad2dfe14a8c'
FROM products WHERE slug = 'rustic-art-deep-conditioning-hair-oil'
ON CONFLICT DO NOTHING;

-- Khadi Natural Amla Bhringraj
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/9RDPQ6x'
FROM products WHERE slug = 'khadi-natural-amla-bhringraj-powered-botanics'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/khadi-natural-amla-bhringraj-hair-oil-powered-botanics-oil/p/itm1bd7cba9ec8d6'
FROM products WHERE slug = 'khadi-natural-amla-bhringraj-powered-botanics'
ON CONFLICT DO NOTHING;


-- =====================
-- SUNSCREEN BUY LINKS
-- =====================

-- Re'equil Sheer Zinc Tinted
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/0CoIr34'
FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/re-equil-sheer-zinc-tinted-sunscreen-100-mineral-spf-50-pa/p/itmfd1a4133e5d8a'
FROM products WHERE slug = 'reequil-sheer-zinc-tinted-sunscreen'
ON CONFLICT DO NOTHING;

-- Minimalist SPF 60
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/7au0jqC'
FROM products WHERE slug = 'minimalist-spf-60-silymarin-sunscreen'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/minimalist-sunscreen-spf-60-pa-sun-cream-sensitive-acne-prone-skin-pregnancy-safe/p/itmc156746b227cf'
FROM products WHERE slug = 'minimalist-spf-60-silymarin-sunscreen'
ON CONFLICT DO NOTHING;

-- Chosen Safescreen Marina
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/aSVkY1b'
FROM products WHERE slug = 'chosen-safescreen-marina-mineral-sunscreen'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/'
FROM products WHERE slug = 'chosen-safescreen-marina-mineral-sunscreen'
ON CONFLICT DO NOTHING;

-- SunScoop 100% Mineral
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/6drg7Bg'
FROM products WHERE slug = 'sunscoop-100-mineral-sunscreen'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'http://flipkart.com/sunscoop-sunscreen-spf-50-pa-kids-lotion-100-mineral/p/itmdc429ac2722d4'
FROM products WHERE slug = 'sunscoop-100-mineral-sunscreen'
ON CONFLICT DO NOTHING;

-- La Shield Fisico
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/6JBcScs'
FROM products WHERE slug = 'la-shield-fisico-spf-50-matte-gel'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/la-shield-fisico-spf-50-pa/p/itmcd164dae78bc4'
FROM products WHERE slug = 'la-shield-fisico-spf-50-matte-gel'
ON CONFLICT DO NOTHING;

-- Gabit 100% Mineral Prebiotics
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/9s54I6n'
FROM products WHERE slug = 'gabit-100-mineral-sunscreen-prebiotics'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/gabit-sunscreen-spf-50-pa-100-mineral/p/itmedb53fb2f9a8c'
FROM products WHERE slug = 'gabit-100-mineral-sunscreen-prebiotics'
ON CONFLICT DO NOTHING;

-- Rivela Dermascience
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/1td73Ws'
FROM products WHERE slug = 'rivela-dermascience-tinosorb-m-zinc-sunscreen'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/rivela-sunscreen-spf-50-pa-pa/p/itmd530982cbad25'
FROM products WHERE slug = 'rivela-dermascience-tinosorb-m-zinc-sunscreen'
ON CONFLICT DO NOTHING;

-- UV Doux Mineral Tinted Gel
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/0rMB5fB'
FROM products WHERE slug = 'uv-doux-mineral-tinted-sunscreen-gel'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/brinton-sunscreen-spf-50-pa-uv-doux-mineral/p/itmaa14d2e8a9fe8'
FROM products WHERE slug = 'uv-doux-mineral-tinted-sunscreen-gel'
ON CONFLICT DO NOTHING;

-- SkinInspired Kidscreen
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/0IrBHJ4'
FROM products WHERE slug = 'skininspired-kidscreen-mineral-sunscreen'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/skininspired-sunscreen-spf-50-pa-kidscreen-100-mineral-sunscreen-non-greasy-vitamin-e-pro-b5/p/itm63c38a6c7187e'
FROM products WHERE slug = 'skininspired-kidscreen-mineral-sunscreen'
ON CONFLICT DO NOTHING;

-- Dr. Sheth's Vitamin C & Ceramide
INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Amazon', 'https://amzn.in/d/bVd345F'
FROM products WHERE slug = 'dr-sheths-vitamin-c-ceramide-mineral-sunscreen'
ON CONFLICT DO NOTHING;

INSERT INTO product_buy_links (product_id, vendor, url)
SELECT id, 'Flipkart', 'https://www.flipkart.com/dr-sheth-s-sunscreen-spf-50-pa-ceramide-vitamin-c-long-lasting/p/itmb7c79e8efd5d8'
FROM products WHERE slug = 'dr-sheths-vitamin-c-ceramide-mineral-sunscreen'
ON CONFLICT DO NOTHING;
