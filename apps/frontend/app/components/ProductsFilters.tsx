"use client";

import { useRouter, useSearchParams } from "next/navigation";
import { useCallback } from "react";
import { CategorySummary } from "../lib/types";

interface ProductsFiltersProps {
  categories: CategorySummary[];
  totalCount: number;
  filteredCount: number;
}

export default function ProductsFilters({
  categories,
  totalCount,
  filteredCount,
}: ProductsFiltersProps) {
  const router = useRouter();
  const searchParams = useSearchParams();

  const currentSearch = searchParams.get("search") ?? "";
  const currentCategory = searchParams.get("category") ?? "";
  const currentSort = searchParams.get("sort") ?? "";

  const updateParam = useCallback(
    (key: string, value: string) => {
      const params = new URLSearchParams(searchParams.toString());
      if (value) {
        params.set(key, value);
      } else {
        params.delete(key);
      }
      router.replace(`/products?${params.toString()}`, { scroll: false });
    },
    [router, searchParams],
  );

  const clearAll = useCallback(() => {
    router.replace("/products", { scroll: false });
  }, [router]);

  const hasActiveFilters = currentSearch || currentCategory || currentSort;

  return (
    <div className="mb-8 space-y-4">
      {/* Filter controls */}
      <div className="flex flex-wrap items-center gap-3">
        {/* Search */}
        <div className="relative flex-1 min-w-[200px] max-w-xs">
          <svg
            className="pointer-events-none absolute left-3.5 top-1/2 h-4 w-4 -translate-y-1/2 text-text-muted"
            fill="none"
            viewBox="0 0 24 24"
            strokeWidth={2}
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z"
            />
          </svg>
          <input
            type="search"
            value={currentSearch}
            onChange={(e) => updateParam("search", e.target.value)}
            placeholder="Search products..."
            className="w-full rounded-xl border border-border bg-surface-raised py-2.5 pl-10 pr-4 text-sm text-text placeholder:text-text-muted transition-all duration-200 focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/15"
          />
        </div>

        {/* Category filter */}
        {categories.length > 0 && (
          <select
            value={currentCategory}
            onChange={(e) => updateParam("category", e.target.value)}
            className="rounded-xl border border-border bg-surface-raised px-4 py-2.5 text-sm text-text transition-all duration-200 focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/15"
          >
            <option value="">All categories</option>
            {categories.map((cat) => (
              <option key={cat.slug} value={cat.slug}>
                {cat.title}
              </option>
            ))}
          </select>
        )}

        {/* Sort */}
        <select
          value={currentSort}
          onChange={(e) => updateParam("sort", e.target.value)}
          className="rounded-xl border border-border bg-surface-raised px-4 py-2.5 text-sm text-text transition-all duration-200 focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/15"
        >
          <option value="">Newest first</option>
          <option value="name-asc">Name: A → Z</option>
          <option value="name-desc">Name: Z → A</option>
        </select>

        {/* Clear filters */}
        {hasActiveFilters && (
          <button
            type="button"
            onClick={clearAll}
            className="flex items-center gap-1.5 rounded-xl border border-border px-3.5 py-2.5 text-sm text-text-muted transition-colors hover:bg-surface hover:text-text hover:border-border-strong"
          >
            <svg
              className="h-3.5 w-3.5"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
            Clear filters
          </button>
        )}
      </div>

      {/* Result count */}
      <p className="text-sm text-text-muted">
        {hasActiveFilters ? (
          <>
            <span className="font-semibold text-text">{filteredCount}</span> of{" "}
            {totalCount} product{totalCount !== 1 ? "s" : ""}
          </>
        ) : (
          <>
            <span className="font-semibold text-text">{totalCount}</span> product
            {totalCount !== 1 ? "s" : ""} found
          </>
        )}
      </p>
    </div>
  );
}
