import Link from "next/link";
import { getCategories, getProducts } from "./lib/api";
import { CategorySummary, ProductSummary } from "./lib/types";
import ProductCard from "./components/ProductCard";
import CategoryCard from "./components/CategoryCard";

// ISR: Revalidate home page every 60 seconds
export const revalidate = 60;

/**
 * Get featured products that cover all available categories.
 * This ensures users see the diversity of products on the platform.
 */
async function getFeaturedProducts(
  categories: CategorySummary[],
  allProducts: ProductSummary[]
): Promise<ProductSummary[]> {
  const featured: ProductSummary[] = [];
  const usedSlugs = new Set<string>();

  // First pass: Get one product from each category
  for (const category of categories) {
    const categoryProduct = allProducts.find(
      (p) =>
        p.tags?.concern?.some((c) =>
          category.slug.toLowerCase().includes(c.toLowerCase())
        ) ||
        category.slug.toLowerCase().includes(p.slug.split("-")[0]) ||
        p.slug.toLowerCase().includes(category.slug.replace(/_/g, "-"))
    );

    if (categoryProduct && !usedSlugs.has(categoryProduct.slug)) {
      featured.push(categoryProduct);
      usedSlugs.add(categoryProduct.slug);
    }

    if (featured.length >= 6) break;
  }

  // Second pass: If we don't have 6 yet, add more products not already included
  if (featured.length < 6) {
    for (const product of allProducts) {
      if (!usedSlugs.has(product.slug)) {
        featured.push(product);
        usedSlugs.add(product.slug);
      }
      if (featured.length >= 6) break;
    }
  }

  return featured;
}

