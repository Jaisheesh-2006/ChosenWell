import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getCategoryBySlug, getCategories } from "../../lib/api";
import { Category } from "../../lib/types";
import ProductCard from "../../components/ProductCard";
import Breadcrumbs from "../../components/Breadcrumbs";
import EmptyState from "../../components/EmptyState";

interface CategoryPageProps {
  params: Promise<{ slug: string }>;
}

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
        title: `${category.title} | HealthIsWealth`,
        description: `Compare the best ${category.title.toLowerCase()} products with transparent scoring.`,
      },
    };
  } catch {
    return {
      title: "Category Not Found",
    };
  }
}

// Fallback data
const fallbackCategory: Category = {
  slug: "example",
  title: "Example Category",
  long_description:
    "This is a placeholder category. The actual content will be loaded from the API when available.",
  criteria: ["Quality ingredients", "Third-party tested", "Good value"],
  curated_products: [],
};

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

      {/* Long description - SEO rich content */}
      <section className="mb-16">
        <div
          className="prose prose-lg max-w-none prose-headings:text-slate-900 prose-p:text-slate-600 prose-a:text-cyan-600 prose-strong:text-slate-900 dark:prose-invert dark:prose-headings:text-white dark:prose-p:text-slate-300 dark:prose-a:text-cyan-400 dark:prose-strong:text-white"
          dangerouslySetInnerHTML={{ __html: category.long_description }}
        />
      </section>

      {/* Curated Products */}
      <section>
        <div className="mb-8 flex items-end justify-between">
          <div>
            <p className="text-sm font-medium uppercase tracking-wider text-cyan-600 dark:text-cyan-400">
              Our Picks
            </p>
            <h2 className="mt-2 text-2xl font-bold text-slate-900 dark:text-white">
              Top {category.title} Products
            </h2>
          </div>
        </div>

        {category.curated_products && category.curated_products.length > 0 ? (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {category.curated_products.map((product) => (
              <ProductCard key={product.slug} product={product} />
            ))}
          </div>
        ) : (
          <EmptyState
            title="No products yet"
            description="We're still curating products for this category. Check back soon!"
          />
        )}
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
            url: `https://healthiswealth.com/categories/${category.slug}`,
          }),
        }}
      />
    </div>
  );
}
