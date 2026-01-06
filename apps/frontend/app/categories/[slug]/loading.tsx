export default function CategoryLoading() {
  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      {/* Breadcrumb skeleton */}
      <div className="mb-8 flex items-center gap-2">
        <div className="h-4 w-20 animate-pulse rounded bg-gray-200 dark:bg-gray-700" />
        <div className="h-4 w-4 animate-pulse rounded bg-gray-200 dark:bg-gray-700" />
        <div className="h-4 w-24 animate-pulse rounded bg-gray-200 dark:bg-gray-700" />
      </div>

      {/* Header skeleton */}
      <div className="mb-12 space-y-4">
        <div className="h-10 w-48 animate-pulse rounded bg-gray-200 dark:bg-gray-700" />
        <div className="h-5 w-3/4 animate-pulse rounded bg-gray-200 dark:bg-gray-700" />
      </div>

      {/* Products grid skeleton */}
      <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        {[...Array(8)].map((_, i) => (
          <div
            key={i}
            className="overflow-hidden rounded-xl border border-gray-200 bg-white dark:border-gray-700 dark:bg-gray-800"
          >
            {/* Image skeleton */}
            <div className="aspect-square w-full animate-pulse bg-gray-200 dark:bg-gray-700" />

            {/* Content skeleton */}
            <div className="p-4 space-y-3">
              {/* Brand */}
              <div className="h-3 w-16 animate-pulse rounded bg-gray-200 dark:bg-gray-700" />

              {/* Title */}
              <div className="h-5 w-full animate-pulse rounded bg-gray-200 dark:bg-gray-700" />

              {/* Score */}
              <div className="flex items-center gap-2">
                <div className="h-8 w-12 animate-pulse rounded-full bg-gray-200 dark:bg-gray-700" />
                <div className="h-4 w-24 animate-pulse rounded bg-gray-200 dark:bg-gray-700" />
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