async function getHomePageData() {
  try {
    const [allProducts, categories] = await Promise.all([
      getProducts({ limit: 50 }), // Fetch more to have variety
      getCategories(),
    ]);

    // Get diverse featured products across categories
    const featuredProducts = await getFeaturedProducts(categories, allProducts);

    return {
      products: featuredProducts,
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
      {/* Hero Section - Trust-Focused Messaging */}
      <section className="relative overflow-hidden rounded-3xl bg-gradient-to-br from-cyan-600/20 via-emerald-600/10 to-slate-100 p-8 dark:from-cyan-600/30 dark:via-emerald-600/20 dark:to-slate-900 md:p-12 lg:p-16">
        <div className="absolute inset-0 bg-[url('/grid.svg')] opacity-10" />
        <div className="relative z-10 max-w-3xl">
          <h1 className="text-3xl font-bold tracking-tight text-slate-900 dark:text-white sm:text-4xl lg:text-5xl">
            Only Products That{" "}
            <span className="bg-gradient-to-r from-cyan-500 to-emerald-500 bg-clip-text text-transparent dark:from-cyan-400 dark:to-emerald-400">
              Meet Our Standards
            </span>{" "}
            Appear Here
          </h1>
          <p className="mt-6 text-lg text-slate-600 dark:text-slate-300 sm:text-xl">
            We evaluate <strong>Indian daily-use products </strong> using a
            strict, repeatable methodology. Products that do not meet minimum
            safety and transparency thresholds are excluded from our listings.
          </p>
          <p className="mt-4 text-sm text-slate-500 dark:text-slate-400">
            <strong className="font-semibold text-slate-700 dark:text-slate-300">
              Not a marketplace. Not sponsored rankings.
            </strong>{" "}
            An evaluation-first filter for Indian consumers.
          </p>
          <div className="mt-8 flex flex-wrap gap-4">
            <Link
              href="/categories"
              className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-6 py-3 font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
            >
              Browse Evaluated Products
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
              See Our Evaluation Criteria
            </Link>
          </div>
        </div>

        {/* Decorative elements */}
        <div className="absolute -right-20 -top-20 h-64 w-64 rounded-full bg-cyan-500/20 blur-3xl" />
        <div className="absolute -bottom-20 -right-10 h-64 w-64 rounded-full bg-emerald-500/20 blur-3xl" />
      </section>

      {/* How ChosenWell Evaluates Products - System-First Credibility */}
      <section className="mt-16">
        <div className="text-center mb-10">
          <p className="text-sm font-medium uppercase tracking-wider text-cyan-600 dark:text-cyan-400">
            Process-Based Evaluation
          </p>
          <h2 className="mt-2 text-3xl font-bold text-slate-900 dark:text-white">
            How ChosenWell Evaluates Products
          </h2>
          <p className="mt-4 max-w-2xl mx-auto text-slate-600 dark:text-slate-400">
            Our methodology is rule-based and repeatable. Every product goes
            through the same evaluation process — no exceptions, no
            sponsorships.
          </p>
        </div>

        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {[
            {
              step: "01",
              title: "Ingredient Review",
              description:
                "Full INCI list analysis. Products with hidden ingredients or vague 'Base Q.S.' labels are not listed.",
            },
            {
              step: "02",
              title: "Regulatory Alignment",
              description:
                "Verification against FSSAI, BIS, and other Indian regulatory standards where applicable.",
            },
            {
              step: "03",
              title: "Label Transparency",
              description:
                "Claims must match formulation. Products with misleading marketing are excluded from listings.",
            },
            {
              step: "04",
              title: "Daily-Use Risk Context",
              description:
                "Long-term safety considerations for products used regularly. No dependency-inducing formulations.",
            },
          ].map((item) => (
            <div
              key={item.step}
              className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50"
            >
              <div className="mb-4">
                <span className="text-sm font-bold text-cyan-600 dark:text-cyan-400 bg-cyan-100 dark:bg-cyan-900/30 px-3 py-1.5 rounded-full">
                  {item.step}
                </span>
              </div>
              <h3 className="text-lg font-semibold text-slate-900 dark:text-white">
                {item.title}
              </h3>
              <p className="mt-2 text-sm text-slate-600 dark:text-slate-400">
                {item.description}
              </p>
            </div>
          ))}
        </div>

        <div className="mt-8 text-center">
          <Link
            href="/methodology"
            className="inline-flex items-center gap-2 text-sm font-medium text-cyan-600 dark:text-cyan-400 hover:text-cyan-700 dark:hover:text-cyan-300"
          >
            Read our full evaluation methodology
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

      {/* Trust Signals - What Makes Us Different */}
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
                  d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"
                />
              </svg>
            ),
            title: "Strict Inclusion Criteria",
            description:
              "Only products meeting our evaluation criteria are shown. Products that don't meet standards are excluded from listings.",
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
                  d="M3.75 3v11.25A2.25 2.25 0 006 16.5h2.25M3.75 3h-1.5m1.5 0h16.5m0 0h1.5m-1.5 0v11.25A2.25 2.25 0 0118 16.5h-2.25m-7.5 0h7.5m-7.5 0l-1 3m8.5-3l1 3m0 0l.5 1.5m-.5-1.5h-9.5m0 0l-.5 1.5m.75-9l3-3 2.148 2.148A12.061 12.061 0 0116.5 7.605"
                />
              </svg>
            ),
            title: "Repeatable Methodology",
            description:
              "Same rules apply to every product. No sponsored placements, no paid rankings, no exceptions.",
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
                  d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z"
                />
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z"
                />
              </svg>
            ),
            title: "India-Focused Standards",
            description:
              "Evaluation considers FSSAI, BIS, and regulations relevant to Indian consumers and market conditions.",
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

      {/* Learn-First Section - Before You Buy, Understand This */}
      <section className="mt-20">
        <div className="text-center mb-10">
          <p className="text-sm font-medium uppercase tracking-wider text-emerald-600 dark:text-emerald-400">
            Before You Buy
          </p>
          <h2 className="mt-2 text-3xl font-bold text-slate-900 dark:text-white">
            Understand This First
          </h2>
          <p className="mt-4 max-w-2xl mx-auto text-slate-600 dark:text-slate-400">
            Labels and marketing can be confusing. These guides help you
            understand what actually matters when evaluating products.
          </p>
        </div>

        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {[
            {
              category: "Marketing Claims",
              title: "What 'Dermatologically Tested' Actually Means",
              excerpt:
                "This common claim doesn't mean what most consumers think. Learn what testing actually involves.",
              href: "/learn/dermatologically-tested-meaning",
              readTime: "3 min",
            },
            {
              category: "Common Questions",
              title: "Are Preservatives Always Bad?",
              excerpt:
                "A balanced look at preservatives: when they're necessary and when to be cautious.",
              href: "/learn/preservatives-daily-products",
              readTime: "4 min",
            },
            {
              category: "Certifications",
              title: "What FSSAI Certification Actually Guarantees",
              excerpt:
                "Understanding the scope and limitations of India's food safety certification.",
              href: "/learn/fssai-certification-explained",
              readTime: "4 min",
            },
          ].map((article) => (
            <Link
              key={article.href}
              href={article.href}
              className="group rounded-2xl border border-slate-200 bg-white p-6 shadow-sm transition-all hover:shadow-md hover:border-emerald-200 dark:border-white/10 dark:bg-slate-900/50 dark:hover:border-emerald-800/30"
            >
              <span className="inline-block text-xs font-medium text-emerald-600 dark:text-emerald-400 bg-emerald-100 dark:bg-emerald-900/30 px-2 py-1 rounded mb-3">
                {article.category}
              </span>
              <h3 className="text-lg font-semibold text-slate-900 dark:text-white group-hover:text-emerald-600 dark:group-hover:text-emerald-400 transition-colors">
                {article.title}
              </h3>
              <p className="mt-2 text-sm text-slate-600 dark:text-slate-400">
                {article.excerpt}
              </p>
              <p className="mt-4 text-xs text-slate-500 dark:text-slate-500 flex items-center gap-1">
                <svg
                  className="h-3.5 w-3.5"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={2}
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z"
                  />
                </svg>
                {article.readTime}
              </p>
            </Link>
          ))}
        </div>

        <div className="mt-8 text-center">
          <Link
            href="/learn"
            className="inline-flex items-center gap-2 text-sm font-medium text-emerald-600 dark:text-emerald-400 hover:text-emerald-700 dark:hover:text-emerald-300"
          >
            Explore all educational content
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

      {/* Featured Products */}
      <section className="mt-20">
        <div className="flex items-end justify-between">
          <div>
            <p className="text-sm font-medium uppercase tracking-wider text-cyan-600 dark:text-cyan-400">
              Across Categories
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

      {/* CTA Section - Why We Exist */}
      <section className="mt-20 overflow-hidden rounded-3xl bg-gradient-to-r from-slate-100 via-slate-50 to-slate-100 p-8 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900 md:p-12">
        <div className="flex flex-col items-center text-center">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white sm:text-3xl">
            Still have questions about how products are evaluated?
          </h2>
          <p className="mt-4 max-w-2xl text-slate-600 dark:text-slate-400">
            Our methodology is transparent and repeatable. Learn exactly what we
            check before a product appears on ChosenWell, or explore our
            educational content to better understand ingredient labels and
            certifications.
          </p>
          <div className="mt-8 flex flex-wrap justify-center gap-4">
            <Link
              href="/methodology"
              className="inline-flex items-center gap-2 rounded-full bg-slate-900 px-6 py-3 font-semibold text-white transition-all hover:bg-slate-800 dark:bg-white/10 dark:hover:bg-white/20"
            >
              See Our Methodology
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
              href="/learn"
              className="inline-flex items-center gap-2 rounded-full border border-slate-300 bg-white/80 px-6 py-3 font-semibold text-slate-900 backdrop-blur-sm transition-all hover:bg-slate-100 dark:border-white/20 dark:bg-white/5 dark:text-white dark:hover:bg-white/10"
            >
              Explore Learn Section
            </Link>
          </div>
        </div>
      </section>

      {/* Final Trust Statement */}
      <section className="mt-20 rounded-2xl bg-gradient-to-r from-cyan-500/10 via-emerald-500/10 to-cyan-500/10 p-8 text-center dark:from-cyan-500/5 dark:via-emerald-500/5 dark:to-cyan-500/5">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          An evaluation-first filter, not a marketplace
        </h2>
        <p className="mt-4 max-w-2xl mx-auto text-slate-600 dark:text-slate-400">
          ChosenWell exists to help Indian consumers navigate product choices
          using transparent, repeatable evaluation criteria. Products that meet
          our standards are shown. Products that don&apos;t meet standards are
          excluded.
        </p>
        <div className="mt-6 flex flex-wrap justify-center gap-4">
          <Link
            href="/products"
            className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-6 py-3 font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
          >
            Browse Evaluated Products
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
            className="inline-flex items-center gap-2 rounded-full border border-slate-300 bg-white/80 px-6 py-3 font-semibold text-slate-900 backdrop-blur-sm transition-all hover:bg-slate-100 dark:border-white/20 dark:bg-white/5 dark:text-white dark:hover:bg-white/10"
          >
            Read Our Methodology
          </Link>
        </div>
      </section>
    </div>
  );
}
