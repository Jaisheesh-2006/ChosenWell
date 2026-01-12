/**
 * Products Sitemap for https://www.chosenwell.co.in
 *
 * Contains all individual product detail pages dynamically fetched from the API.
 * This is the largest sitemap as it contains every product in the database.
 *
 * URL Pattern: /products/{product-slug}
 * Examples: /products/himalaya-neem-face-wash, /products/colgate-total-toothpaste
 *
 * SEO Notes:
 * - Product pages are core content (priority 0.7)
 * - Updated weekly as product info may change
 * - Each product has a unique, SEO-friendly slug
 * - No query strings - clean canonical URLs only
 *
 * Google Limit: 50,000 URLs per sitemap
 * If you exceed this, implement pagination with sitemap-products-1.xml, etc.
 */

import { NextResponse } from "next/server";
import { getProducts } from "../lib/api";

const BASE_URL = "https://www.chosenwell.co.in";
const TODAY = new Date().toISOString().split("T")[0];

export async function GET() {
  let productUrls: string[] = [];
  let totalProducts = 0;

  try {
    // Fetch all products from API (high limit to get all)
    const products = await getProducts({ limit: 10000 });
    totalProducts = products.length;

    productUrls = products.map(
      (product) => `
  <url>
    <!-- Product: ${product.name || product.slug} -->
    <loc>${BASE_URL}/products/${product.slug.toLowerCase()}</loc>
    <lastmod>${TODAY}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>`
    );
  } catch (error) {
    // If API is unavailable, return empty sitemap
    console.error("Failed to fetch products for sitemap:", error);
  }

  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<!--
  Products Sitemap for ChosenWell
  Generated: ${new Date().toISOString()}
  
  Contains: Individual product detail pages
  Total URLs: ${totalProducts}
  
  URL Pattern: /products/{slug}
  These are the core content pages with verified product analysis.
  
  Note: Google recommends max 50,000 URLs per sitemap.
  If you exceed this limit, implement pagination.
-->
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
                            http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
${productUrls.join("")}
</urlset>`;

  return new NextResponse(sitemap, {
    status: 200,
    headers: {
      "Content-Type": "application/xml",
      // Cache for 1 hour, stale-while-revalidate for 24 hours
      "Cache-Control":
        "public, max-age=3600, s-maxage=3600, stale-while-revalidate=86400",
    },
  });
}

// Revalidate every hour (ISR)
export const revalidate = 3600;
