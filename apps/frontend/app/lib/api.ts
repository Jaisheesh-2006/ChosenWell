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

const IS_DEVELOPMENT = process.env.NODE_ENV === "development";

// ============================================================================
// ERROR HANDLING
// ============================================================================

/**
 * Custom error class for API transport errors
 */
export class ApiError extends Error {
  constructor(
    message: string,
    public status?: number,
    public endpoint?: string
  ) {
    super(message);
    this.name = "ApiError";
  }
}

/**
 * Custom error class for schema validation failures
 */
export class SchemaValidationError extends Error {
  constructor(
    message: string,
    public endpoint: string,
    public expected: string,
    public received: unknown
  ) {
    super(message);
    this.name = "SchemaValidationError";
  }
}

// ============================================================================
// TYPE GUARDS FOR RUNTIME VALIDATION
// ============================================================================

function isObject(value: unknown): value is Record<string, unknown> {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}

function isArray(value: unknown): value is unknown[] {
  return Array.isArray(value);
}

function hasProperty<K extends string>(
  obj: Record<string, unknown>,
  key: K
): obj is Record<string, unknown> & Record<K, unknown> {
  return key in obj;
}

// ============================================================================
// SCHEMA VALIDATORS (Endpoint-specific)
// ============================================================================

/**
 * Validates categories response shape
 * API can return:
 * - Array directly: CategorySummary[]
 * - Wrapped: { categories: CategorySummary[] }
 * - Wrapped (alternate): { value: CategorySummary[], Count: number }
 */
function validateCategoriesResponse(
  data: unknown,
  endpoint: string
): CategorySummary[] {
  // Handle null/undefined gracefully - return empty array
  if (data === null || data === undefined) {
    if (IS_DEVELOPMENT) {
      console.warn(
        `[API] ${endpoint} returned null/undefined, returning empty array`
      );
    }
    return [];
  }

  // Direct array
  if (isArray(data)) {
    return data as CategorySummary[];
  }

  if (isObject(data)) {
    // Check for { value: [...] } format (actual API response)
    if (hasProperty(data, "value") && isArray(data.value)) {
      return data.value as CategorySummary[];
    }
    // Check for { categories: [...] } format
    if (hasProperty(data, "categories") && isArray(data.categories)) {
      return data.categories as CategorySummary[];
    }
    // Check for { data: [...] } format (common API pattern)
    if (hasProperty(data, "data") && isArray(data.data)) {
      return data.data as CategorySummary[];
    }
    // If object has no recognized array property but is empty, return empty array
    if (Object.keys(data).length === 0) {
      return [];
    }
  }

  // Log detailed error info in development
  if (IS_DEVELOPMENT) {
    console.error(`[API] Unexpected response shape from ${endpoint}:`, {
      type: typeof data,
      isArray: Array.isArray(data),
      keys: isObject(data) ? Object.keys(data) : "N/A",
      preview: JSON.stringify(data)?.slice(0, 200),
    });
  }

  throw new SchemaValidationError(
    `Expected CategorySummary[] or { value: CategorySummary[] } from ${endpoint}`,
    endpoint,
    "CategorySummary[] | { value: CategorySummary[] }",
    data
  );
}

/**
 * Validates products response shape
 * API can return:
 * - Array directly: ProductSummary[]
 * - Wrapped: { products: ProductSummary[] }
 * - Wrapped (alternate): { value: ProductSummary[], Count: number }
 */
function validateProductsResponse(
  data: unknown,
  endpoint: string
): ProductSummary[] {
  // Handle null/undefined gracefully - return empty array
  if (data === null || data === undefined) {
    if (IS_DEVELOPMENT) {
      console.warn(
        `[API] ${endpoint} returned null/undefined, returning empty array`
      );
    }
    return [];
  }

  // Direct array
  if (isArray(data)) {
    return data as ProductSummary[];
  }

  if (isObject(data)) {
    // Check for { value: [...] } format
    if (hasProperty(data, "value") && isArray(data.value)) {
      return data.value as ProductSummary[];
    }
    // Check for { products: [...] } format
    if (hasProperty(data, "products") && isArray(data.products)) {
      return data.products as ProductSummary[];
    }
    // Check for { data: [...] } format (common API pattern)
    if (hasProperty(data, "data") && isArray(data.data)) {
      return data.data as ProductSummary[];
    }
    // If object has no recognized array property but is empty, return empty array
    if (Object.keys(data).length === 0) {
      return [];
    }
  }

  // Log detailed error info in development
  if (IS_DEVELOPMENT) {
    console.error(`[API] Unexpected response shape from ${endpoint}:`, {
      type: typeof data,
      isArray: Array.isArray(data),
      keys: isObject(data) ? Object.keys(data) : "N/A",
      preview: JSON.stringify(data)?.slice(0, 200),
    });
  }

  throw new SchemaValidationError(
    `Expected ProductSummary[] or { value/products: ProductSummary[] } from ${endpoint}`,
    endpoint,
    "ProductSummary[] | { value: ProductSummary[] } | { products: ProductSummary[] }",
    data
  );
}

