import Link from "next/link";

export default function CategoryNotFound() {
  return (
    <div className="flex min-h-[50vh] flex-col items-center justify-center px-4 py-16">
      <div className="text-center">
        <p className="text-sm font-medium uppercase tracking-wider text-primary">
          404
        </p>
        <h1 className="mt-2 text-3xl font-bold text-text">
          Category not found
        </h1>
        <p className="mt-4 text-text-muted">
          We couldn&apos;t find the category you&apos;re looking for. It may have been
          moved or doesn&apos;t exist.
        </p>
        <div className="mt-8 flex flex-wrap justify-center gap-4">
          <Link
            href="/categories"
            className="btn-primary"
          >
            Browse Categories
          </Link>
          <Link
            href="/"
            className="btn-secondary"
          >
            Go Home
          </Link>
        </div>
      </div>
    </div>
  );
}
