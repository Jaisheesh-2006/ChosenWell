import {
  CategorySummary,
  Category,
  ProductSummary,
  Product,
  Methodology,
  HealthStatus,
} from "./types";

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:8081";

async function fetchApi<T>(endpoint: string): Promise<T> {
  const res = await fetch(`${API_BASE_URL}${endpoint}`, {
    next: { revalidate: 60 }, // Cache for 60 seconds (ISR)
  });

  if (!res.ok) {
    throw new Error(`API error: ${res.status} ${res.statusText}`);
  }

  return res.json();
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

  return fetchApi<ProductSummary[]>(endpoint);
}

export async function getProductBySlug(slug: string): Promise<Product> {
  return fetchApi<Product>(`/products/${encodeURIComponent(slug)}`);
}

// Methodology
export async function getMethodology(): Promise<Methodology> {
  return fetchApi<Methodology>("/methodology");
}
