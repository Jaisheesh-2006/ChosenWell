/**
 * Categories Sitemap for https://www.chosenwell.co.in
 *
 * Contains all product category pages dynamically fetched from the API.
 * These are important landing pages for users searching for product types.
 *
 * URL Pattern: /categories/{category-slug}
 * Examples: /categories/shampoos, /categories/sunscreen, /categories/toothpaste
 *
 * SEO Notes:
 * - Categories are high-value landing pages (priority 0.8)
 * - Updated weekly as new products may be added to categories
 * - Slugs are lowercase, hyphenated, human-readable
 */

import { NextResponse } from "next/server";
import { getCategories } from "../lib/api";

const BASE_URL = "https://www.chosenwell.co.in";
const TODAY = new Date().toISOString().split("T")[0];

export async function GET() {
  let categoryUrls: string[] = [];
  let totalCategories = 0;

  try {
    // Fetch all categories from API
    const categories = await getCategories();
    totalCategories = categories.length;

    categoryUrls = categories.map(
      (category) => `
  <url>
    <!-- Category: ${category.title || category.slug} -->
    <loc>${BASE_URL}/categories/${category.slug.toLowerCase()}</loc>
    <lastmod>${TODAY}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>`
    );
  } catch (error) {
    // If API is unavailable, return empty sitemap with comment
    console.error("Failed to fetch categories for sitemap:", error);
  }

  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<!--
  Categories Sitemap for ChosenWell
  Generated: ${new Date().toISOString()}
  
  Contains: Product category landing pages
  Total URLs: ${totalCategories}
  
  URL Pattern: /categories/{slug}
  These are important landing pages for product discovery.
-->
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
                            http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
${categoryUrls.join("")}
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
