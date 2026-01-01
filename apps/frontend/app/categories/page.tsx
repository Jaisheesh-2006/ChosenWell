import type { Metadata } from "next";
import { getCategories } from "../lib/api";
import { CategorySummary } from "../lib/types";
import CategoryCard from "../components/CategoryCard";
import Breadcrumbs from "../components/Breadcrumbs";
import EmptyState from "../components/EmptyState";

export const metadata: Metadata = {
  title: "Product Categories",
  description:
    "Browse health product categories including toothpaste, cooking oils, vitamins, and supplements. Find the best products in each category with our transparent scoring system.",
  openGraph: {
    title: "Product Categories | HealthIsWealth",
    description:
      "Browse health product categories including toothpaste, cooking oils, vitamins, and supplements.",
  },
};

// Fallback categories when API is unavailable
const fallbackCategories: CategorySummary[] = [
  {
    slug: "toothpaste",
    title: "Toothpaste",
    description:
      "Natural and effective oral care products analyzed for safety and efficacy.",
  },
  {
    slug: "cooking-oil",
    title: "Cooking Oils",
    description:
      "Heart-healthy oils compared for smoke point, nutrition, and purity.",
  },
  {
    slug: "vitamins",
    title: "Vitamins",
    description:
      "Essential vitamin supplements evaluated for bioavailability and quality.",
  },
  {
    slug: "supplements",
    title: "Supplements",
    description:
      "Dietary supplements reviewed for ingredient quality and third-party testing.",
  },
];

async function getCategoriesData(): Promise<CategorySummary[]> {
  try {
    const categories = await getCategories();
    return categories.length > 0 ? categories : fallbackCategories;
  } catch {
    return fallbackCategories;
  }
}

export default async function CategoriesPage() {
  const categories = await getCategoriesData();

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs items={[{ label: "Categories" }]} />

      {/* Header */}
      <div className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          Product Categories
        </h1>
        <p className="mt-4 max-w-3xl text-lg text-slate-600 dark:text-slate-400">
          Explore our curated collection of health products organized by
          category. Each category features in-depth analysis and our top picks
          based on ingredients, certifications, and value.
        </p>
      </div>

      {/* Categories Grid */}
      {categories.length > 0 ? (
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {categories.map((category) => (
            <CategoryCard key={category.slug} category={category} />
          ))}
        </div>
      ) : (
        <EmptyState
          title="No categories found"
          description="We're working on adding more categories. Check back soon!"
        />
      )}

      {/* Info Section */}
      <section className="mt-16 rounded-2xl border border-white/10 bg-slate-900/50 p-8">
        <h2 className="text-xl font-semibold text-white">
          How we organize categories
        </h2>
        <p className="mt-4 text-slate-400">
          Each category page includes detailed criteria specific to that product
          type, a curated list of top-rated products, and long-form content
          explaining what to look for when shopping. Our experts research
          ingredients, certifications, and scientific literature to provide you
          with actionable insights.
        </p>
      </section>
    </div>
  );
}
