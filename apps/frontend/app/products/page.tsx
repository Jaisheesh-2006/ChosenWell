import type { Metadata } from "next";
import { getProducts } from "../lib/api";
import { ProductSummary } from "../lib/types";
import ProductCard from "../components/ProductCard";
import Breadcrumbs from "../components/Breadcrumbs";
import EmptyState from "../components/EmptyState";
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

// No fallback data - only use database

async function getProductsPageData() {
  try {
    const products = await getProducts({});
    return { products };
  } catch (error) {
    console.error("Error fetching products data:", error);
    return { products: [] };
  }
}

export default async function ProductsPage() {
  const { products } = await getProductsPageData();

  // Use products as-is (alphabetically or by database order)
  const sortedProducts = [...products];

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs items={[{ label: "Products" }]} />

      {/* Header */}
      <div className="mb-8">
        <h1 className="text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          All Products
        </h1>
        <p className="mt-4 max-w-3xl text-lg text-slate-600 dark:text-slate-400">
          Browse our curated collection of health products, all verified for
          ingredient safety and quality.
        </p>
      </div>

      {/* Products Grid */}
      <div>
        {sortedProducts.length > 0 ? (
          <>
            <div className="mb-6 flex items-center justify-between">
              <p className="text-sm text-slate-600 dark:text-slate-400">
                {sortedProducts.length} product
                {sortedProducts.length !== 1 ? "s" : ""} found
              </p>
            </div>
            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
              {sortedProducts.map((product) => (
                <ProductCard key={product.slug} product={product} />
              ))}
            </div>
          </>
        ) : (
          <EmptyState
            title="No products found"
            description="Check back later for new products."
          />
        )}
      </div>

      {/* Navigation Section */}
      <section className="mt-16 rounded-2xl border border-slate-200 bg-gradient-to-r from-slate-50 to-slate-100 p-8 dark:border-white/10 dark:from-slate-900/50 dark:to-slate-800/30">
        <div className="flex flex-col items-center justify-between gap-6 sm:flex-row">
          <div>
            <h3 className="text-lg font-semibold text-slate-900 dark:text-white">
              Looking for something specific?
            </h3>
            <p className="mt-1 text-sm text-slate-600 dark:text-slate-400">
              Browse by category or learn how we evaluate products.
            </p>
          </div>
          <div className="flex flex-wrap gap-3">
            <Link
              href="/categories"
              className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-5 py-2.5 text-sm font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
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
              className="inline-flex items-center gap-2 rounded-full border border-slate-300 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 transition-colors hover:bg-slate-50 dark:border-white/20 dark:bg-white/5 dark:text-white dark:hover:bg-white/10"
            >
              Our Methodology
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
