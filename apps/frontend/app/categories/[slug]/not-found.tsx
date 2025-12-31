import Link from "next/link";

export default function CategoryNotFound() {
  return (
    <div className="flex min-h-[50vh] flex-col items-center justify-center px-4 py-16">
      <div className="text-center">
        <p className="text-sm font-medium uppercase tracking-wider text-cyan-400">
          404
        </p>
        <h1 className="mt-2 text-3xl font-bold text-white">
          Category not found
        </h1>
        <p className="mt-4 text-slate-400">
          We couldn&apos;t find the category you&apos;re looking for. It may have been
          moved or doesn&apos;t exist.
        </p>
        <div className="mt-8 flex flex-wrap justify-center gap-4">
          <Link
            href="/categories"
            className="inline-flex items-center gap-2 rounded-full bg-cyan-500 px-6 py-3 font-semibold text-white transition-colors hover:bg-cyan-600"
          >
            Browse Categories
          </Link>
          <Link
            href="/"
            className="inline-flex items-center gap-2 rounded-full border border-white/20 bg-white/5 px-6 py-3 font-semibold text-white transition-colors hover:bg-white/10"
          >
            Go Home
          </Link>
        </div>
      </div>
    </div>
  );
}
