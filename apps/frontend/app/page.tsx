import Link from "next/link";
import { getCategories, getProducts } from "./lib/api";
import { CategorySummary, ProductSummary } from "./lib/types";
import ProductCard from "./components/ProductCard";
import { Droplets, Sun, Droplet, Sparkles, Smile, Tag, HelpCircle, ClipboardList, BookOpen, Search, FolderOpen, MessageCircle } from "lucide-react";

// ISR: Revalidate home page every 60 seconds
export const revalidate = 60;

async function getFeaturedProducts(
  categories: CategorySummary[],
  allProducts: ProductSummary[]
): Promise<ProductSummary[]> {
  const featured: ProductSummary[] = [];
  const usedSlugs = new Set<string>();

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
      getProducts({ limit: 50 }),
      getCategories(),
    ]);

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
    <div>
      {/* ==================== HERO ==================== */}
      <section className="relative overflow-hidden bg-gradient-to-br from-hero-start via-hero-end to-primary-light">
        {/* Decorative elements */}
        <div className="absolute inset-0">
          <div className="absolute -right-32 -top-32 h-96 w-96 rounded-full bg-accent/10 blur-3xl" />
          <div className="absolute -bottom-20 -left-20 h-72 w-72 rounded-full bg-white/5 blur-3xl" />
          <div className="absolute right-1/4 top-1/3 h-48 w-48 rounded-full bg-primary-light/20 blur-3xl animate-float" />
          {/* Grid pattern */}
          <div className="absolute inset-0 bg-[url('/grid.svg')] opacity-[0.04]" />
        </div>

        <div className="relative z-10 mx-auto max-w-7xl px-4 py-20 sm:px-6 sm:py-28 lg:px-8 lg:py-36 flex justify-center">
          <div className="max-w-4xl text-center flex flex-col items-center">
            {/* Copy */}
            <div className="inline-flex items-center justify-center gap-2 rounded-full border border-white/15 bg-white/10 px-4 py-1.5 text-xs font-semibold uppercase tracking-[0.2em] text-accent backdrop-blur-sm">
              <span className="h-1.5 w-1.5 rounded-full bg-accent animate-pulse-slow" />
              Evaluation-First Platform
            </div>

            <h1 className="mt-6 font-display text-4xl tracking-tight text-white sm:text-5xl lg:text-6xl lg:leading-[1.1]">
              Only Products That{" "}
              <span className="text-accent">
                Meet Our Standards
              </span>{" "}
              Appear Here
            </h1>

            <p className="mt-6 text-lg text-white/70 sm:text-xl leading-relaxed mx-auto max-w-2xl">
              We evaluate <strong className="text-white font-medium">Indian daily-use products</strong> using a
              strict, repeatable methodology. Products that do not meet minimum
              safety and transparency thresholds are excluded from our listings.
            </p>

            <p className="mt-4 text-sm text-white/40">
              <strong className="font-medium text-white/60">
                Not a marketplace. Not sponsored rankings.
              </strong>{" "}
              An evaluation-first filter for Indian consumers.
            </p>

            <div className="mt-10 flex justify-center">
              <Link
                href="/categories"
                className="inline-flex items-center gap-2 rounded-full bg-accent px-7 py-3.5 font-semibold text-hero-start shadow-lg shadow-accent/25 transition-all duration-200 hover:bg-accent/90 hover:shadow-xl hover:shadow-accent/30 hover:-translate-y-0.5 active:scale-[0.97]"
              >
                Browse Evaluated Products
                <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" strokeWidth={2.5} stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
                </svg>
              </Link>
            </div>
          </div>
        </div>

        {/* Bottom fade */}
        <div className="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-background to-transparent" />
      </section>

      {/* ==================== CATEGORY STRIP ==================== */}
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <nav
          aria-label="Primary categories"
          className="relative -mt-7 z-20"
        >
          <div className="rounded-2xl border border-border bg-surface-raised p-4 shadow-lg">
            <div className="flex flex-wrap items-center justify-center gap-2.5">
              <span className="text-sm font-medium text-text-muted mr-1">
                Explore by category:
              </span>
              {[
                { label: "Shampoo", icon: <Droplets className="w-4 h-4" />, href: "/categories/shampoo" },
                { label: "Sunscreen", icon: <Sun className="w-4 h-4" />, href: "/categories/sunscreen" },
                { label: "Hair Oil", icon: <Droplet className="w-4 h-4" />, href: "/categories/hair_oil" },
                { label: "Soap", icon: <Sparkles className="w-4 h-4" />, href: "/categories/soap" },
                { label: "Toothpaste", icon: <Smile className="w-4 h-4" />, href: "/categories/toothpaste" },
              ].map((cat) => (
                <Link
                  key={cat.href}
                  href={cat.href}
                  className="flex items-center gap-1.5 rounded-full border border-border bg-surface px-4 py-2 text-sm font-medium text-text-muted transition-all duration-200 hover:border-primary/30 hover:bg-primary-lighter hover:text-primary hover:shadow-sm"
                >
                  {cat.icon}
                  {cat.label}
                </Link>
              ))}
              <Link
                href="/categories"
                className="rounded-full bg-primary-lighter px-4 py-2 text-sm font-semibold text-primary transition-all duration-200 hover:bg-primary/10 hover:shadow-sm"
              >
                View all categories →
              </Link>
            </div>
          </div>
        </nav>
      </div>

      {/* ==================== PROCESS STEPS ==================== */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-24">
        <div className="text-center mb-16">
          <p className="section-label">
            Process-Based Evaluation
          </p>
          <h2 className="mt-3 font-display text-3xl text-text sm:text-4xl">
            How ChosenWell Evaluates Products
          </h2>
          <p className="mt-4 max-w-2xl mx-auto text-text-muted">
            Our methodology is rule-based and repeatable. Every product goes
            through the same evaluation process — no exceptions, no
            sponsorships.
          </p>
        </div>

        {/* Timeline-style steps with connecting line */}
        <div className="relative">
          {/* Connecting line (desktop only) */}
          <div className="hidden lg:block absolute top-1/2 left-[8%] right-[8%] h-px bg-gradient-to-r from-transparent via-border-strong to-transparent -translate-y-1/2" />

          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            {[
              {
                step: "01",
                title: "Ingredient Review",
                description:
                  "Full INCI list analysis. Products with hidden ingredients or vague 'Base Q.S.' labels are not listed.",
                icon: (
                  <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M9.75 3.104v5.714a2.25 2.25 0 01-.659 1.591L5 14.5M9.75 3.104c-.251.023-.501.05-.75.082m.75-.082a24.301 24.301 0 014.5 0m0 0v5.714c0 .597.237 1.17.659 1.591L19.8 15.3M14.25 3.104c.251.023.501.05.75.082M19.8 15.3l-1.57.393A9.065 9.065 0 0112 15a9.065 9.065 0 00-6.23.693L5 14.5m14.8.8l1.402 1.402c1.232 1.232.65 3.318-1.067 3.611A48.309 48.309 0 0112 21c-2.773 0-5.491-.235-8.135-.687-1.718-.293-2.3-2.379-1.067-3.61L5 14.5" />
                  </svg>
                ),
              },
              {
                step: "02",
                title: "Regulatory Alignment",
                description:
                  "Verification against FSSAI, BIS, and other Indian regulatory standards where applicable.",
                icon: (
                  <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M9 12.75L11.25 15 15 9.75m-3-7.036A11.959 11.959 0 013.598 6 11.99 11.99 0 003 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285z" />
                  </svg>
                ),
              },
              {
                step: "03",
                title: "Label Transparency",
                description:
                  "Claims must match formulation. Products with misleading marketing are excluded from listings.",
                icon: (
                  <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z" />
                    <path strokeLinecap="round" strokeLinejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                  </svg>
                ),
              },
              {
                step: "04",
                title: "Daily-Use Risk Context",
                description:
                  "Long-term safety considerations for products used regularly. No dependency-inducing formulations.",
                icon: (
                  <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                ),
              },
            ].map((item, index) => (
              <div
                key={item.step}
                className="card relative overflow-hidden p-6 group hover:border-primary-light/30 hover:shadow-card-hover hover:-translate-y-1 transition-all duration-300"
              >
                {/* Accent top border */}
                <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-primary to-accent opacity-0 group-hover:opacity-100 transition-opacity duration-300" />

                {/* Decorative watermark number */}
                <span className="pointer-events-none absolute right-3 top-2 select-none text-[80px] font-bold leading-none text-primary/[0.04]">
                  {item.step}
                </span>

                <div className="relative">
                  {/* Icon with gradient background */}
                  <div className="mb-5 flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-primary-lighter to-primary/10 text-primary ring-1 ring-primary/10">
                    {item.icon}
                  </div>

                  {/* Step counter */}
                  <div className="mb-3 flex items-center gap-2">
                    <span className="flex h-6 w-6 items-center justify-center rounded-full bg-accent/15 text-[10px] font-bold text-accent">
                      {item.step}
                    </span>
                    <div className="h-px flex-1 bg-border" />
                  </div>

                  <h3 className="text-base font-semibold text-text">
                    {item.title}
                  </h3>
                  <p className="mt-2 text-sm leading-relaxed text-text-muted">
                    {item.description}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="mt-10 text-center">
          <Link
            href="/methodology"
            className="inline-flex items-center gap-2 rounded-full border border-border bg-surface-raised px-6 py-2.5 text-sm font-medium text-primary shadow-sm transition-all duration-200 hover:border-primary/30 hover:shadow-md hover:-translate-y-0.5"
          >
            Read our full evaluation methodology
            <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
            </svg>
          </Link>
        </div>
      </section>

      {/* ==================== FEATURED PRODUCTS ==================== */}
      <section className="mt-24 relative">
        {/* Subtle background break */}
        <div className="absolute inset-0 bg-gradient-to-b from-transparent via-surface/50 to-transparent pointer-events-none" />

        <div className="relative mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-16">
          <div className="flex items-end justify-between mb-10">
            <div>
              <p className="section-label">
                Across Categories
              </p>
              <h2 className="mt-3 font-display text-3xl text-text sm:text-4xl">
                Featured Products
              </h2>
              <p className="mt-3 max-w-lg text-text-muted text-sm">
                A curated selection of products that have passed our evaluation process across multiple categories.
              </p>
            </div>
            <Link
              href="/products"
              className="hidden items-center gap-1.5 rounded-full border border-border bg-surface-raised px-5 py-2.5 text-sm font-medium text-text-muted shadow-sm transition-all duration-200 hover:text-primary hover:border-primary/30 hover:shadow-md sm:flex"
            >
              View all products
              <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
              </svg>
            </Link>
          </div>

          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {products.slice(0, 6).map((product) => (
              <ProductCard key={product.slug} product={product} />
            ))}
          </div>

          <div className="mt-8 text-center sm:hidden">
            <Link
              href="/products"
              className="inline-flex items-center gap-1 text-sm font-medium text-primary"
            >
              View all products
              <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
              </svg>
            </Link>
          </div>
        </div>
      </section>

      {/* ==================== LEARN SECTION ==================== */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-12">
        <div className="text-center mb-14">
          <p className="section-label">
            Before You Buy
          </p>
          <h2 className="mt-3 font-display text-3xl text-text sm:text-4xl">
            Understand This First
          </h2>
          <p className="mt-4 max-w-2xl mx-auto text-text-muted">
            Labels and marketing can be confusing. These guides help you
            understand what actually matters when evaluating products like{" "}
            <Link href="/categories/shampoo" className="text-primary hover:underline">shampoos</Link>{" "}
            and{" "}
            <Link href="/categories/sunscreen" className="text-primary hover:underline">sunscreens</Link>.
          </p>
        </div>

        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {[
            {
              category: "Marketing Claims",
              title: "What 'Dermatologically Tested' Actually Means",
              excerpt: "This common claim doesn't mean what most consumers think. Learn what testing actually involves.",
              href: "/learn/dermatologically-tested-meaning",
              readTime: "3 min",
              color: "bg-rose-50 text-rose-700 border-rose-200",
              icon: <Tag className="w-6 h-6" />,
            },
            {
              category: "Common Questions",
              title: "Are Preservatives Always Bad?",
              excerpt: "A balanced look at preservatives: when they're necessary and when to be cautious.",
              href: "/learn/preservatives-daily-products",
              readTime: "4 min",
              color: "bg-amber-50 text-amber-700 border-amber-200",
              icon: <HelpCircle className="w-6 h-6" />,
            },
            {
              category: "Certifications",
              title: "What FSSAI Certification Actually Guarantees",
              excerpt: "Understanding the scope and limitations of India's food safety certification.",
              href: "/learn/fssai-certification-explained",
              readTime: "4 min",
              color: "bg-primary-lighter text-primary border-primary/20",
              icon: <ClipboardList className="w-6 h-6" />,
            },
          ].map((article) => (
            <Link
              key={article.href}
              href={article.href}
              className="card group p-6 transition-all duration-300 hover:shadow-card-hover hover:border-primary-light/30 hover:-translate-y-1 flex flex-col"
            >
              <div className="flex items-start justify-between mb-4">
                <span className={`inline-block text-xs font-semibold px-2.5 py-1 rounded-full border ${article.color}`}>
                  {article.category}
                </span>
                <span className="text-text-muted group-hover:text-primary transition-colors duration-200">{article.icon}</span>
              </div>
              <h3 className="text-lg font-semibold text-text group-hover:text-primary transition-colors duration-200 leading-snug">
                {article.title}
              </h3>
              <p className="mt-3 text-sm text-text-muted leading-relaxed flex-1">
                {article.excerpt}
              </p>
              <div className="mt-5 flex items-center justify-between pt-4 border-t border-border">
                <p className="text-xs text-text-muted flex items-center gap-1.5">
                  <svg className="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  {article.readTime}
                </p>
                <span className="text-xs font-medium text-primary flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity duration-200">
                  Read article
                  <svg className="h-3 w-3" fill="none" viewBox="0 0 24 24" strokeWidth={2.5} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
                  </svg>
                </span>
              </div>
            </Link>
          ))}
        </div>

        <div className="mt-10 text-center">
          <Link
            href="/learn"
            className="inline-flex items-center gap-2 text-sm font-medium text-primary transition-colors duration-200 hover:text-primary-light"
          >
            Explore all educational content
            <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
            </svg>
          </Link>
        </div>
      </section>

      {/* ==================== CTA / FINAL SECTION ==================== */}
      <section className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 mt-24 mb-16">
        <div className="overflow-hidden rounded-3xl bg-gradient-to-br from-hero-start via-hero-end to-primary-light relative">
          {/* Decorative elements */}
          <div className="absolute -right-20 -top-20 h-80 w-80 rounded-full bg-accent/10 blur-3xl" />
          <div className="absolute -left-16 -bottom-16 h-64 w-64 rounded-full bg-white/5 blur-3xl" />
          <div className="absolute right-1/3 bottom-0 h-40 w-40 rounded-full bg-primary-light/15 blur-3xl animate-float" />

          <div className="relative z-10 grid lg:grid-cols-2 gap-8">
            {/* Left — Primary CTA */}
            <div className="p-10 md:p-14 lg:p-16 flex flex-col justify-center">
              <div className="inline-flex items-center gap-2 w-fit rounded-full border border-white/15 bg-white/10 px-3 py-1 text-xs font-semibold uppercase tracking-[0.15em] text-accent backdrop-blur-sm mb-6">
                Our Promise
              </div>
              <h2 className="text-2xl font-display text-white sm:text-3xl lg:text-4xl leading-tight">
                An evaluation-first filter, not a marketplace
              </h2>
              <p className="mt-5 text-white/60 leading-relaxed">
                ChosenWell exists to help Indian consumers navigate product choices
                using transparent, repeatable evaluation criteria. Products that meet
                our standards are shown. Products that don&apos;t meet standards are
                excluded.
              </p>
              <div className="mt-8 flex flex-wrap gap-4">
                <Link href="/products" className="inline-flex items-center gap-2 rounded-full bg-accent px-7 py-3.5 font-semibold text-hero-start shadow-lg shadow-accent/20 transition-all duration-200 hover:bg-accent/90 hover:shadow-xl active:scale-[0.97]">
                  Browse Evaluated Products
                  <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
                  </svg>
                </Link>
                <Link href="/methodology" className="inline-flex items-center gap-2 rounded-full border border-white/20 bg-white/10 px-7 py-3.5 font-semibold text-white transition-all duration-200 hover:bg-white/20 active:scale-[0.97]">
                  Read Our Methodology
                </Link>
              </div>
            </div>

            {/* Right — Questions & Resources */}
            <div className="p-10 md:p-14 lg:p-16 border-t lg:border-t-0 lg:border-l border-white/10 flex flex-col justify-center">
              <h3 className="text-xl font-display text-white sm:text-2xl">
                Still have questions about how products are evaluated?
              </h3>
              <p className="mt-4 text-white/50 text-sm leading-relaxed">
                Our methodology is transparent and repeatable. Learn exactly what we
                check before a product appears on ChosenWell, or explore our
                educational content to better understand ingredient labels and
                certifications.
              </p>
              <p className="mt-3 text-sm text-white/40">
                This methodology applies across all{" "}
                <Link href="/categories" className="text-accent hover:underline">product categories</Link>{" "}
                we evaluate.
              </p>
              <div className="mt-8 grid grid-cols-2 gap-3">
                {[
                  { label: "Learn Section", href: "/learn", icon: <BookOpen className="w-5 h-5" /> },
                  { label: "Our Methodology", href: "/methodology", icon: <Search className="w-5 h-5" /> },
                  { label: "All Categories", href: "/categories", icon: <FolderOpen className="w-5 h-5" /> },
                  { label: "Contact Us", href: "/contact", icon: <MessageCircle className="w-5 h-5" /> },
                ].map((item) => (
                  <Link
                    key={item.href}
                    href={item.href}
                    className="flex items-center gap-2.5 rounded-xl border border-white/10 bg-white/[0.06] px-4 py-3 text-sm font-medium text-white/80 transition-all duration-200 hover:bg-white/[0.12] hover:text-white hover:border-white/20 group"
                  >
                    <span className="text-white/70 group-hover:text-white transition-colors duration-200 flex-shrink-0">{item.icon}</span>
                    {item.label}
                  </Link>
                ))}
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
