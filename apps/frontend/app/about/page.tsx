import type { Metadata } from "next";
import Link from "next/link";
import Breadcrumbs from "../components/Breadcrumbs";

export const metadata: Metadata = {
  title: "About Us",
  description:
    "Learn about ChosenWell - we curate everyday health products that are genuinely safe, transparent, and suitable for long-term use in India. No sponsored rankings, no hype.",
  openGraph: {
    title: "About Us | ChosenWell",
    description:
      "We curate everyday health products that are genuinely safe, transparent, and suitable for long-term use in India.",
  },
};

export default function AboutPage() {
  return (
    <div className="mx-auto max-w-4xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs items={[{ label: "About Us" }]} />

      {/* Header */}
      <header className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          About Us
        </h1>
      </header>

      {/* Content */}
      <div className="prose prose-slate dark:prose-invert max-w-none">
        {/* Not a Store */}
        <section className="mb-12 rounded-2xl border border-slate-200 bg-white p-8 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
          <h2 className="mt-0 text-2xl font-bold text-slate-900 dark:text-white">
            We are not an online store.
          </h2>
          <div className="mt-4 space-y-2 text-slate-600 dark:text-slate-400">
            <p>We don&apos;t sell products.</p>
            <p>We don&apos;t run sponsored rankings.</p>
            <p>We don&apos;t list everything that&apos;s popular.</p>
          </div>
          <p className="mt-6 text-slate-600 dark:text-slate-400">
            This platform exists for one reason: to make it easier to find{" "}
            <strong className="text-slate-900 dark:text-white">
              everyday health products that are genuinely safe, transparent, and
              suitable for long-term use in the Indian context
            </strong>
            .
          </p>
        </section>

        {/* The Problem */}
        <section className="mb-12">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            The problem we&apos;re trying to solve
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            In India, &ldquo;herbal&rdquo;, &ldquo;natural&rdquo;, and
            &ldquo;chemical-free&rdquo; are everywhere — but clarity is not.
          </p>
          <div className="mt-4 space-y-2 text-slate-600 dark:text-slate-400">
            <p>Ingredient lists are confusing.</p>
            <p>Marketing claims are loud.</p>
            <p>Popular brands are not always the safest ones.</p>
          </div>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            Most people don&apos;t want miracle results. They just want products
            they can use{" "}
            <strong className="text-slate-900 dark:text-white">
              every day without worrying
            </strong>
            .
          </p>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            We built this platform to filter the noise.
          </p>
        </section>

        {/* How Products Get Listed */}
        <section className="mb-12 rounded-2xl border border-emerald-200 bg-emerald-50 p-8 dark:border-emerald-500/20 dark:bg-emerald-500/10">
          <h2 className="mt-0 text-2xl font-bold text-slate-900 dark:text-white">
            How products get listed here
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            We curate before we publish.
          </p>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            A product is listed only if it meets our non-negotiable criteria,
            which include:
          </p>
          <ul className="mt-4 space-y-2 text-slate-600 dark:text-slate-400">
            <li>Clear and complete ingredient disclosure</li>
            <li>No hidden &ldquo;base q.s.&rdquo; or vague formulations</li>
            <li>
              Explicit exclusion of ingredients we consider high-risk for
              long-term use
            </li>
            <li>Formulation logic that matches the product&apos;s claims</li>
            <li>Suitability for Indian water, climate, and usage patterns</li>
          </ul>
          <p className="mt-6 text-slate-600 dark:text-slate-400">
            This is also why you may{" "}
            <strong className="text-slate-900 dark:text-white">not</strong> see
            many popular brands here. Fewer products is intentional.
          </p>
        </section>

        {/* Our Bias */}
        <section className="mb-12">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            Our bias (we&apos;re explicit about it)
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            We are biased towards:
          </p>
          <ul className="mt-4 space-y-2 text-slate-600 dark:text-slate-400">
            <li>
              <strong className="text-slate-900 dark:text-white">
                Safety over speed
              </strong>
            </li>
            <li>
              <strong className="text-slate-900 dark:text-white">
                Transparency over branding
              </strong>
            </li>
            <li>
              <strong className="text-slate-900 dark:text-white">
                Long-term use over instant results
              </strong>
            </li>
          </ul>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            We do not try to rank &ldquo;the best product for everyone&rdquo;.
            We help you understand{" "}
            <strong className="text-slate-900 dark:text-white">why</strong> a
            product is listed, and{" "}
            <strong className="text-slate-900 dark:text-white">
              who it may or may not be suitable for
            </strong>
            .
          </p>
        </section>

        {/* How We Make Money */}
        <section className="mb-12 rounded-2xl border border-slate-200 bg-slate-50 p-8 dark:border-white/10 dark:bg-slate-800/50">
          <h2 className="mt-0 text-2xl font-bold text-slate-900 dark:text-white">
            How we make money
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            Some links on this site may be affiliate links.
          </p>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            This never affects:
          </p>
          <ul className="mt-4 space-y-2 text-slate-600 dark:text-slate-400">
            <li>Which products are listed</li>
            <li>How they are scored</li>
            <li>How they are described</li>
          </ul>
          <p className="mt-6 font-medium text-slate-900 dark:text-white">
            If a product doesn&apos;t meet our criteria, it doesn&apos;t get
            listed — paid or not.
          </p>
        </section>

        {/* Disclaimer */}
        <section className="mb-12 rounded-2xl border border-amber-200 bg-amber-50 p-8 dark:border-amber-500/20 dark:bg-amber-500/10">
          <h2 className="mt-0 text-2xl font-bold text-slate-900 dark:text-white">
            What this platform is not
          </h2>
          <ul className="mt-4 space-y-2 text-slate-600 dark:text-slate-400">
            <li>We do not offer medical advice</li>
            <li>We do not diagnose conditions</li>
            <li>We do not claim to treat or cure diseases</li>
          </ul>
          <p className="mt-6 text-slate-600 dark:text-slate-400">
            The information here is for{" "}
            <strong className="text-slate-900 dark:text-white">
              general awareness and product education only
            </strong>
            .
          </p>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            If you have a medical condition, allergy, skin disorder, or ongoing
            health concern,{" "}
            <strong className="text-slate-900 dark:text-white">
              please consult a qualified doctor or healthcare professional
              before using any product
            </strong>
            .
          </p>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            Always patch-test new products and follow professional advice when
            needed.
          </p>
        </section>

        {/* Our Commitment */}
        <section className="mb-12">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            Our commitment
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            If something is listed here, it means we&apos;ve done the work to
            understand it. If something is missing, it&apos;s usually because it
            didn&apos;t clear the bar.
          </p>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            If you spot an error, outdated information, or something that
            doesn&apos;t align with our criteria — we want to hear from you.
          </p>
          <p className="mt-4 font-medium text-slate-900 dark:text-white">
            Trust is built by being open, careful, and willing to correct
            mistakes.
          </p>
        </section>

        {/* CTA */}
        <section className="rounded-2xl bg-gradient-to-r from-cyan-500/10 via-emerald-500/10 to-cyan-500/10 p-8 text-center">
          <h2 className="mt-0 text-2xl font-bold text-slate-900 dark:text-white">
            Ready to explore?
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            Browse our curated collection of health products or learn about our
            evaluation methodology.
          </p>
          <div className="mt-6 flex flex-wrap justify-center gap-4">
            <Link
              href="/products"
              className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-6 py-3 font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
            >
              Browse Products
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
              className="inline-flex items-center gap-2 rounded-full border border-slate-300 bg-white/80 px-6 py-3 font-semibold text-slate-900 backdrop-blur-sm transition-all hover:bg-slate-100 dark:border-white/20 dark:bg-white/5 dark:text-white dark:hover:bg-white/10"
            >
              Our Methodology
            </Link>
          </div>
        </section>
      </div>
    </div>
  );
}
