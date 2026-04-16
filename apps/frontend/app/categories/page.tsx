import type { Metadata } from "next";
import { getCategories } from "../lib/api";
import { CategorySummary } from "../lib/types";
import CategoryCard from "../components/CategoryCard";
import Breadcrumbs from "../components/Breadcrumbs";
import EmptyState from "../components/EmptyState";

export const metadata: Metadata = {
  title: "Product Categories - Shampoo, Toothpaste, Soap & More",
  description:
    "Browse verified health product categories including shampoo, toothpaste, soap, hair oil, and sunscreen. Find safe, transparent products in each category.",
  alternates: {
    canonical: "/categories",
  },
  openGraph: {
    title: "Product Categories | ChosenWell",
    description:
      "Browse verified health product categories including shampoo, toothpaste, soap, hair oil, and sunscreen.",
    url: "/categories",
  },
};

// ISR: Revalidate categories page every 5 minutes
export const revalidate = 300;

// Fallback categories for when API fails
const fallbackCategories: CategorySummary[] = [
  {
    slug: "shampoo",
    title: "Shampoo",
    description:
      "Clean hair care products evaluated for scalp health and ingredient safety.",
  },
  {
    slug: "sunscreen",
    title: "Sunscreen",
    description:
      "Sun protection products analyzed for UVA/UVB coverage, reef safety, and skin compatibility.",
  },
  {
    slug: "hair_oil",
    title: "Hair Oil",
    description:
      "Premium hair oils evaluated for nourishment, scalp health, and natural ingredient quality.",
  },
  {
    slug: "soap",
    title: "Soap",
    description:
      "Natural body soaps and cleansing bars analyzed for skin-friendly ingredients and pH balance.",
  },
  {
    slug: "toothpaste",
    title: "Toothpaste",
    description:
      "Natural and effective oral care products analyzed for safety and efficacy.",
  },
];

async function getCategoriesData(): Promise<CategorySummary[]> {
  try {
    const categories = await getCategories();
    // If API returns empty, use fallback
    if (!categories || categories.length === 0) {
      console.warn("[Categories] API returned empty, using fallback data");
      return fallbackCategories;
    }
    return categories;
  } catch (error) {
    console.error("Error fetching categories:", error);
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
        <h1 className="page-heading">
          Product Categories
        </h1>
        {/* SEO-optimized explanatory content - above the fold */}
        <p className="mt-4 max-w-3xl text-lg text-text-muted">
          Find products that meet our safety and transparency standards,
          organized by category. Each category is independently evaluated using
          our methodology—covering ingredient safety, regulatory compliance, and
          real-world efficacy for Indian consumers.
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
      <section className="card mt-16 p-8 border-l-4 border-l-accent">
        <h2 className="text-xl font-semibold text-text">
          How we organize categories
        </h2>
        <p className="mt-4 text-text-muted">
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
