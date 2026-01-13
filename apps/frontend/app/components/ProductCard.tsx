import Link from "next/link";
import Image from "next/image";
import { ProductSummary } from "../lib/types";

interface ProductCardProps {
  product: ProductSummary;
}

export default function ProductCard({ product }: ProductCardProps) {
  return (
    <article className="group relative flex h-full flex-col rounded-2xl border border-slate-200 bg-white shadow-sm transition-all hover:border-cyan-500/50 hover:shadow-lg hover:shadow-cyan-500/10 dark:border-white/10 dark:bg-slate-900/60 dark:hover:border-cyan-500/30 dark:hover:shadow-cyan-500/5 overflow-hidden">
      {/* Product Image */}
      {product.image_url && (
        <a
          href={`/products/${product.slug}`}
          className="block relative h-48 w-full bg-slate-100 dark:bg-slate-800"
        >
          <Image
            src={product.image_url}
            alt={product.name}
            fill
            className="object-contain p-4"
            sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
          />
        </a>
      )}

      <div className="flex flex-1 flex-col p-6">
        {/* Header */}
        <div className="flex items-start justify-between">
          <div className="flex-1">
            {product.brand && (
              <span className="text-xs font-medium uppercase tracking-wider text-slate-500 dark:text-slate-500">
                {product.brand}
              </span>
            )}
            <h3 className="mt-1 text-lg font-semibold text-slate-900 dark:text-white">
              <a
                href={`/products/${product.slug}`}
                className="transition-colors hover:text-cyan-600 dark:hover:text-cyan-400"
              >
                {product.name} – ingredient safety review
              </a>
            </h3>
          </div>
        </div>

        {/* Short reason */}
        {product.short_reason && (
          <p className="mt-3 flex-1 text-sm text-slate-600 line-clamp-2 dark:text-slate-400">
            {product.short_reason}
          </p>
        )}

        {/* Tags */}
        {product.tags && (
          <div className="mt-3 flex flex-wrap gap-1">
            {product.tags.concern?.slice(0, 2).map((tag) => (
              <span
                key={tag}
                className="inline-flex items-center rounded-full bg-cyan-50 px-2 py-0.5 text-xs font-medium text-cyan-700 dark:bg-cyan-900/30 dark:text-cyan-300"
              >
                {tag.replace(/_/g, " ")}
              </span>
            ))}
            {product.budget_tier && (
              <span className="inline-flex items-center rounded-full bg-emerald-50 px-2 py-0.5 text-xs font-medium text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300">
                {product.budget_tier.replace(/_/g, " ")}
              </span>
            )}
          </div>
        )}

        {/* Footer */}
        <div className="mt-4 flex items-center justify-end border-t border-slate-100 pt-4 dark:border-white/5">
          <a
            href={`/products/${product.slug}`}
            className="flex items-center gap-1 text-sm text-slate-500 transition-colors hover:text-cyan-600 dark:text-slate-500 dark:hover:text-cyan-400"
          >
            See full evaluation
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
          </a>
        </div>
      </div>
    </article>
  );
}
