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

export interface LocalizedPrice {
  country: string; // ISO country code (e.g., US, IN, GB)
  currency: string; // Currency code (e.g., USD, INR, GBP)
  currency_symbol?: string; // Currency symbol (e.g., $, ₹, £)
  min_price: number;
  max_price?: number;
  formatted?: string; // Pre-formatted price string (e.g., "$29-35")
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
  prices?: LocalizedPrice[]; // Prices in different currencies/countries
  tags?: string[]; // e.g., ["budget", "kids", "organic"]
  last_reviewed?: string; // date format
}

export interface Currency {
  code: string; // Currency code (e.g., USD, INR, GBP)
  symbol: string; // Currency symbol (e.g., $, ₹, £)
  name?: string; // Full currency name (e.g., US Dollar)
  country: string; // Primary country code (e.g., US, IN, GB)
  exchange_rate: number; // Exchange rate relative to base currency (USD)
}

export interface CurrencyList {
  base_currency?: string;
  currencies: Currency[];
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
