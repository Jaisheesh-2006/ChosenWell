import Link from "next/link";

export default function NotFound() {
  return (
    <div className="flex min-h-[60vh] flex-col items-center justify-center px-4 py-16">
      <div className="text-center">
        <div className="mx-auto mb-6 flex h-24 w-24 items-center justify-center rounded-full bg-gradient-to-br from-cyan-500/20 to-emerald-500/20">
          <svg
            className="h-12 w-12 text-cyan-400"
            fill="none"
            viewBox="0 0 24 24"
            strokeWidth={1.5}
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"
            />
          </svg>
        </div>
        <p className="text-sm font-medium uppercase tracking-wider text-cyan-400">
          404 Error
        </p>
        <h1 className="mt-2 text-4xl font-bold text-white">Page not found</h1>
        <p className="mt-4 max-w-md text-slate-400">
          Sorry, we couldn&apos;t find the page you&apos;re looking for. It might have
          been moved, deleted, or never existed.
        </p>
        <div className="mt-8 flex flex-wrap justify-center gap-4">
          <Link
            href="/"
            className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-6 py-3 font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
          >
            <svg
              className="h-5 w-5"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25"
              />
            </svg>
            Go Home
          </Link>
          <Link
            href="/products"
            className="inline-flex items-center gap-2 rounded-full border border-white/20 bg-white/5 px-6 py-3 font-semibold text-white backdrop-blur-sm transition-all hover:bg-white/10"
          >
            Browse Products
          </Link>
        </div>

        {/* Helpful Links */}
        <div className="mt-12">
          <p className="text-sm text-slate-500">You might be looking for:</p>
          <div className="mt-4 flex flex-wrap justify-center gap-4 text-sm">
            <Link
              href="/categories"
              className="text-cyan-400 hover:text-cyan-300"
            >
              Categories
            </Link>
            <span className="text-slate-700">•</span>
            <Link
              href="/products"
              className="text-cyan-400 hover:text-cyan-300"
            >
              Products
            </Link>
            <span className="text-slate-700">•</span>
            <Link
              href="/methodology"
              className="text-cyan-400 hover:text-cyan-300"
            >
              Methodology
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
