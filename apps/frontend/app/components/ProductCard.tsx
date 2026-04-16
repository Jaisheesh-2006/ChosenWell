import Link from "next/link";
import Image from "next/image";
import { ProductSummary } from "../lib/types";

interface ProductCardProps {
  product: ProductSummary;
}

export default function ProductCard({ product }: ProductCardProps) {
  return (
    <article className="group relative flex h-full flex-col rounded-xl border border-border bg-surface-raised shadow-card transition-all duration-300 hover:border-primary-light/30 hover:shadow-card-hover hover:-translate-y-0.5 overflow-hidden">
      {/* Product Image */}
      {product.image_url && (
        <Link
          href={`/products/${product.slug}`}
          className="block relative h-56 w-full bg-surface"
        >
          <Image
            src={product.image_url}
            alt={product.name}
            fill
            className="object-contain p-4 transition-transform duration-500 group-hover:scale-[1.04]"
            sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
          />
        </Link>
      )}

      <div className="flex flex-1 flex-col p-6">
        {/* Header */}
        <div className="flex items-start justify-between">
          <div className="flex-1">
            {product.brand && (
              <span className="text-[11px] font-semibold uppercase tracking-[0.15em] text-accent">
                {product.brand}
              </span>
            )}
            <h3 className="mt-1 text-lg font-semibold text-text leading-snug">
              <Link
                href={`/products/${product.slug}`}
                className="transition-colors duration-200 hover:text-primary"
              >
                {product.name} – ingredient safety review
              </Link>
            </h3>
          </div>
        </div>

        {/* Short reason */}
        {product.short_reason && (
          <p className="mt-3 flex-1 text-sm text-text-muted line-clamp-2 leading-relaxed">
            {product.short_reason}
          </p>
        )}

        {/* Tags */}
        {product.tags && (
          <div className="mt-3 flex flex-wrap gap-1.5">
            {product.tags.concern?.slice(0, 2).map((tag) => (
              <span
                key={tag}
                className="inline-flex items-center rounded-full bg-primary-lighter px-2.5 py-0.5 text-xs font-medium text-primary"
              >
                {tag.replace(/_/g, " ")}
              </span>
            ))}
            {product.budget_tier && (
              <span
                className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium ${
                  product.budget_tier.toLowerCase().includes("budget")
                    ? "bg-emerald-50 text-emerald-700"
                    : product.budget_tier.toLowerCase().includes("premium")
                    ? "bg-blue-50 text-blue-700"
                    : "bg-amber-50 text-amber-700"
                }`}
              >
                {product.budget_tier.replace(/_/g, " ")}
              </span>
            )}
          </div>
        )}

        {/* Reviewed date */}
        {product.last_reviewed && (
          <p className="mt-3 text-xs text-text-muted">
            Reviewed{" "}
            {new Date(product.last_reviewed).toLocaleDateString("en-IN", {
              month: "short",
              year: "numeric",
            })}
          </p>
        )}

        {/* Footer */}
        <div className="mt-4 flex items-center justify-end border-t border-border pt-4">
          <Link
            href={`/products/${product.slug}`}
            className="flex items-center gap-1.5 text-sm font-medium text-primary transition-colors duration-200 hover:text-primary-light"
          >
            See full evaluation
            <svg
              className="h-4 w-4 transition-transform duration-200 group-hover:translate-x-1"
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
          </Link>
        </div>
      </div>
    </article>
  );
}
