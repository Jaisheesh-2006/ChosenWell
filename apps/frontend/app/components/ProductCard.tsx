"use client";

import Link from "next/link";
import { ProductSummary } from "../lib/types";
import ScoreBadge from "./ScoreBadge";
import { useCurrency } from "../context";

interface ProductCardProps {
  product: ProductSummary;
}

export default function ProductCard({ product }: ProductCardProps) {
  const { formatPriceString } = useCurrency();

  // Get converted price if price_range exists
  const displayPrice = product.price_range
    ? formatPriceString(product.price_range)
    : null;

  return (
    <Link href={`/products/${product.slug}`}>
      <article className="group relative flex h-full flex-col rounded-2xl border border-white/10 bg-slate-900/60 p-6 transition-all hover:border-cyan-500/30 hover:bg-slate-900/80 hover:shadow-xl hover:shadow-cyan-500/5 dark:border-white/10 dark:bg-slate-900/60 dark:hover:border-cyan-500/30 dark:hover:bg-slate-900/80">
        {/* Header with score */}
        <div className="flex items-start justify-between">
          <div className="flex-1">
            {product.brand && (
              <span className="text-xs font-medium uppercase tracking-wider text-slate-500 dark:text-slate-500">
                {product.brand}
              </span>
            )}
            <h3 className="mt-1 text-lg font-semibold text-white group-hover:text-cyan-400 transition-colors dark:text-white dark:group-hover:text-cyan-400">
              {product.name}
            </h3>
          </div>
          <ScoreBadge score={product.score} size="sm" />
        </div>

        {/* Short reason */}
        {product.short_reason && (
          <p className="mt-3 flex-1 text-sm text-slate-400 line-clamp-2 dark:text-slate-400">
            {product.short_reason}
          </p>
        )}

        {/* Footer */}
        <div className="mt-4 flex items-center justify-between border-t border-white/5 pt-4 dark:border-white/5">
          {displayPrice && (
            <span className="text-sm font-medium text-emerald-400 dark:text-emerald-400">
              {displayPrice}
            </span>
          )}
          <span className="flex items-center gap-1 text-sm text-slate-500 group-hover:text-cyan-400 dark:text-slate-500 dark:group-hover:text-cyan-400">
            View details
            <svg
              className="h-4 w-4 transition-transform group-hover:translate-x-1"
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
          </span>
        </div>
      </article>
    </Link>
  );
}
