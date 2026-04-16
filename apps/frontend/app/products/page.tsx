import type { Metadata } from "next";
import { Suspense } from "react";
import { getProducts, getCategories } from "../lib/api";
import { ProductSummary } from "../lib/types";
import ProductCard from "../components/ProductCard";
import Breadcrumbs from "../components/Breadcrumbs";
import EmptyState from "../components/EmptyState";
import ProductsFilters from "../components/ProductsFilters";
import Link from "next/link";

export const metadata: Metadata = {
  title: "All Products - Verified Health Products India",
  description:
    "Browse all verified health products. Safe, effective products for everyday use in India - no sponsored rankings, just honest ingredient analysis.",
  alternates: {
    canonical: "/products",
  },
  openGraph: {
    title: "All Products | ChosenWell",
    description:
      "Browse all verified health products with detailed ingredient analysis.",
    url: "/products",
  },
};

// ISR: Revalidate products page every 60 seconds
export const revalidate = 60;

interface ProductsPageProps {
  searchParams: Promise<{
    search?: string;
    category?: string;
    sort?: string;
  }>;
}

async function getProductsPageData(category?: string) {
  try {
    const [products, categories] = await Promise.all([
      getProducts(category ? { category } : {}),
      getCategories(),
    ]);
    return { products, categories };
  } catch (error) {
    console.error("Error fetching products data:", error);
    return { products: [], categories: [] };
  }
}

function applyFilters(
  products: ProductSummary[],
  search?: string,
  sort?: string,
): ProductSummary[] {
  let result = [...products];

  if (search) {
    const query = search.toLowerCase();
    result = result.filter(
      (p) =>
        p.name.toLowerCase().includes(query) ||
        (p.brand && p.brand.toLowerCase().includes(query)),
    );
  }

  if (sort === "name-asc") {
    result.sort((a, b) => a.name.localeCompare(b.name));
  } else if (sort === "name-desc") {
    result.sort((a, b) => b.name.localeCompare(a.name));
  }

  return result;
}

export default async function ProductsPage({ searchParams }: ProductsPageProps) {
  const { search, category, sort } = await searchParams;

  const { products, categories } = await getProductsPageData(category);
  const filtered = applyFilters(products, search, sort);

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs items={[{ label: "Products" }]} />

      {/* Header */}
      <div className="mb-8">
        <h1 className="page-heading">
          All Products
        </h1>
        <p className="mt-4 max-w-3xl text-lg text-text-muted">
          Browse our curated collection of health products, all verified for
          ingredient safety and quality.
        </p>
      </div>

      {/* Filters */}
      <Suspense>
        <ProductsFilters
          categories={categories}
          totalCount={products.length}
          filteredCount={filtered.length}
        />
      </Suspense>

      {/* Products Grid */}
      <div>
        {filtered.length > 0 ? (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {filtered.map((product) => (
              <ProductCard key={product.slug} product={product} />
            ))}
          </div>
        ) : (
          <EmptyState
            title="No products found"
            description={
              search || category
                ? "Try adjusting your filters."
                : "Check back later for new products."
            }
          />
        )}
      </div>

      {/* Navigation Section */}
      <section className="mt-16 card p-8">
        <div className="flex flex-col items-center justify-between gap-6 sm:flex-row">
          <div>
            <h3 className="text-lg font-semibold text-text">
              Looking for something specific?
            </h3>
            <p className="mt-1 text-sm text-text-muted">
              Browse by category or learn how we evaluate products.
            </p>
          </div>
          <div className="flex flex-wrap gap-3">
            <Link
              href="/categories"
              className="btn-primary px-5 py-2.5 text-sm"
            >
              Browse Categories
              <svg
                className="h-4 w-4"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={2}
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
                />
              </svg>
            </Link>
            <Link
              href="/methodology"
              className="btn-secondary px-5 py-2.5 text-sm"
            >
              Our Methodology
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
