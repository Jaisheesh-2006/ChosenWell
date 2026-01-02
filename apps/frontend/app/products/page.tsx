import type { Metadata } from "next";
import { getProducts, getCategories } from "../lib/api";
import { ProductSummary, CategorySummary } from "../lib/types";
import ProductCard from "../components/ProductCard";
import Breadcrumbs from "../components/Breadcrumbs";
import EmptyState from "../components/EmptyState";
import Link from "next/link";

export const metadata: Metadata = {
  title: "All Products",
  description:
    "Browse all curated health products with transparent scoring. Filter by category, tags like organic, budget-friendly, or kids-safe. Find the best products for your wellness needs.",
  openGraph: {
    title: "All Products | HealthIsWealth",
    description:
      "Browse all curated health products with transparent scoring and detailed analysis.",
  },
};

interface ProductsPageProps {
  searchParams: Promise<{ category?: string; tag?: string }>;
}

// Fallback data
const fallbackProducts: ProductSummary[] = [
  {
    slug: "rejuve-herbal-elixir",
    name: "Rejuve+ Herbal Elixir",
    brand: "NatureCo",
    score: 92,
    short_reason: "Botanicals for calm, clarity, and core strength.",
    price_range: "$29-35",
  },
  {
    slug: "oceanic-collagen-blend",
    name: "Oceanic Collagen Blend",
    brand: "SeaWell",
    score: 88,
    short_reason:
      "Marine-sourced collagen plus vitamin C to support skin resilience.",
    price_range: "$45-55",
  },
  {
    slug: "grounded-adaptogenic-ritual",
    name: "Grounded Adaptogenic Ritual",
    brand: "EarthBlend",
    score: 85,
    short_reason: "Functional cacao blend for stress reset moments.",
    price_range: "$22-28",
  },
];

const fallbackCategories: CategorySummary[] = [
  { slug: "toothpaste", title: "Toothpaste" },
  { slug: "cooking-oil", title: "Cooking Oils" },
  { slug: "vitamins", title: "Vitamins" },
  { slug: "supplements", title: "Supplements" },
];

const popularTags = ["organic", "budget", "kids", "vegan", "gluten-free"];

async function getProductsPageData(category?: string, tag?: string) {
  try {
    const [products, categories] = await Promise.all([
      getProducts({ category, tag }),
      getCategories(),
    ]);
    return {
      products: products.length > 0 ? products : fallbackProducts,
      categories: categories.length > 0 ? categories : fallbackCategories,
    };
  } catch {
    return {
      products: fallbackProducts,
      categories: fallbackCategories,
    };
  }
}

export default async function ProductsPage({
  searchParams,
}: ProductsPageProps) {
  const { category, tag } = await searchParams;
  const { products, categories } = await getProductsPageData(category, tag);

  // Sort products by score (highest first)
  const sortedProducts = [...products].sort((a, b) => b.score - a.score);

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs items={[{ label: "Products" }]} />

      {/* Header */}
      <div className="mb-8">
        <h1 className="text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          {category
            ? `${categories.find((c) => c.slug === category)?.title || category} Products`
            : tag
              ? `${tag.charAt(0).toUpperCase() + tag.slice(1)} Products`
              : "All Products"}
        </h1>
        <p className="mt-4 max-w-3xl text-lg text-slate-600 dark:text-slate-400">
          {category || tag
            ? `Showing filtered results. ${sortedProducts.length} products found.`
            : "Browse our curated collection of health products, all evaluated with our transparent scoring methodology."}
        </p>
      </div>

      <div className="flex flex-col gap-8 lg:flex-row">
        {/* Sidebar Filters */}
        <aside className="w-full shrink-0 lg:w-64">
          <div className="sticky top-24 space-y-6">
            {/* Category Filter */}
            <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
              <h3 className="text-sm font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400">
                Categories
              </h3>
              <div className="mt-4 space-y-2">
                <Link
                  href="/products"
                  className={`block rounded-lg px-3 py-2 text-sm transition-colors ${
                    !category
                      ? "bg-cyan-500/20 text-cyan-600 dark:text-cyan-400"
                      : "text-slate-600 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300 dark:hover:bg-white/5 dark:hover:text-white"
                  }`}
                >
                  All Categories
                </Link>
                {categories.map((cat) => (
                  <Link
                    key={cat.slug}
                    href={`/products?category=${cat.slug}`}
                    className={`block rounded-lg px-3 py-2 text-sm transition-colors ${
                      category === cat.slug
                        ? "bg-cyan-500/20 text-cyan-600 dark:text-cyan-400"
                        : "text-slate-600 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300 dark:hover:bg-white/5 dark:hover:text-white"
                    }`}
                  >
                    {cat.title}
                  </Link>
                ))}
              </div>
            </div>

            {/* Tag Filter */}
            <div className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
              <h3 className="text-sm font-semibold uppercase tracking-wider text-slate-500 dark:text-slate-400">
                Popular Tags
              </h3>
              <div className="mt-4 flex flex-wrap gap-2">
                {popularTags.map((t) => (
                  <Link
                    key={t}
                    href={`/products?tag=${t}${category ? `&category=${category}` : ""}`}
                    className={`rounded-full border px-3 py-1 text-sm transition-colors ${
                      tag === t
                        ? "border-emerald-500/50 bg-emerald-500/20 text-emerald-600 dark:text-emerald-400"
                        : "border-slate-300 text-slate-500 hover:border-slate-400 hover:text-slate-700 dark:border-slate-700 dark:text-slate-400 dark:hover:border-slate-600 dark:hover:text-white"
                    }`}
                  >
                    {t}
                  </Link>
                ))}
              </div>
            </div>

            {/* Clear Filters */}
            {(category || tag) && (
              <Link
                href="/products"
                className="flex items-center justify-center gap-2 rounded-lg border border-slate-200 bg-slate-100 px-4 py-2 text-sm text-slate-600 transition-colors hover:bg-slate-200 dark:border-white/10 dark:bg-white/5 dark:text-slate-300 dark:hover:bg-white/10"
              >
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
                    d="M6 18L18 6M6 6l12 12"
                  />
                </svg>
                Clear all filters
              </Link>
            )}
          </div>
        </aside>

        {/* Products Grid */}
        <div className="flex-1">
          {sortedProducts.length > 0 ? (
            <>
              <div className="mb-6 flex items-center justify-between">
                <p className="text-sm text-slate-600 dark:text-slate-400">
                  {sortedProducts.length} product
                  {sortedProducts.length !== 1 ? "s" : ""} found
                </p>
                <p className="text-sm text-slate-500 dark:text-slate-500">Sorted by score</p>
              </div>
              <div className="grid gap-6 sm:grid-cols-2 xl:grid-cols-3">
                {sortedProducts.map((product) => (
                  <ProductCard key={product.slug} product={product} />
                ))}
              </div>
            </>
          ) : (
            <EmptyState
              title="No products found"
              description="Try adjusting your filters or check back later for new products."
            />
          )}
        </div>
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
