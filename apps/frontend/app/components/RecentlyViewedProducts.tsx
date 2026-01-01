"use client";

import { useRecentlyViewed } from "../context";
import { useState, useEffect } from "react";
import ProductCard from "./ProductCard";

interface RecentlyViewedProductsProps {
  limit?: number;
  excludeSlug?: string;
}

export default function RecentlyViewedProducts({
  limit = 4,
  excludeSlug,
}: RecentlyViewedProductsProps) {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  // Don't render during SSR to avoid hydration issues
  if (!mounted) {
    return null;
  }

  return <RecentlyViewedContent limit={limit} excludeSlug={excludeSlug} />;
}

function RecentlyViewedContent({
  limit,
  excludeSlug,
}: {
  limit: number;
  excludeSlug?: string;
}) {
  const { recentProducts, clearHistory } = useRecentlyViewed();

  // Filter out the current product if on a product page
  const filteredProducts = excludeSlug
    ? recentProducts.filter((p) => p.slug !== excludeSlug)
    : recentProducts;

  const displayProducts = filteredProducts.slice(0, limit);

  if (displayProducts.length === 0) {
    return null;
  }

  return (
    <section className="mt-16">
      <div className="mb-8 flex items-center justify-between">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          Recently Viewed
        </h2>
        <button
          onClick={clearHistory}
          className="text-sm text-slate-500 transition-colors hover:text-cyan-600 dark:text-slate-400 dark:hover:text-cyan-400"
        >
          Clear history
        </button>
      </div>
      <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {displayProducts.map((product) => (
          <ProductCard key={product.slug} product={product} />
        ))}
      </div>
    </section>
  );
}
