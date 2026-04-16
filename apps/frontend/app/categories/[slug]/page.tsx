import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { getCategoryBySlug, getCategories } from "../../lib/api";
import { Category } from "../../lib/types";
import ProductCard from "../../components/ProductCard";
import Breadcrumbs from "../../components/Breadcrumbs";
import EmptyState from "../../components/EmptyState";
import CriteriaSection from "../../components/CriteriaSection";

interface CategoryPageProps {
  params: Promise<{ slug: string }>;
}

// Allow dynamic params for categories not pre-generated
export const dynamicParams = true;

// Revalidate pages every 5 minutes
export const revalidate = 300;

// Generate static params for all categories (SSG)
export async function generateStaticParams() {
  try {
    const categories = await getCategories();
    return categories.map((category) => ({
      slug: category.slug,
    }));
  } catch {
    return [];
  }
}

// Generate metadata for SEO
export async function generateMetadata({
  params,
}: CategoryPageProps): Promise<Metadata> {
  const { slug } = await params;
  const hyphenSlug = slug.replace(/_/g, "-");

  try {
    const category = await getCategoryBySlug(slug);
    const description =
      `Best ${category.title.toLowerCase()} products in India - verified for safety, ingredients, and quality. ${
        category.long_description?.substring(0, 100) || ""
      }`.substring(0, 160);

    return {
      title: `Best ${category.title} Products in India - Reviews & Comparisons`,
      description,
      alternates: {
        // Prefer short, hyphenated root-level URL as canonical
        canonical: `/${hyphenSlug}`,
      },
      openGraph: {
        title: `${category.title} Products | ChosenWell`,
        description: `Compare the best ${category.title.toLowerCase()} products with transparent ingredient analysis.`,
        url: `/${hyphenSlug}`,
      },
    };
  } catch {
    return {
      title: "Category Not Found",
    };
  }
}

// No fallback data - only use database

async function getCategoryData(slug: string): Promise<Category | null> {
  try {
    return await getCategoryBySlug(slug);
  } catch {
    // Return null to trigger 404
    return null;
  }
}

export default async function CategoryPage({ params }: CategoryPageProps) {
  const { slug } = await params;
  const category = await getCategoryData(slug);

  if (!category) {
    notFound();
  }

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs
        items={[
          { label: "Categories", href: "/categories" },
          { label: category.title },
        ]}
      />

      {/* Header */}
      <header className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-text">
          {category.title}
        </h1>

        {/* Criteria tags */}
        {category.criteria && category.criteria.length > 0 && (
          <div className="mt-6 flex flex-wrap gap-2">
            {category.criteria.map((criterion) => (
              <span
                key={criterion}
                className="inline-flex items-center rounded-full border border-primary/30 bg-primary/10 px-3 py-1 text-sm text-primary"
              >
                <svg
                  className="mr-1.5 h-4 w-4"
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
                {criterion}
              </span>
            ))}
          </div>
        )}
      </header>

      {/* Long description - SEO rich content
      <section className="mb-16">
        <div
          className="prose prose-lg max-w-none prose-headings:text-text prose-p:text-text-muted prose-a:text-primary prose-strong:text-text"
          dangerouslySetInnerHTML={{ __html: category.long_description }}
        />
      </section> */}

      {/* How we evaluate - Criteria content */}
      {category.criteria_content && (
        <CriteriaSection
          title={category.title}
          content={category.criteria_content}
        />
      )}

      {/* Curated Products */}
      <section>
        <div className="mb-8 flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <p className="section-label">
              Our Picks
            </p>
            <h2 className="mt-2 text-2xl font-bold text-text font-display">
              Top {category.title} Products
            </h2>
            {category.curated_products && category.curated_products.length > 0 && (
              <p className="mt-1 text-sm text-text-muted">
                {category.curated_products.length} product
                {category.curated_products.length !== 1 ? "s" : ""} evaluated
              </p>
            )}
          </div>
          <Link
            href={`/products?category=${encodeURIComponent(category.slug)}`}
            className="inline-flex items-center gap-2 rounded-full border border-primary/30 bg-primary/10 px-4 py-2 text-sm font-medium text-primary transition-colors hover:bg-primary/20"
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

        {category.curated_products && category.curated_products.length > 0 ? (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {category.curated_products.map((product) => (
              <ProductCard key={product.slug} product={product} />
            ))}
          </div>
        ) : (
          <div className="card p-8 text-center">
            <div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-surface">
              <svg
                className="h-8 w-8 text-text-muted"
                fill="none"
                viewBox="0 0 24 24"
                strokeWidth={1.5}
                stroke="currentColor"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5m6 4.125l2.25 2.25m0 0l2.25 2.25M12 13.875l2.25-2.25M12 13.875l-2.25 2.25M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z"
                />
              </svg>
            </div>
            <h3 className="text-lg font-semibold text-text">
              No products yet
            </h3>
            <p className="mt-2 text-text-muted">
              We&apos;re still curating products for this category. Check back
              soon!
            </p>
            <div className="mt-6 flex flex-wrap justify-center gap-3">
              <Link
                href="/products"
                className="btn-primary px-5 py-2 text-sm"
              >
                Browse all products
              </Link>
              <Link
                href="/categories"
                className="inline-flex items-center gap-2 rounded-full border border-border bg-white px-5 py-2 text-sm font-semibold text-text transition-colors hover:bg-surface"
              >
                View other categories
              </Link>
            </div>
          </div>
        )}
      </section>

      {/* Navigation Section */}
      <section className="mt-16 rounded-2xl border border-border bg-surface p-8">
        <div className="flex flex-col items-center justify-between gap-6 sm:flex-row">
          <div>
            <h3 className="text-lg font-semibold text-text">
              Explore more
            </h3>
            <p className="mt-1 text-sm text-text-muted">
              Discover products across all categories or learn about our
              methodology.
            </p>
          </div>
          <div className="flex flex-wrap gap-3">
            <Link
              href="/products"
              className="btn-primary px-5 py-2.5 text-sm"
            >
              All Products
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
              href="/categories"
              className="inline-flex items-center gap-2 rounded-full border border-border bg-white px-5 py-2.5 text-sm font-semibold text-text transition-colors hover:bg-surface"
            >
              All Categories
            </Link>
            <Link
              href="/methodology"
              className="inline-flex items-center gap-2 rounded-full border border-border bg-white px-5 py-2.5 text-sm font-semibold text-text transition-colors hover:bg-surface"
            >
              Our Methodology
            </Link>
          </div>
        </div>
      </section>

      {/* Structured data for SEO */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "CollectionPage",
            name: category.title,
            description: category.long_description?.substring(0, 200),
            url: `https://www.chosenwell.co.in/categories/${slug.replace(/_/g, "-")}`,
          }),
        }}
      />
    </div>
  );
}
