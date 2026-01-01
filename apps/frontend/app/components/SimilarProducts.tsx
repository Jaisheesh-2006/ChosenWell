"use client";

import { useEffect, useState } from "react";
import { ProductSummary } from "../lib/types";
import { getSimilarProducts } from "../lib/api";
import ProductCard from "./ProductCard";

interface SimilarProductsProps {
  productSlug: string;
  limit?: number;
}

export default function SimilarProducts({
  productSlug,
  limit = 4,
}: SimilarProductsProps) {
  const [products, setProducts] = useState<ProductSummary[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function fetchSimilarProducts() {
      try {
        setLoading(true);
        setError(null);
        const data = await getSimilarProducts(productSlug, limit);
        setProducts(data);
      } catch (err) {
        console.error("Failed to fetch similar products:", err);
        setError("Failed to load similar products");
      } finally {
        setLoading(false);
      }
    }

    if (productSlug) {
      fetchSimilarProducts();
    }
  }, [productSlug, limit]);

  if (loading) {
    return (
      <section className="mt-16">
        <h2 className="mb-8 text-2xl font-bold text-white dark:text-white">
          Similar Products
        </h2>
        <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {[...Array(limit)].map((_, i) => (
            <div
              key={i}
              className="h-64 animate-pulse rounded-2xl bg-white/5 dark:bg-white/5"
            />
          ))}
        </div>
      </section>
    );
  }

  if (error || products.length === 0) {
    return null;
  }

  return (
    <section className="mt-16">
      <h2 className="mb-8 text-2xl font-bold text-white dark:text-white">
        Similar Products
      </h2>
      <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {products.map((product) => (
          <ProductCard key={product.slug} product={product} />
        ))}
      </div>
    </section>
  );
}
