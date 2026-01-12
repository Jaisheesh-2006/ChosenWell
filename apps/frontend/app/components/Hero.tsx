import Link from "next/link";

export default function Hero() {
  return (
    <section className="relative overflow-hidden rounded-3xl border border-cyan-500/20 bg-gradient-to-br from-cyan-600/40 to-emerald-600/30 p-8 md:p-12 shadow-2xl dark:border-white/10">
      {/* Background decoration */}
      <div className="absolute inset-0 bg-[url('/images/grid.svg')] opacity-10" />

      <div className="relative z-10 max-w-3xl">
        {/* Headline - Process-focused trust language */}
        <h1 className="text-3xl md:text-4xl lg:text-5xl font-bold text-white leading-tight">
          Only Products That Meet Our Standards Appear Here
        </h1>

        {/* Subheadline - Explains the filtering process */}
        <p className="mt-6 text-lg md:text-xl text-cyan-50 leading-relaxed">
          We evaluate Indian daily-use products using a strict, repeatable
          methodology. Products that do not meet minimum safety and transparency
          thresholds are excluded from our listings.
        </p>

        {/* Supporting line - Differentiator */}
        <p className="mt-4 text-sm text-cyan-100/80 dark:text-cyan-200/70">
          Not a marketplace. Not sponsored rankings. An evaluation-first filter
          for Indian consumers.
        </p>

        {/* CTA Buttons */}
        <div className="mt-8 flex flex-wrap gap-4">
          <Link
            href="/categories"
            className="inline-flex items-center gap-2 rounded-full bg-white px-6 py-3 font-semibold text-cyan-700 shadow-lg transition-all hover:bg-cyan-50 hover:shadow-xl"
          >
            Browse Evaluated Products
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
                d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
              />
            </svg>
          </Link>
          <Link
            href="/methodology"
            className="inline-flex items-center gap-2 rounded-full border border-white/30 bg-white/10 px-6 py-3 font-semibold text-white backdrop-blur-sm transition-all hover:bg-white/20"
          >
            See Our Evaluation Criteria
          </Link>
        </div>
      </div>
    </section>
  );
}
