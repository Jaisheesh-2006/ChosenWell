import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { getProductBySlug, getProducts } from "../../lib/api";
import { Product } from "../../lib/types";
import Breadcrumbs from "../../components/Breadcrumbs";
import ScoreBadge from "../../components/ScoreBadge";
import TagBadge from "../../components/TagBadge";
import ProductClientWrapper from "../../components/ProductClientWrapper";

interface ProductPageProps {
  params: Promise<{ slug: string }>;
}

// Generate static params for products (SSG)
export async function generateStaticParams() {
  try {
    const products = await getProducts();
    return products.map((product) => ({
      slug: product.slug,
    }));
  } catch {
    return [];
  }
}

// Generate metadata for SEO
export async function generateMetadata({
  params,
}: ProductPageProps): Promise<Metadata> {
  const { slug } = await params;

  try {
    const product = await getProductBySlug(slug);
    return {
      title: `${product.name}${product.brand ? ` by ${product.brand}` : ""}`,
      description: `${product.name} review and analysis. Score: ${product.score}/100. ${product.why_recommended?.join(" ") || ""}`,
      openGraph: {
        title: `${product.name} | HealthIsWealth`,
        description: `${product.name} - Score: ${product.score}/100. Read our detailed analysis.`,
      },
    };
  } catch {
    return {
      title: "Product Not Found",
    };
  }
}

async function getProductData(slug: string): Promise<Product | null> {
  try {
    return await getProductBySlug(slug);
  } catch {
    return null;
  }
}

