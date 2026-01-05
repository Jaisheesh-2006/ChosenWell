import Link from "next/link";
import { getCategories, getProducts } from "./lib/api";
import { CategorySummary, ProductSummary } from "./lib/types";
import ProductCard from "./components/ProductCard";
import CategoryCard from "./components/CategoryCard";

// No fallback data - only use database

async function getHomePageData() {
  try {
    const [products, categories] = await Promise.all([
      getProducts({ limit: 6 }),
      getCategories(),
    ]);
    return {
      products,
      categories,
    };
  } catch (error) {
    console.error("Error fetching home page data:", error);
    return {
      products: [],
      categories: [],
    };
  }
}

export default async function HomePage() {
  const { products, categories } = await getHomePageData();

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      {/* Hero Section */}
      <section className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-cyan-600/20 via-emerald-600/10 to-slate-100 p-8 dark:from-cyan-600/30 dark:via-emerald-600/20 dark:to-slate-900 md:p-12 lg:p-16">
        <div className="absolute inset-0 bg-[url('/grid.svg')] opacity-10" />
        <div className="relative z-10 max-w-3xl">
          <p className="text-sm font-medium uppercase tracking-[0.2em] text-cyan-600 dark:text-cyan-300">
            Curated Health Products
          </p>
          <h1 className="mt-4 text-4xl font-bold tracking-tight text-slate-900 dark:text-white sm:text-5xl lg:text-6xl">
            Make informed choices for your{" "}
            <span className="bg-gradient-to-r from-cyan-500 to-emerald-500 bg-clip-text text-transparent dark:from-cyan-400 dark:to-emerald-400">
              wellness journey
            </span>
          </h1>
          <p className="mt-6 text-lg text-slate-600 dark:text-slate-300 sm:text-xl">
            We analyze ingredients, certifications, and value to bring you
            unbiased product comparisons. Every product is scored on a
            transparent 0-100 scale.
          </p>
          <div className="mt-8 flex flex-wrap gap-4">
            <Link
              href="/products"
              className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-6 py-3 font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
            >
              Browse Products
              <svg
                className="h-5 w-5"
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
              className="inline-flex items-center gap-2 rounded-full border border-slate-300 bg-white/50 px-6 py-3 font-semibold text-slate-700 backdrop-blur-sm transition-all hover:bg-white dark:border-white/20 dark:bg-white/5 dark:text-white dark:hover:bg-white/10"
            >
              Our Methodology
            </Link>
          </div>
        </div>

        {/* Decorative elements */}
        <div className="absolute -right-20 -top-20 h-64 w-64 rounded-full bg-cyan-500/20 blur-3xl" />
        <div className="absolute -bottom-20 -right-10 h-64 w-64 rounded-full bg-emerald-500/20 blur-3xl" />
      </section>

      {/* Features */}
      <section className="mt-16 grid gap-6 sm:grid-cols-3">
        {[
          {
            icon: (
              <svg
                className="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.5}
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z"
                />
              </svg>
            ),
            title: "Transparent Scoring",
            description:
              "Every product is evaluated on a clear 0-100 scale with detailed breakdowns.",
          },
          {
            icon: (
              <svg
                className="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.5}
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M9.75 3.104v5.714a2.25 2.25 0 01-.659 1.591L5 14.5M9.75 3.104c-.251.023-.501.05-.75.082m.75-.082a24.301 24.301 0 014.5 0m0 0v5.714c0 .597.237 1.17.659 1.591L19.8 15.3M14.25 3.104c.251.023.501.05.75.082M19.8 15.3l-1.57.393A9.065 9.065 0 0112 15a9.065 9.065 0 00-6.23.693L5 14.5m14.8.8l1.402 1.402c1.232 1.232.65 3.318-1.067 3.611A48.309 48.309 0 0112 21c-2.773 0-5.491-.235-8.135-.687-1.718-.293-2.3-2.379-1.067-3.61L5 14.5"
                />
              </svg>
            ),
            title: "Ingredient Analysis",
            description:
              "Deep dive into what's actually in your products and what to look for.",
          },
          {
            icon: (
              <svg
                className="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.5}
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                />
              </svg>
            ),
            title: "Value Comparison",
            description:
              "Find the best products at every price point with our value ratings.",
          },
        ].map((feature) => (
          <div
            key={feature.title}
            className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50"
          >
            <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-cyan-500/20 to-emerald-500/20 text-cyan-600 dark:text-cyan-400">
              {feature.icon}
            </div>
            <h3 className="mt-4 text-lg font-semibold text-slate-900 dark:text-white">
              {feature.title}
            </h3>
            <p className="mt-2 text-sm text-slate-600 dark:text-slate-400">
              {feature.description}
            </p>
          </div>
        ))}
      </section>

      {/* Featured Products */}
      <section className="mt-20">
        <div className="flex items-end justify-between">
          <div>
            <p className="text-sm font-medium uppercase tracking-wider text-cyan-600 dark:text-cyan-400">
              Top Rated
            </p>
            <h2 className="mt-2 text-3xl font-bold text-slate-900 dark:text-white">
              Featured Products
            </h2>
          </div>
          <Link
            href="/products"
            className="hidden items-center gap-1 text-sm font-medium text-slate-500 transition-colors hover:text-slate-900 dark:text-slate-400 dark:hover:text-white sm:flex"
          >
            View all products
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
        </div>
        <div className="mt-8 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {products.slice(0, 6).map((product) => (
            <ProductCard key={product.slug} product={product} />
          ))}
        </div>
        <div className="mt-8 text-center sm:hidden">
          <Link
            href="/products"
            className="inline-flex items-center gap-1 text-sm font-medium text-cyan-400"
          >
            View all products
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
        </div>
      </section>

      {/* Categories */}
      <section className="mt-20">
        <div className="flex items-end justify-between">
          <div>
            <p className="text-sm font-medium uppercase tracking-wider text-emerald-600 dark:text-emerald-400">
              Browse by
            </p>
            <h2 className="mt-2 text-3xl font-bold text-slate-900 dark:text-white">
              Categories
            </h2>
          </div>
          <Link
            href="/categories"
            className="hidden items-center gap-1 text-sm font-medium text-slate-500 transition-colors hover:text-slate-900 dark:text-slate-400 dark:hover:text-white sm:flex"
          >
            View all categories
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
        </div>
        <div className="mt-8 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {categories.slice(0, 6).map((category) => (
            <CategoryCard key={category.slug} category={category} />
          ))}
        </div>
      </section>

      {/* CTA Section */}
      <section className="mt-20 overflow-hidden rounded-3xl bg-gradient-to-r from-slate-100 via-slate-50 to-slate-100 p-8 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900 md:p-12">
        <div className="flex flex-col items-center text-center">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white sm:text-3xl">
            How do we evaluate products?
          </h2>
          <p className="mt-4 max-w-2xl text-slate-600 dark:text-slate-400">
            Our methodology is completely transparent. We evaluate products
            based on ingredients, certifications, third-party testing, and value
            for money. Learn exactly how we score each product.
          </p>
          <Link
            href="/methodology"
            className="mt-8 inline-flex items-center gap-2 rounded-full bg-slate-900 px-6 py-3 font-semibold text-white transition-all hover:bg-slate-800 dark:bg-white/10 dark:hover:bg-white/20"
          >
            Read Our Methodology
            <svg
              className="h-5 w-5"
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
        </div>
      </section>
    </div>
  );
}
