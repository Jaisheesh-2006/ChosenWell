/**
 * Static Pages Sitemap for https://www.chosenwell.co.in
 *
 * Contains all static/informational pages:
 * - Homepage (highest priority - entry point)
 * - Products listing page
 * - Categories listing page
 * - About page (E-E-A-T signal for YMYL health site)
 * - Contact page (trustworthiness signal)
 * - Methodology page (expertise/authority signal)
 * - Privacy policy (legal requirement, trust signal)
 *
 * Priority Guidelines (0.0 to 1.0):
 * - 1.0: Homepage
 * - 0.9: Main listing pages (products, categories)
 * - 0.7-0.8: Important info pages (methodology, about)
 * - 0.5-0.6: Secondary pages (contact)
 * - 0.3-0.4: Legal/policy pages (privacy)
 */

import { NextResponse } from "next/server";

const BASE_URL = "https://www.chosenwell.co.in";

// Use current date in ISO 8601 format (YYYY-MM-DD)
const TODAY = new Date().toISOString().split("T")[0];

// Static pages configuration
const STATIC_PAGES = [
  {
    path: "", // Homepage
    lastmod: TODAY,
    changefreq: "daily", // Product recommendations update frequently
    priority: "1.0", // Highest priority - main entry point
  },
  {
    path: "/products", // All products listing
    lastmod: TODAY,
    changefreq: "daily", // New products added regularly
    priority: "0.9",
  },
  {
    path: "/categories", // Category browsing page
    lastmod: TODAY,
    changefreq: "weekly", // Categories change less often
    priority: "0.9",
  },
  {
    path: "/methodology", // How we evaluate products
    lastmod: TODAY,
    changefreq: "monthly", // Methodology rarely changes
    priority: "0.8", // High priority - builds authority/trust
  },
  {
    path: "/about", // About ChosenWell
    lastmod: TODAY,
    changefreq: "monthly",
    priority: "0.7", // E-E-A-T signal for health site
  },
  {
    path: "/contact", // Contact information
    lastmod: TODAY,
    changefreq: "monthly",
    priority: "0.5",
  },
  {
    path: "/privacy", // Privacy policy
    lastmod: TODAY,
    changefreq: "yearly", // Legal pages rarely change
    priority: "0.3",
  },
];

export async function GET() {
  const urlEntries = STATIC_PAGES.map(
    (page) => `
  <url>
    <!-- ${
      page.path === ""
        ? "Homepage"
        : page.path.replace("/", "").charAt(0).toUpperCase() +
          page.path.slice(2)
    } page -->
    <loc>${BASE_URL}${page.path}</loc>
    <lastmod>${page.lastmod}</lastmod>
    <changefreq>${page.changefreq}</changefreq>
    <priority>${page.priority}</priority>
  </url>`
  ).join("");

  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<!--
  Static Pages Sitemap for ChosenWell
  Generated: ${new Date().toISOString()}
  
  Contains: Homepage, Products, Categories, Methodology, About, Contact, Privacy
  Total URLs: ${STATIC_PAGES.length}
-->
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
                            http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
${urlEntries}
</urlset>`;

  return new NextResponse(sitemap, {
    status: 200,
    headers: {
      "Content-Type": "application/xml",
      "Cache-Control":
        "public, max-age=3600, s-maxage=3600, stale-while-revalidate=86400",
    },
  });
}
