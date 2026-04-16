export default function ProductLoading() {
  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      {/* Breadcrumb skeleton */}
      <div className="mb-8 flex items-center gap-2">
        <div className="h-4 w-16 animate-pulse rounded bg-surface" />
        <div className="h-4 w-4 animate-pulse rounded bg-surface" />
        <div className="h-4 w-24 animate-pulse rounded bg-surface" />
      </div>

      <div className="grid gap-12 lg:grid-cols-2">
        {/* Image skeleton */}
        <div className="aspect-square w-full animate-pulse rounded-2xl bg-surface" />

        {/* Content skeleton */}
        <div className="space-y-6">
          <div className="h-4 w-24 animate-pulse rounded bg-surface" />
          <div className="h-8 w-3/4 animate-pulse rounded bg-surface" />
          <div className="h-12 w-32 animate-pulse rounded-full bg-surface" />
          <div className="space-y-2">
            <div className="h-4 w-full animate-pulse rounded bg-surface" />
            <div className="h-4 w-5/6 animate-pulse rounded bg-surface" />
          </div>
          <div className="flex flex-wrap gap-2">
            <div className="h-6 w-20 animate-pulse rounded-full bg-surface" />
            <div className="h-6 w-24 animate-pulse rounded-full bg-surface" />
            <div className="h-6 w-16 animate-pulse rounded-full bg-surface" />
          </div>
          <div className="h-12 w-full animate-pulse rounded-lg bg-surface" />
        </div>
      </div>

      {/* Details section skeleton */}
      <div className="mt-16 space-y-8">
        <div className="h-6 w-48 animate-pulse rounded bg-surface" />
        <div className="space-y-3">
          <div className="h-4 w-full animate-pulse rounded bg-surface" />
          <div className="h-4 w-full animate-pulse rounded bg-surface" />
          <div className="h-4 w-3/4 animate-pulse rounded bg-surface" />
        </div>
      </div>
    </div>
  );
}
