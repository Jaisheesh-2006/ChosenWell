import {
  CategorySummary,
  Category,
  ProductSummary,
  Product,
  Methodology,
  HealthStatus,
  CurrencyList,
} from "./types";

const API_BASE_URL =
  process.env.NEXT_PUBLIC_API_URL ||
  "https://chosenwell-production.up.railway.app";

/**
 * Optimized fetch function with ISR (Incremental Static Regeneration)
 * - Uses revalidate for caching (default 60 seconds)
 * - Robust JSON extraction to handle Next.js cache issues
 */
async function fetchApi<T>(
  endpoint: string,
  revalidateSeconds: number = 60
): Promise<T> {
  const url = `${API_BASE_URL}${endpoint}`;

  const res = await fetch(url, {
    method: "GET",
    headers: {
      Accept: "application/json",
    },
    next: { revalidate: revalidateSeconds },
  });

  if (!res.ok) {
    throw new Error(`API error: ${res.status} ${res.statusText} for ${url}`);
  }

  const text = await res.text();

  if (!text || text.trim() === "") {
    return {} as T;
  }

  try {
    // First, try direct JSON parse (fast path for clean responses)
    return JSON.parse(text) as T;
  } catch {
    // If direct parse fails, extract JSON from potentially corrupted cache
    // Next.js RSC cache can prepend metadata like "59:[]" or "http/1.1{...}"
    const jsonMatch = text.match(/(\{[\s\S]*\}|\[[\s\S]*\])/);
    if (jsonMatch) {
      try {
        return JSON.parse(jsonMatch[1]) as T;
      } catch (innerError) {
        console.error(`Failed to extract JSON from ${url}:`, innerError);
      }
    }
    console.error(
      `Invalid response from ${url} (first 300 chars):`,
      text.slice(0, 300)
    );
    throw new Error(`Invalid JSON response from ${endpoint}`);
  }
}

// Health check - no caching needed
export async function getHealthStatus(): Promise<HealthStatus> {
  const url = `${API_BASE_URL}/health`;
  const res = await fetch(url, { cache: "no-store" });
  if (!res.ok) throw new Error(`Health check failed: ${res.status}`);
  return res.json();
}

// Categories - cache for 5 minutes (categories rarely change)
export async function getCategories(): Promise<CategorySummary[]> {
  return fetchApi<CategorySummary[]>("/categories", 300);
}

export async function getCategoryBySlug(slug: string): Promise<Category> {
  return fetchApi<Category>(`/categories/${encodeURIComponent(slug)}`, 300);
}

// Products
export interface GetProductsParams {
  category?: string;
  tag?: string;
  limit?: number;
}

interface ProductsResponse {
  products: ProductSummary[];
  total?: number;
}

// Products list - cache for 1 minute
export async function getProducts(
  params?: GetProductsParams
): Promise<ProductSummary[]> {
  const searchParams = new URLSearchParams();

  if (params?.category) {
    searchParams.set("category", params.category);
  }
  if (params?.tag) {
    searchParams.set("tag", params.tag);
  }
  if (params?.limit) {
    searchParams.set("limit", params.limit.toString());
  }

  const queryString = searchParams.toString();
  const endpoint = queryString ? `/products?${queryString}` : "/products";

  const response = await fetchApi<ProductsResponse>(endpoint, 60);
  return response.products || [];
}

// Single product - cache for 5 minutes
export async function getProductBySlug(
  slug: string,
  country?: string
): Promise<Product> {
  const params = country ? `?country=${encodeURIComponent(country)}` : "";
  return fetchApi<Product>(
    `/products/${encodeURIComponent(slug)}${params}`,
    300
  );
}

// Similar products - cache for 5 minutes
export async function getSimilarProducts(
  slug: string,
  limit?: number
): Promise<ProductSummary[]> {
  const params = limit ? `?limit=${limit}` : "";
  return fetchApi<ProductSummary[]>(
    `/products/${encodeURIComponent(slug)}/similar${params}`,
    300
  );
}

// Currencies - cache for 1 hour (rarely changes)
export async function getCurrencies(): Promise<CurrencyList> {
  return fetchApi<CurrencyList>("/currencies", 3600);
}

// Methodology - cache for 1 hour (rarely changes)
export async function getMethodology(): Promise<Methodology> {
  return fetchApi<Methodology>("/methodology", 3600);
}
