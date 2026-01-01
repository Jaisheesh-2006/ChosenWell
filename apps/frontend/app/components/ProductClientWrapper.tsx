"use client";

import { useEffect } from "react";
import { useRecentlyViewed } from "../context";
import SimilarProducts from "./SimilarProducts";
import RecentlyViewedProducts from "./RecentlyViewedProducts";
import { ProductSummary } from "../lib/types";

interface ProductClientWrapperProps {
  product: ProductSummary;
  slug: string;
}

export default function ProductClientWrapper({
  product,
  slug,
}: ProductClientWrapperProps) {
  const { addProduct } = useRecentlyViewed();

  // Track this product as viewed
  useEffect(() => {
    addProduct(product);
  }, [product, addProduct]);

  return (
    <>
      {/* Similar Products */}
      <SimilarProducts productSlug={slug} limit={4} />

      {/* Recently Viewed (excluding current product) */}
      <RecentlyViewedProducts limit={4} excludeSlug={slug} />
    </>
  );
}
