import { MetadataRoute } from "next";
import { getCategories, getProducts } from "./lib/api";

/**
 * Main Sitemap for https://www.chosenwell.co.in
 *
 * This is the legacy sitemap.xml endpoint maintained for backward compatibility.
 * The primary sitemap architecture uses sitemap-index.xml which references:
 * - sitemap-pages.xml (static pages)
 * - sitemap-categories.xml (category pages)
 * - sitemap-products.xml (product pages)
 *
 * However, this file still generates a complete sitemap for crawlers
 * that directly request /sitemap.xml
 *
 * IMPORTANT: Use canonical www subdomain with HTTPS
 */

const BASE_URL = "https://www.chosenwell.co.in";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const today = new Date();

  // Static pages with SEO-optimized priorities
  const staticPages: MetadataRoute.Sitemap = [
    {
      // Homepage - highest priority, main entry point
      url: BASE_URL,
      lastModified: today,
      changeFrequency: "daily",
      priority: 1,
    },
    {
      // Products listing - core functionality
      url: `${BASE_URL}/products`,
      lastModified: today,
      changeFrequency: "daily",
      priority: 0.9,
    },
    {
      // Categories listing - important for navigation
      url: `${BASE_URL}/categories`,
      lastModified: today,
      changeFrequency: "weekly",
      priority: 0.9,
    },
    {
      // Methodology - E-E-A-T signal for YMYL health site
      url: `${BASE_URL}/methodology`,
      lastModified: today,
      changeFrequency: "monthly",
      priority: 0.8,
    },
    {
      // About - trustworthiness signal
      url: `${BASE_URL}/about`,
      lastModified: today,
      changeFrequency: "monthly",
      priority: 0.7,
    },
    {
      // Contact - trust signal
      url: `${BASE_URL}/contact`,
      lastModified: today,
      changeFrequency: "monthly",
      priority: 0.5,
    },
    {
      // Privacy policy - legal requirement
      url: `${BASE_URL}/privacy`,
      lastModified: today,
      changeFrequency: "yearly",
      priority: 0.3,
    },
  ];

  // Dynamic pages - categories
  let categoryPages: MetadataRoute.Sitemap = [];
  try {
    const categories = await getCategories();
    categoryPages = categories.map((category) => ({
      // Clean, lowercase, hyphenated, root-level URL
      url: `${BASE_URL}/${category.slug.toLowerCase().replace(/_/g, "-")}`,
      lastModified: today,
      changeFrequency: "weekly" as const,
      priority: 0.8,
    }));
  } catch {
    // API unavailable, skip dynamic category pages
    console.error("Sitemap: Failed to fetch categories");
  }

  // Dynamic pages - products
  let productPages: MetadataRoute.Sitemap = [];
  try {
    const products = await getProducts({ limit: 10000 });
    productPages = products.map((product) => ({
      // Clean, lowercase, hyphenated if needed
      url: `${BASE_URL}/products/${product.slug
        .toLowerCase()
        .replace(/_/g, "-")}`,
      lastModified: today,
      changeFrequency: "weekly" as const,
      priority: 0.7,
    }));
  } catch {
    // API unavailable, skip dynamic product pages
    console.error("Sitemap: Failed to fetch products");
  }

  return [...staticPages, ...categoryPages, ...productPages];
}
