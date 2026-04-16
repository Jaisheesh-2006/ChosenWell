import { permanentRedirect } from "next/navigation";
import { getCategories } from "../lib/api";

interface CategoryAliasPageProps {
  params: Promise<{ slug: string }>;
}

export const dynamicParams = true;

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

export default async function CategoryAliasPage({
  params,
}: CategoryAliasPageProps) {
  const { slug } = await params;
  // Redirect to canonical /categories/[slug] (underscore form)
  permanentRedirect(`/categories/${slug.replace(/-/g, "_")}`);
}
