import { MetadataRoute } from "next";
import { getCategories, getProducts } from "./lib/api";

const BASE_URL = process.env.NEXT_PUBLIC_SITE_URL || "https://chosenwell.co.in";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  // Static pages
  const staticPages: MetadataRoute.Sitemap = [
    {
      url: BASE_URL,
      lastModified: new Date(),
      changeFrequency: "daily",
      priority: 1,
    },
    {
      url: `${BASE_URL}/products`,
      lastModified: new Date(),
      changeFrequency: "daily",
      priority: 0.9,
    },
    {
      url: `${BASE_URL}/categories`,
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 0.8,
    },
    {
      url: `${BASE_URL}/methodology`,
      lastModified: new Date(),
      changeFrequency: "monthly",
      priority: 0.7,
    },
  ];

  // Dynamic pages - categories
  let categoryPages: MetadataRoute.Sitemap = [];
  try {
    const categories = await getCategories();
    categoryPages = categories.map((category) => ({
      url: `${BASE_URL}/categories/${category.slug}`,
      lastModified: new Date(),
      changeFrequency: "weekly" as const,
      priority: 0.8,
    }));
  } catch {
    // API unavailable, skip dynamic category pages
  }

  // Dynamic pages - products
  let productPages: MetadataRoute.Sitemap = [];
  try {
    const products = await getProducts({ limit: 200 });
    productPages = products.map((product) => ({
      url: `${BASE_URL}/products/${product.slug}`,
      lastModified: new Date(),
      changeFrequency: "weekly" as const,
      priority: 0.7,
    }));
  } catch {
    // API unavailable, skip dynamic product pages
  }

  return [...staticPages, ...categoryPages, ...productPages];
}
