// Types matching OpenAPI contract schemas

export interface CategorySummary {
  slug: string;
  title: string;
  description?: string;
}

export interface Category {
  slug: string;
  title: string;
  long_description: string; // SEO-rich long-form content (HTML or markdown)
  criteria?: string[];
  curated_products?: ProductSummary[];
}

export interface ProductSummary {
  id?: string;
  slug: string;
  name: string;
  brand?: string;
  score: number; // 0-100 aggregated score
  short_reason?: string;
  price_range?: string;
}

export interface BuyLink {
  vendor?: string;
  url?: string;
}

export interface Product {
  id?: string;
  slug: string;
  name: string;
  brand?: string;
  category?: string; // category slug
  score: number;
  why_recommended?: string[];
  pros?: string[];
  cons?: string[];
  ingredients_summary?: string;
  certifications?: string[];
  buy_links?: BuyLink[];
  price_range?: string;
  tags?: string[]; // e.g., ["budget", "kids", "organic"]
  last_reviewed?: string; // date format
}

export interface Methodology {
  version: string;
  summary: string;
  scoring?: Record<string, number>; // weight for each factor
  last_updated?: string; // date format
}

export interface HealthStatus {
  status: string;
  service: string;
}

export interface ApiError {
  message: string;
}