export default async function ProductPage({ params }: ProductPageProps) {
  const { slug } = await params;
  const product = await getProductData(slug);

  if (!product) {
    notFound();
  }

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs
        items={[
          { label: "Products", href: "/products" },
          ...(product.category
            ? [
                {
                  label:
                    product.category.charAt(0).toUpperCase() +
                    product.category.slice(1),
                  href: `/categories/${product.category}`,
                },
              ]
            : []),
          { label: product.name },
        ]}
      />

      {/* Product Header */}
      <header className="mb-12">
        <div className="flex flex-col gap-6 lg:flex-row lg:items-start lg:justify-between">
          <div className="flex-1">
            {product.brand && (
              <p className="text-sm font-medium uppercase tracking-wider text-slate-500">
                {product.brand}
              </p>
            )}
            <h1 className="mt-1 text-3xl font-bold tracking-tight text-slate-900 dark:text-white sm:text-4xl">
              {product.name}
            </h1>

            {/* Tags */}
            {product.tags && product.tags.length > 0 && (
              <div className="mt-4 flex flex-wrap gap-2">
                {product.tags.map((tag) => (
                  <TagBadge key={tag} tag={tag} />
                ))}
              </div>
            )}

            {/* Price */}
            {product.price_range && (
              <p className="mt-4 text-2xl font-semibold text-emerald-600 dark:text-emerald-400">
                {product.price_range}
              </p>
            )}
          </div>

          {/* Score */}
          <div className="flex-shrink-0">
            <ScoreBadge score={product.score} size="lg" />
          </div>
        </div>
      </header>

      <div className="grid gap-12 lg:grid-cols-3">
        {/* Main Content */}
        <div className="lg:col-span-2 space-y-10">
          {/* Why Recommended */}
          {product.why_recommended && product.why_recommended.length > 0 && (
            <section>
              <h2 className="flex items-center gap-2 text-xl font-semibold text-slate-900 dark:text-white">
                <svg
                  className="h-6 w-6 text-cyan-600 dark:text-cyan-400"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={1.5}
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M11.48 3.499a.562.562 0 011.04 0l2.125 5.111a.563.563 0 00.475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 00-.182.557l1.285 5.385a.562.562 0 01-.84.61l-4.725-2.885a.563.563 0 00-.586 0L6.982 20.54a.562.562 0 01-.84-.61l1.285-5.386a.562.562 0 00-.182-.557l-4.204-3.602a.563.563 0 01.321-.988l5.518-.442a.563.563 0 00.475-.345L11.48 3.5z"
                  />
                </svg>
                Why We Recommend It
              </h2>
              <ul className="mt-4 space-y-3">
                {product.why_recommended.map((reason, index) => (
                  <li key={index} className="flex items-start gap-3">
                    <svg
                      className="mt-0.5 h-5 w-5 flex-shrink-0 text-cyan-600 dark:text-cyan-400"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={2}
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M4.5 12.75l6 6 9-13.5"
                      />
                    </svg>
                    <span className="text-slate-600 dark:text-slate-300">{reason}</span>
                  </li>
                ))}
              </ul>
            </section>
          )}

          {/* Pros and Cons */}
          <div className="grid gap-6 sm:grid-cols-2">
            {/* Pros */}
            {product.pros && product.pros.length > 0 && (
              <section className="rounded-2xl border border-emerald-500/20 bg-emerald-500/5 p-6">
                <h3 className="flex items-center gap-2 font-semibold text-emerald-600 dark:text-emerald-400">
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
                      d="M4.5 12.75l6 6 9-13.5"
                    />
                  </svg>
                  Pros
                </h3>
                <ul className="mt-4 space-y-2">
                  {product.pros.map((pro, index) => (
                    <li key={index} className="text-sm text-slate-600 dark:text-slate-300">
                      • {pro}
                    </li>
                  ))}
                </ul>
              </section>
            )}

            {/* Cons */}
            {product.cons && product.cons.length > 0 && (
              <section className="rounded-2xl border border-amber-500/20 bg-amber-500/5 p-6">
                <h3 className="flex items-center gap-2 font-semibold text-amber-600 dark:text-amber-400">
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
                      d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"
                    />
                  </svg>
                  Cons
                </h3>
                <ul className="mt-4 space-y-2">
                  {product.cons.map((con, index) => (
                    <li key={index} className="text-sm text-slate-600 dark:text-slate-300">
                      • {con}
                    </li>
                  ))}
                </ul>
              </section>
            )}
          </div>

          {/* Ingredients Summary */}
          {product.ingredients_summary && (
            <section>
              <h2 className="flex items-center gap-2 text-xl font-semibold text-slate-900 dark:text-white">
                <svg
                  className="h-6 w-6 text-cyan-600 dark:text-cyan-400"
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
                Ingredients Analysis
              </h2>
              <div className="mt-4 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
                <p className="text-slate-600 dark:text-slate-300">{product.ingredients_summary}</p>
              </div>
            </section>
          )}
        </div>

        {/* Sidebar */}
        <aside className="space-y-6">
          {/* Buy Links */}
          {product.buy_links && product.buy_links.length > 0 && (
            <section className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
              <h3 className="font-semibold text-slate-900 dark:text-white">Where to Buy</h3>
              <div className="mt-4 space-y-3">
                {product.buy_links.map((link, index) => (
                  <a
                    key={index}
                    href={link.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="flex items-center justify-between rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 transition-colors hover:border-cyan-500/50 hover:bg-slate-100 dark:border-white/10 dark:bg-white/5 dark:hover:border-cyan-500/30 dark:hover:bg-white/10"
                  >
                    <span className="font-medium text-slate-900 dark:text-white">
                      {link.vendor || "Buy Now"}
                    </span>
                    <svg
                      className="h-5 w-5 text-slate-400"
                      fill="none"
                      viewBox="0 0 24 24"
                      strokeWidth={2}
                      stroke="currentColor"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21 3m0 0h-5.25M21 3v5.25"
                      />
                    </svg>
                  </a>
                ))}
              </div>
            </section>
          )}

          {/* Certifications */}
          {product.certifications && product.certifications.length > 0 && (
            <section className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
              <h3 className="font-semibold text-slate-900 dark:text-white">Certifications</h3>
              <div className="mt-4 flex flex-wrap gap-2">
                {product.certifications.map((cert) => (
                  <span
                    key={cert}
                    className="inline-flex items-center gap-1 rounded-full border border-emerald-500/30 bg-emerald-500/10 px-3 py-1 text-sm text-emerald-600 dark:text-emerald-400"
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
                        d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z"
                      />
                    </svg>
                    {cert}
                  </span>
                ))}
              </div>
            </section>
          )}

          {/* Last Reviewed */}
          {product.last_reviewed && (
            <section className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
              <h3 className="font-semibold text-slate-900 dark:text-white">Last Reviewed</h3>
              <p className="mt-2 text-slate-500 dark:text-slate-400">
                {new Date(product.last_reviewed).toLocaleDateString("en-US", {
                  year: "numeric",
                  month: "long",
                  day: "numeric",
                })}
              </p>
            </section>
          )}

          {/* Category Link */}
          {product.category && (
            <Link
              href={`/categories/${product.category}`}
              className="flex items-center justify-between rounded-2xl border border-slate-200 bg-white p-6 shadow-sm transition-colors hover:border-cyan-500/50 dark:border-white/10 dark:bg-slate-900/50 dark:hover:border-cyan-500/30"
            >
              <div>
                <p className="text-sm text-slate-500">Category</p>
                <p className="font-medium text-slate-900 dark:text-white">
                  {product.category.charAt(0).toUpperCase() +
                    product.category.slice(1)}
                </p>
              </div>
              <svg
                className="h-5 w-5 text-slate-400"
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
          )}
        </aside>
      </div>

      {/* Structured Data for SEO */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "Product",
            name: product.name,
            brand: product.brand
              ? {
                  "@type": "Brand",
                  name: product.brand,
                }
              : undefined,
            review: {
              "@type": "Review",
              reviewRating: {
                "@type": "Rating",
                ratingValue: product.score,
                bestRating: 100,
              },
              author: {
                "@type": "Organization",
                name: "HealthIsWealth",
              },
            },
          }),
        }}
      />

      {/* Client-side components: Similar products, Recently viewed, and tracking */}
      <ProductClientWrapper
        product={{
          slug: product.slug,
          name: product.name,
          brand: product.brand,
          score: product.score,
          short_reason: product.why_recommended?.[0],
          price_range: product.price_range,
        }}
        slug={product.slug}
      />
    </div>
  );
}
