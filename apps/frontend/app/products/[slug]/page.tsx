import type { Metadata } from "next";
import Link from "next/link";
import Image from "next/image";
import { notFound } from "next/navigation";
import {
  getProductBySlug,
  getProducts,
  getCategoryBySlug,
} from "../../lib/api";
import { Product, ProductSummary } from "../../lib/types";
import Breadcrumbs from "../../components/Breadcrumbs";
import TagBadge from "../../components/TagBadge";
import ProductClientWrapper from "../../components/ProductClientWrapper";

interface ProductPageProps {
  params: Promise<{ slug: string }>;
}

// Allow dynamic params for products not pre-generated
export const dynamicParams = true;

// Revalidate pages every 5 minutes
export const revalidate = 300;

// Generate static params for products (SSG)
export async function generateStaticParams() {
  try {
    const products = await getProducts({ limit: 200 });
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
  const product = await getProductData(slug);

  if (!product) {
    return { title: "Product Not Found" };
  }

  const title = `${product.name}${
    product.brand ? ` by ${product.brand}` : ""
  } - Review & Analysis`;
  const description = `${product.name} review and analysis. ${
    product.why_recommended?.slice(0, 2).join(" ") ||
    "Verified health product for everyday use in India."
  }`.substring(0, 160);

  return {
    title,
    description,
    alternates: {
      canonical: `/products/${slug}`,
    },
    openGraph: {
      title: `${product.name} | ChosenWell`,
      description: `${product.name} - Read our detailed ingredient and safety analysis.`,
      url: `/products/${slug}`,
      type: "article",
      images: product.image_url
        ? [{ url: product.image_url, alt: product.name }]
        : undefined,
    },
  };
}

async function getProductData(slug: string): Promise<Product | null> {
  try {
    return await getProductBySlug(slug);
  } catch {
    return null;
  }
}

/**
 * Get related products from the same category (server-side, SEO-friendly)
 * Excludes the current product and limits to 3 products
 */
async function getRelatedProducts(
  categorySlug: string | undefined,
  currentProductSlug: string
): Promise<ProductSummary[]> {
  if (!categorySlug) return [];

  try {
    const category = await getCategoryBySlug(categorySlug);
    if (!category.curated_products) return [];

    // Filter out current product and limit to 3
    return category.curated_products
      .filter((p) => p.slug !== currentProductSlug)
      .slice(0, 3);
  } catch {
    return [];
  }
}

export default async function ProductPage({ params }: ProductPageProps) {
  const { slug } = await params;
  const product = await getProductData(slug);

  if (!product) {
    notFound();
  }

  // Fetch related products server-side for SEO
  const relatedProducts = await getRelatedProducts(product.category, slug);

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs
        items={[
          { label: "Products", href: "/products" },
          ...(product.category
            ? [
                {
                  label: product.category
                    .replace(/_/g, " ")
                    .replace(/\b\w/g, (c) => c.toUpperCase()),
                  href: `/categories/${product.category}`,
                },
              ]
            : []),
          { label: product.name },
        ]}
      />

      {/* Product Header */}
      <header className="mb-12">
        <div className="flex flex-col gap-8 lg:flex-row lg:items-start">
          {/* Product Image */}
          {product.image_url && (
            <div className="relative h-72 w-full lg:h-80 lg:w-80 flex-shrink-0 rounded-2xl border border-border bg-white shadow-sm overflow-hidden">
              <Image
                src={product.image_url}
                alt={product.name}
                fill
                className="object-contain p-6"
                sizes="(max-width: 1024px) 100vw, 320px"
                priority
              />
            </div>
          )}

          <div className="flex flex-1 flex-col gap-6 lg:flex-row lg:items-start lg:justify-between">
            <div className="flex-1">
              {product.brand && (
                <p className="text-sm font-medium uppercase tracking-wider text-text-muted">
                  {product.brand}
                </p>
              )}
              <h1 className="mt-1 text-3xl font-bold tracking-tight text-text sm:text-4xl">
                {product.name}
              </h1>

              {/* SEO: Product evaluation summary - unique per product, visible above fold */}
              <p className="mt-4 text-text-muted">
                {product.why_recommended?.[0] ||
                  `This ${
                    product.category?.replace(/_/g, " ") || "product"
                  } has been evaluated for ingredient safety, formulation quality, and transparency.`}{" "}
                It appears on ChosenWell because it passed our verification
                standards
                {product.category
                  ? ` for ${product.category.replace(/_/g, " ")} products`
                  : ""}
                .
              </p>

              {/* Tags */}
              {product.tags && (
                <div className="mt-4 flex flex-wrap gap-2">
                  {product.tags.concern?.map((tag) => (
                    <TagBadge key={tag} tag={tag} />
                  ))}
                  {product.tags.philosophy?.map((tag) => (
                    <TagBadge key={tag} tag={tag} />
                  ))}
                  {product.tags.budget && (
                    <TagBadge
                      key={product.tags.budget}
                      tag={product.tags.budget}
                    />
                  )}
                  {product.tags.usage?.map((tag) => (
                    <TagBadge key={tag} tag={tag} />
                  ))}
                </div>
              )}
            </div>
          </div>
        </div>
      </header>

      <div className="grid gap-12 lg:grid-cols-3">
        {/* Main Content */}
        <div className="lg:col-span-2 space-y-10">
          {/* Why Recommended */}
          {product.why_recommended && product.why_recommended.length > 0 && (
            <section>
              <h2 className="flex items-center gap-2 text-xl font-semibold text-text">
                <svg
                  className="h-6 w-6 text-primary"
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
                      className="mt-0.5 h-5 w-5 flex-shrink-0 text-primary"
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
                    <span className="text-text-muted">
                      {reason}
                    </span>
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
                <h3 className="flex items-center gap-2 font-semibold text-emerald-600">
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
                    <li
                      key={index}
                      className="text-sm text-text-muted"
                    >
                      • {pro}
                    </li>
                  ))}
                </ul>
              </section>
            )}

            {/* Cons */}
            {product.cons && product.cons.length > 0 && (
              <section className="rounded-2xl border border-amber-500/20 bg-amber-500/5 p-6">
                <h3 className="flex items-center gap-2 font-semibold text-amber-600">
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
                    <li
                      key={index}
                      className="text-sm text-text-muted"
                    >
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
              <h2 className="flex items-center gap-2 text-xl font-semibold text-text">
                <svg
                  className="h-6 w-6 text-primary"
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
              <div className="mt-4 rounded-2xl border border-border bg-white p-6 shadow-sm">
                <p className="text-text-muted">
                  {product.ingredients_summary}
                </p>
              </div>
            </section>
          )}
        </div>

        {/* Sidebar */}
        <aside className="space-y-6">
          {/* Buy Links */}
          {product.buy_links && product.buy_links.length > 0 && (
            <section className="card p-6">
              <h3 className="font-semibold text-text">
                Where to Buy
              </h3>
              <div className="mt-4 space-y-3">
                {product.buy_links.map((link, index) => (
                  <a
                    key={index}
                    href={link.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="flex items-center justify-between rounded-xl border border-border bg-surface px-4 py-3 transition-colors hover:border-primary/50 hover:bg-surface"
                  >
                    <span className="font-medium text-text">
                      {link.vendor || "Buy Now"}
                    </span>
                    <svg
                      className="h-5 w-5 text-text-muted"
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
            <section className="card p-6">
              <h3 className="font-semibold text-text">
                Certifications
              </h3>
              <div className="mt-4 flex flex-wrap gap-2">
                {product.certifications.map((cert) => (
                  <span
                    key={cert}
                    className="inline-flex items-center gap-1 rounded-full border border-emerald-500/30 bg-emerald-500/10 px-3 py-1 text-sm text-emerald-600"
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
            <section className="card p-6">
              <h3 className="font-semibold text-text">
                Last Reviewed
              </h3>
              <p className="mt-2 text-text-muted">
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
              className="flex items-center justify-between rounded-2xl border border-border bg-white p-6 shadow-sm transition-colors hover:border-primary/50"
            >
              <div>
                <p className="text-sm text-text-muted">Category</p>
                <p className="font-medium text-text">
                  {product.category
                    .replace(/_/g, " ")
                    .replace(/\b\w/g, (c) => c.toUpperCase())}
                </p>
              </div>
              <svg
                className="h-5 w-5 text-text-muted"
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
            description: product.ingredients_summary || undefined,
            brand: product.brand
              ? {
                  "@type": "Brand",
                  name: product.brand,
                }
              : undefined,
            aggregateRating: product.score
              ? {
                  "@type": "AggregateRating",
                  ratingValue: (product.score / 20).toFixed(1),
                  bestRating: "5",
                  worstRating: "1",
                  ratingCount: "1",
                }
              : undefined,
            review: {
              "@type": "Review",
              author: {
                "@type": "Organization",
                name: "ChosenWell",
              },
              reviewBody:
                product.why_recommended?.join(" ") ||
                product.pros?.join(" ") ||
                undefined,
              datePublished: product.last_reviewed || undefined,
            },
          }),
        }}
      />

      {/* Related Products - Server-rendered for SEO (Rule 3 compliance) */}
      {relatedProducts.length > 0 && (
        <section className="mt-16">
          <h3 className="mb-6 text-xl font-semibold text-text">
            Related Products
          </h3>
          <ul className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {relatedProducts.map((relatedProduct) => (
              <li key={relatedProduct.slug}>
                <a
                  href={`/products/${relatedProduct.slug}`}
                  className="flex items-center gap-4 rounded-xl border border-border bg-white p-4 transition-colors hover:border-primary/50 hover:bg-surface"
                >
                  <div className="flex-1 min-w-0">
                    {relatedProduct.brand && (
                      <p className="text-xs font-medium uppercase tracking-wider text-text-muted">
                        {relatedProduct.brand}
                      </p>
                    )}
                    <p className="font-medium text-text truncate">
                      {relatedProduct.name}
                    </p>
                    {relatedProduct.short_reason && (
                      <p className="mt-1 text-sm text-text-muted line-clamp-1">
                        {relatedProduct.short_reason}
                      </p>
                    )}
                  </div>
                  <svg
                    className="h-5 w-5 flex-shrink-0 text-text-muted"
                    fill="none"
                    viewBox="0 0 24 24"
                    strokeWidth={2}
                    stroke="currentColor"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      d="M8.25 4.5l7.5 7.5-7.5 7.5"
                    />
                  </svg>
                </a>
              </li>
            ))}
          </ul>
        </section>
      )}

      {/* Client-side components: Similar products, Recently viewed, and tracking */}
      <ProductClientWrapper
        product={{
          slug: product.slug,
          name: product.name,
          brand: product.brand,
          short_reason: product.why_recommended?.[0],
        }}
        slug={product.slug}
      />
    </div>
  );
}
