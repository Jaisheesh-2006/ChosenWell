import type { Metadata } from "next";
import { notFound } from "next/navigation";
import Link from "next/link";
import { getCategoryBySlug, getCategories } from "../lib/api";
import { Category } from "../lib/types";
import ProductCard from "../components/ProductCard";
import Breadcrumbs from "../components/Breadcrumbs";
import CriteriaSection from "../components/CriteriaSection";

interface CategoryAliasPageProps {
  params: Promise<{ slug: string }>;
}

export const dynamicParams = true;
export const revalidate = 300;

// Pre-generate root-level category pages using hyphenated slugs
export async function generateStaticParams() {
  try {
    const categories = await getCategories();
    return categories.map((category) => ({
      slug: category.slug.replace(/_/g, "-"),
    }));
  } catch {
    return [];
  }
}

export async function generateMetadata({
  params,
}: CategoryAliasPageProps): Promise<Metadata> {
  const { slug } = await params;
  const underscoreSlug = slug.replace(/-/g, "_");

  try {
    const category = await getCategoryBySlug(underscoreSlug);
    const description = (
      `Best ${category.title.toLowerCase()} products in India - verified for safety, ingredients, and quality. ` +
      (category.long_description?.substring(0, 100) || "")
    ).substring(0, 160);

    return {
      title: `Best ${category.title} Products in India - Reviews & Comparisons`,
      description,
      alternates: {
        canonical: `/${slug}`,
      },
      openGraph: {
        title: `${category.title} Products | ChosenWell`,
        description: `Compare the best ${category.title.toLowerCase()} products with transparent ingredient analysis.`,
        url: `/${slug}`,
      },
    };
  } catch {
    return { title: "Category Not Found" };
  }
}

async function getCategoryData(slug: string): Promise<Category | null> {
  try {
    const underscoreSlug = slug.replace(/-/g, "_");
    return await getCategoryBySlug(underscoreSlug);
  } catch {
    return null;
  }
}

export default async function CategoryAliasPage({
  params,
}: CategoryAliasPageProps) {
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

      <header className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          {category.title}
        </h1>
      </header>

      {category.criteria_content && (
        <CriteriaSection
          title={category.title}
          content={category.criteria_content}
        />
      )}

      <section>
        {category.curated_products && category.curated_products.length > 0 ? (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {category.curated_products.map((product) => (
              <ProductCard key={product.slug} product={product} />
            ))}
          </div>
        ) : (
          <div className="rounded-2xl border border-slate-200 bg-white p-8 text-center shadow-sm dark:border-white/10 dark:bg-slate-900/50">
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

      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "CollectionPage",
            name: category.title,
            description: category.long_description?.substring(0, 200),
            url: `https://www.chosenwell.co.in/${slug}`,
          }),
        }}
      />
    </div>
  );
}
