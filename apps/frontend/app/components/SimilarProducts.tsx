"use client";

import { useEffect, useState, useCallback } from "react";
import { ProductSummary } from "../lib/types";
import ProductCard from "./ProductCard";

interface SimilarProductsProps {
  productSlug: string;
  limit?: number;
}

const API_BASE_URL =
  process.env.NEXT_PUBLIC_API_URL ||
  "https://chosenwell-production.up.railway.app";

export default function SimilarProducts({
  productSlug,
  limit = 4,
}: SimilarProductsProps) {
  const [products, setProducts] = useState<ProductSummary[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchSimilarProducts = useCallback(async () => {
    // Skip if no slug
    if (!productSlug) {
      setLoading(false);
      return;
    }

    try {
      setLoading(true);
      const params = limit ? `?limit=${limit}` : "";
      const endpoint = `/products/${encodeURIComponent(
        productSlug
      )}/similar${params}`;

      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 8000); // 8s timeout

      const res = await fetch(`${API_BASE_URL}${endpoint}`, {
        method: "GET",
        headers: {
          Accept: "application/json",
        },
        signal: controller.signal,
      });

      clearTimeout(timeoutId);

      if (!res.ok) {
        // Silently fail - non-critical feature
        setProducts([]);
        return;
      }

      const data = await res.json();

      // Validate response is an array
      if (Array.isArray(data)) {
        setProducts(data as ProductSummary[]);
      } else {
        setProducts([]);
      }
    } catch {
      // Silently fail for network errors, CORS, timeouts, etc.
      // This is a non-critical enhancement feature
      setProducts([]);
    } finally {
      setLoading(false);
    }
  }, [productSlug, limit]);

  useEffect(() => {
    fetchSimilarProducts();
  }, [fetchSimilarProducts]);

  // Don't render anything while loading or if no products
  if (loading) {
    return (
      <section className="mt-16">
        <h2 className="mb-8 text-2xl font-bold text-slate-900 dark:text-white">
          Similar Products
        </h2>
        <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {[...Array(limit)].map((_, i) => (
            <div
              key={i}
              className="h-64 animate-pulse rounded-2xl bg-slate-200 dark:bg-white/5"
            />
          ))}
        </div>
      </section>
    );
  }

  // Silently hide if no products or error occurred
  if (products.length === 0) {
    return null;
  }

  return (
    <section className="mt-16">
      <h2 className="mb-8 text-2xl font-bold text-slate-900 dark:text-white">
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
