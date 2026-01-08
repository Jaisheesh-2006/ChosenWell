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

async function fetchApi<T>(endpoint: string): Promise<T> {
  const url = `${API_BASE_URL}${endpoint}`;

  // Use native fetch with no caching to avoid Next.js cache issues
  const res = await fetch(url, {
    method: "GET",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    cache: "no-store", // Disable caching to prevent stale/corrupted responses
  });

  if (!res.ok) {
    throw new Error(`API error: ${res.status} ${res.statusText} for ${url}`);
  }

  const contentType = res.headers.get("content-type");
  if (!contentType || !contentType.includes("application/json")) {
    const text = await res.text();
    console.error(`Unexpected content-type: ${contentType} for URL: ${url}`);
    console.error("Response preview:", text.substring(0, 200));
    throw new Error(`Expected JSON but got ${contentType}`);
  }

  return res.json() as Promise<T>;
}

// Health check
export async function getHealthStatus(): Promise<HealthStatus> {
  return fetchApi<HealthStatus>("/health");
}

// Categories
export async function getCategories(): Promise<CategorySummary[]> {
  return fetchApi<CategorySummary[]>("/categories");
}

export async function getCategoryBySlug(slug: string): Promise<Category> {
  return fetchApi<Category>(`/categories/${encodeURIComponent(slug)}`);
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

  const response = await fetchApi<ProductsResponse>(endpoint);
  return response.products || [];
}

export async function getProductBySlug(
  slug: string,
  country?: string
): Promise<Product> {
  const params = country ? `?country=${encodeURIComponent(country)}` : "";
  return fetchApi<Product>(`/products/${encodeURIComponent(slug)}${params}`);
}

// Similar products
export async function getSimilarProducts(
  slug: string,
  limit?: number
): Promise<ProductSummary[]> {
  const params = limit ? `?limit=${limit}` : "";
  return fetchApi<ProductSummary[]>(
    `/products/${encodeURIComponent(slug)}/similar${params}`
  );
}

// Currencies
export async function getCurrencies(): Promise<CurrencyList> {
  return fetchApi<CurrencyList>("/currencies");
}

// Methodology
export async function getMethodology(): Promise<Methodology> {
  return fetchApi<Methodology>("/methodology");
}