/**
 * Validates single object response (Product, Category, Methodology)
 */
function validateObjectResponse<T>(
  data: unknown,
  endpoint: string,
  typeName: string
): T {
  if (isObject(data)) {
    return data as T;
  }

  throw new SchemaValidationError(
    `Expected ${typeName} object from ${endpoint}`,
    endpoint,
    typeName,
    data
  );
}

/**
 * Validates array response (similar products, etc.)
 */
function validateArrayResponse<T>(
  data: unknown,
  endpoint: string,
  typeName: string
): T[] {
  if (isArray(data)) {
    return data as T[];
  }

  throw new SchemaValidationError(
    `Expected ${typeName}[] from ${endpoint}`,
    endpoint,
    `${typeName}[]`,
    data
  );
}

// ============================================================================
// TRANSPORT LAYER (Content-Type + HTTP status + JSON parsing ONLY)
// ============================================================================

/**
 * Validates Content-Type header for JSON
 */
function isJsonContentType(contentType: string | null): boolean {
  if (!contentType) return false;
  const normalized = contentType.toLowerCase();
  return (
    normalized.includes("application/json") || normalized.includes("text/json")
  );
}

/**
 * Production-ready fetch function - TRANSPORT LAYER ONLY
 *
 * Validates:
 * ✅ HTTP status codes
 * ✅ Content-Type is application/json
 * ✅ JSON parsing success
 *
 * Does NOT validate:
 * ❌ Response shape/schema (handled by call sites)
 *
/**
 * Fetch with retry logic for transient failures
 */
async function fetchWithRetry(
  url: string,
  options: RequestInit & { next?: { revalidate: number } },
  retries: number = 2
): Promise<Response> {
  let lastError: Error | null = null;

  for (let attempt = 0; attempt <= retries; attempt++) {
    try {
      const res = await fetch(url, options);
      // Don't retry on client errors (4xx) except 408 (timeout) and 429 (rate limit)
      if (
        res.ok ||
        (res.status >= 400 &&
          res.status < 500 &&
          res.status !== 408 &&
          res.status !== 429)
      ) {
        return res;
      }
      // Server error or timeout - retry
      lastError = new Error(`HTTP ${res.status}`);
    } catch (error) {
      lastError = error instanceof Error ? error : new Error("Network error");
    }

    // Wait before retry (exponential backoff: 500ms, 1000ms)
    if (attempt < retries) {
      await new Promise((resolve) => setTimeout(resolve, 500 * (attempt + 1)));
    }
  }

  throw lastError || new Error("Request failed after retries");
}

/**
 * Production-ready fetch function - TRANSPORT LAYER ONLY
 *
 * Validates:
 * ✅ HTTP status codes
 * ✅ Content-Type is application/json
 * ✅ JSON parsing success
 *
 * Does NOT validate:
 * ❌ Response shape/schema (handled by call sites)
 *
 * @returns parsed JSON as `unknown` - call sites must validate shape
 */
