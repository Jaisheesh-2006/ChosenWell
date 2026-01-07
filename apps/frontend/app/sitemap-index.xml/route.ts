/**
 * Sitemap Index for https://www.chosenwell.co.in
 *
 * This is the master sitemap that references all individual sitemaps.
 * Google and Bing will crawl this first, then follow links to child sitemaps.
 *
 * Architecture:
 * - sitemap-pages.xml: Static pages (home, about, contact, privacy, methodology)
 * - sitemap-categories.xml: Product category pages
 * - sitemap-products.xml: Individual product detail pages
 *
 * Compliance: Google Sitemaps Protocol, Bing Webmaster Guidelines
 */

import { NextResponse } from "next/server";

const BASE_URL = "https://www.chosenwell.co.in";

// Last modification date for sitemap index (update when sitemaps change)
const LAST_MOD = new Date().toISOString().split("T")[0];

export async function GET() {
  const sitemapIndex = `<?xml version="1.0" encoding="UTF-8"?>
<!-- 
  Sitemap Index for ChosenWell Health Product Discovery
  Generated: ${new Date().toISOString()}
  
  This index file references all sitemaps for the website.
  Submit this URL to Google Search Console and Bing Webmaster Tools.
-->
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  
  <!-- Static pages: Home, About, Contact, Privacy, Methodology -->
  <sitemap>
    <loc>${BASE_URL}/sitemap-pages.xml</loc>
    <lastmod>${LAST_MOD}</lastmod>
  </sitemap>
  
  <!-- Product category and concern pages -->
  <sitemap>
    <loc>${BASE_URL}/sitemap-categories.xml</loc>
    <lastmod>${LAST_MOD}</lastmod>
  </sitemap>
  
  <!-- Individual product detail pages -->
  <sitemap>
    <loc>${BASE_URL}/sitemap-products.xml</loc>
    <lastmod>${LAST_MOD}</lastmod>
  </sitemap>
  
</sitemapindex>`;

  return new NextResponse(sitemapIndex, {
    status: 200,
    headers: {
      "Content-Type": "application/xml",
      // Cache for 1 hour, allow CDN caching
      "Cache-Control":
        "public, max-age=3600, s-maxage=3600, stale-while-revalidate=86400",
    },
  });
}
