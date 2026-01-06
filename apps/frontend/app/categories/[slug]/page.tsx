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

  try {
    const category = await getCategoryBySlug(slug);
    return {
      title: category.title,
      description: `Compare the best ${category.title.toLowerCase()} products. ${
        category.long_description?.substring(0, 150) || ""
      }...`,
      openGraph: {
        title: `${category.title} | ChosenWell`,
        description: `Compare the best ${category.title.toLowerCase()} products with transparent scoring.`,
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
        <h1 className="text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          {category.title}
        </h1>

        {/* Criteria tags */}
        {category.criteria && category.criteria.length > 0 && (
          <div className="mt-6 flex flex-wrap gap-2">
            {category.criteria.map((criterion) => (
              <span
                key={criterion}
                className="inline-flex items-center rounded-full border border-emerald-500/30 bg-emerald-500/10 px-3 py-1 text-sm text-emerald-600 dark:text-emerald-400"
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
          className="prose prose-lg max-w-none prose-headings:text-slate-900 prose-p:text-slate-600 prose-a:text-cyan-600 prose-strong:text-slate-900 dark:prose-invert dark:prose-headings:text-white dark:prose-p:text-slate-300 dark:prose-a:text-cyan-400 dark:prose-strong:text-white"
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
            <p className="text-sm font-medium uppercase tracking-wider text-cyan-600 dark:text-cyan-400">
              Our Picks
            </p>
            <h2 className="mt-2 text-2xl font-bold text-slate-900 dark:text-white">
              Top {category.title} Products
            </h2>
          </div>
          <Link
            href="/products"
            className="inline-flex items-center gap-2 rounded-full border border-cyan-500/30 bg-cyan-500/10 px-4 py-2 text-sm font-medium text-cyan-600 transition-colors hover:bg-cyan-500/20 dark:text-cyan-400 dark:hover:bg-cyan-500/20"
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
          <div className="rounded-2xl border border-slate-200 bg-white p-8 text-center shadow-sm dark:border-white/10 dark:bg-slate-900/50">
            <div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-slate-100 dark:bg-slate-800">
              <svg
                className="h-8 w-8 text-slate-400"
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
            <h3 className="text-lg font-semibold text-slate-900 dark:text-white">
              No products yet
            </h3>
            <p className="mt-2 text-slate-600 dark:text-slate-400">
              We&apos;re still curating products for this category. Check back
              soon!
            </p>
            <div className="mt-6 flex flex-wrap justify-center gap-3">
              <Link
                href="/products"
                className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-5 py-2 text-sm font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
              >
                Browse all products
              </Link>
              <Link
                href="/categories"
                className="inline-flex items-center gap-2 rounded-full border border-slate-300 bg-white px-5 py-2 text-sm font-semibold text-slate-700 transition-colors hover:bg-slate-50 dark:border-white/20 dark:bg-white/5 dark:text-white dark:hover:bg-white/10"
              >
                View other categories
              </Link>
            </div>
          </div>
        )}
      </section>

      {/* Navigation Section */}
      <section className="mt-16 rounded-2xl border border-slate-200 bg-gradient-to-r from-slate-50 to-slate-100 p-8 dark:border-white/10 dark:from-slate-900/50 dark:to-slate-800/30">
        <div className="flex flex-col items-center justify-between gap-6 sm:flex-row">
          <div>
            <h3 className="text-lg font-semibold text-slate-900 dark:text-white">
              Explore more
            </h3>
            <p className="mt-1 text-sm text-slate-600 dark:text-slate-400">
              Discover products across all categories or learn about our
              methodology.
            </p>
          </div>
          <div className="flex flex-wrap gap-3">
            <Link
              href="/products"
              className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-5 py-2.5 text-sm font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
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
              className="inline-flex items-center gap-2 rounded-full border border-slate-300 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 transition-colors hover:bg-slate-50 dark:border-white/20 dark:bg-white/5 dark:text-white dark:hover:bg-white/10"
            >
              All Categories
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

      {/* Structured data for SEO */}
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "CollectionPage",
            name: category.title,
            description: category.long_description?.substring(0, 200),
            url: `https://chosenwell.co.in/categories/${category.slug}`,
          }),
        }}
      />
    </div>
  );
}