async function fetchApi(
  endpoint: string,
  revalidateSeconds: number = 60
): Promise<unknown> {
  const url = `${API_BASE_URL}${endpoint}`;

  // 1. Network request with retry
  let res: Response;
  try {
    res = await fetchWithRetry(url, {
      method: "GET",
      headers: {
        Accept: "application/json",
        "Cache-Control": "no-cache",
        // Add timestamp to help bust stale caches
        "X-Request-Time": Date.now().toString(),
      },
      next: { revalidate: revalidateSeconds },
    });
  } catch (networkError) {
    const message =
      networkError instanceof Error
        ? networkError.message
        : "Network request failed";
    throw new ApiError(`Network error: ${message}`, undefined, endpoint);
  }

  // 2. Validate Content-Type BEFORE consuming body
  const contentType = res.headers.get("content-type");
  if (!isJsonContentType(contentType)) {
    if (IS_DEVELOPMENT) {
      try {
        const rawText = await res.text();
        console.error(`[DEV] Non-JSON response from ${endpoint}:`, {
          status: res.status,
          contentType,
          bodyPreview: rawText.slice(0, 500),
        });
      } catch {
        /* ignore */
      }
    }
    throw new ApiError(
      `Expected application/json but received ${
        contentType || "no content-type"
      } from ${endpoint}`,
      res.status,
      endpoint
    );
  }

  // 3. Check HTTP status
  if (!res.ok) {
    let errorMessage = `HTTP ${res.status}: ${res.statusText}`;
    try {
      const errorBody = await res.json();
      if (isObject(errorBody) && typeof errorBody.error === "string") {
        errorMessage = errorBody.error;
      }
    } catch {
      /* use default message */
    }
    throw new ApiError(errorMessage, res.status, endpoint);
  }

  // 4. Parse JSON
  let data: unknown;
  try {
    data = await res.json();
  } catch {
    throw new ApiError(
      `JSON parsing failed for ${endpoint} (Content-Type was ${contentType})`,
      res.status,
      endpoint
    );
  }

  // Return as unknown - schema validation happens at call sites
  return data;
}

// ============================================================================
// API ENDPOINTS (with schema validation at call site)
// ============================================================================

// Health check - no caching needed
export async function getHealthStatus(): Promise<HealthStatus> {
  const url = `${API_BASE_URL}/health`;
  const res = await fetch(url, { cache: "no-store" });

  if (!res.ok) {
    throw new ApiError("Health check failed", res.status, "/health");
  }

  const contentType = res.headers.get("content-type");
  if (!isJsonContentType(contentType)) {
    throw new ApiError(
      `Health endpoint returned non-JSON: ${contentType}`,
      res.status,
      "/health"
    );
  }

  return res.json();
}

// Categories - cache for 5 minutes
export async function getCategories(): Promise<CategorySummary[]> {
  const endpoint = "/categories";
  const data = await fetchApi(endpoint, 300);
  return validateCategoriesResponse(data, endpoint);
}

export async function getCategoryBySlug(slug: string): Promise<Category> {
  const endpoint = `/categories/${encodeURIComponent(slug)}`;
  const data = await fetchApi(endpoint, 300);
  return validateObjectResponse<Category>(data, endpoint, "Category");
}

// Products
export interface GetProductsParams {
  category?: string;
  tag?: string;
  limit?: number;
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

  const data = await fetchApi(endpoint, 60);
  return validateProductsResponse(data, endpoint);
}

// Single product - cache for 5 minutes
export async function getProductBySlug(
  slug: string,
  country?: string
): Promise<Product> {
  const params = country ? `?country=${encodeURIComponent(country)}` : "";
  const endpoint = `/products/${encodeURIComponent(slug)}${params}`;
  const data = await fetchApi(endpoint, 300);
  return validateObjectResponse<Product>(data, endpoint, "Product");
}

// Similar products - cache for 5 minutes
export async function getSimilarProducts(
  slug: string,
  limit?: number
): Promise<ProductSummary[]> {
  const params = limit ? `?limit=${limit}` : "";
  const endpoint = `/products/${encodeURIComponent(slug)}/similar${params}`;
  const data = await fetchApi(endpoint, 300);
  return validateArrayResponse<ProductSummary>(
    data,
    endpoint,
    "ProductSummary"
  );
}

// Currencies - cache for 1 hour (rarely changes)
export async function getCurrencies(): Promise<CurrencyList> {
  const endpoint = "/currencies";
  const data = await fetchApi(endpoint, 3600);
  return validateObjectResponse<CurrencyList>(data, endpoint, "CurrencyList");
}

// Methodology - cache for 1 hour (rarely changes)
export async function getMethodology(): Promise<Methodology> {
  const endpoint = "/methodology";
  const data = await fetchApi(endpoint, 3600);
  return validateObjectResponse<Methodology>(data, endpoint, "Methodology");
}
