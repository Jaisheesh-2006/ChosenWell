import type { Metadata } from "next";
import Link from "next/link";
import Breadcrumbs from "../components/Breadcrumbs";

export const metadata: Metadata = {
  title: "About Us - Our Mission & Values",
  description:
    "Learn about ChosenWell - we curate everyday health products that are genuinely safe, transparent, and suitable for long-term use in India. No sponsored rankings, no hype.",
  alternates: {
    canonical: "/about",
  },
  openGraph: {
    title: "About Us | ChosenWell",
    description:
      "We curate everyday health products that are genuinely safe, transparent, and suitable for long-term use in India.",
    url: "/about",
  },
};

export default function AboutPage() {
  return (
    <div className="relative mx-auto max-w-4xl px-4 py-12 sm:px-6 lg:px-8 sm:py-16 lg:py-20">
      <div className="absolute inset-0 -z-10 bg-[radial-gradient(ellipse_at_top,_var(--tw-gradient-stops))] from-primary-lighter/40 via-background to-background" />
      <Breadcrumbs items={[{ label: "About Us" }]} />

      {/* Header */}
      <header className="mb-16 mt-8 md:mb-20 text-center">
        <div className="mb-4 inline-flex items-center rounded-full bg-primary-lighter px-3 py-1 text-xs font-semibold uppercase tracking-widest text-primary">
          Our Story
        </div>
        <h1 className="page-heading mx-auto text-balance">
          About Us
        </h1>
      </header>

      {/* Content */}
      <div className="prose prose-slate max-w-none">
        {/* Not a Store */}
        <section className="card card-hover relative mb-16 overflow-hidden border-l-4 border-l-primary p-8 md:p-10 text-center md:text-left">
          <div className="absolute -right-10 -top-10 h-40 w-40 rounded-full bg-primary-lighter/60 blur-3xl" />
          <h2 className="relative mt-0 font-display text-3xl font-bold text-text">
            We are not an online store.
          </h2>
          <div className="mt-4 space-y-2 text-text-muted">
            <p>We don&apos;t sell products.</p>
            <p>We don&apos;t run sponsored rankings.</p>
            <p>We don&apos;t list everything that&apos;s popular.</p>
          </div>
          <p className="mt-6 text-text-muted">
            This platform exists for one reason: to make it easier to find{" "}
            <strong className="text-text">
              everyday health products that are genuinely safe, transparent, and
              suitable for long-term use in the Indian context
            </strong>
            .
          </p>
        </section>

        {/* The Problem */}
        <section className="mb-16 rounded-2xl bg-surface-raised p-8 shadow-sm border border-border">
          <h2 className="section-heading text-center md:text-left">
            The problem we&apos;re trying to solve
          </h2>
          <p className="mt-6 text-lg text-text-muted">
            In India, &ldquo;herbal&rdquo;, &ldquo;natural&rdquo;, and
            &ldquo;chemical-free&rdquo; are everywhere — but clarity is not.
          </p>
          <div className="mt-4 space-y-2 text-text-muted">
            <p>Ingredient lists are confusing.</p>
            <p>Marketing claims are loud.</p>
            <p>Popular brands are not always the safest ones.</p>
          </div>
          <p className="mt-4 text-text-muted">
            Most people don&apos;t want miracle results. They just want products
            they can use{" "}
            <strong className="text-text">
              every day without worrying
            </strong>
            .
          </p>
          <p className="mt-4 text-text-muted">
            We built this platform to filter the noise.
          </p>
        </section>

        {/* How Products Get Listed */}
        <section className="card card-hover mb-16 border-primary/20 bg-gradient-to-br from-primary-lighter to-background p-8 md:p-10">
          <h2 className="mt-0 section-heading text-primary">
            How products get listed here
          </h2>
          <p className="mt-4 text-text-muted">
            We curate before we publish.
          </p>
          <p className="mt-4 text-text-muted">
            A product is listed only if it meets our non-negotiable criteria,
            which include:
          </p>
          <ul className="mt-4 space-y-2 text-text-muted">
            <li>Clear and complete ingredient disclosure</li>
            <li>No hidden &ldquo;base q.s.&rdquo; or vague formulations</li>
            <li>
              Explicit exclusion of ingredients we consider high-risk for
              long-term use
            </li>
            <li>Formulation logic that matches the product&apos;s claims</li>
            <li>Suitability for Indian water, climate, and usage patterns</li>
          </ul>
          <p className="mt-6 text-text-muted">
            This is also why you may{" "}
            <strong className="text-text">not</strong> see
            many popular brands here. Fewer products is intentional.
          </p>
        </section>

        {/* Our Bias */}
        <section className="mb-16 px-4 md:px-0">
          <h2 className="section-heading">
            Our bias (we&apos;re explicit about it)
          </h2>
          <p className="mt-6 text-lg text-text-muted">
            We are biased towards:
          </p>
          <ul className="mt-4 space-y-2 text-text-muted">
            <li>
              <strong className="text-text">
                Safety over speed
              </strong>
            </li>
            <li>
              <strong className="text-text">
                Transparency over branding
              </strong>
            </li>
            <li>
              <strong className="text-text">
                Long-term use over instant results
              </strong>
            </li>
          </ul>
          <p className="mt-4 text-text-muted">
            We do not try to rank &ldquo;the best product for everyone&rdquo;.
            We help you understand{" "}
            <strong className="text-text">why</strong> a
            product is listed, and{" "}
            <strong className="text-text">
              who it may or may not be suitable for
            </strong>
            .
          </p>
        </section>

        {/* How We Make Money */}
        <section className="card card-hover relative mb-16 overflow-hidden p-8 md:p-10">
          <div className="absolute -bottom-10 -right-10 z-0 h-40 w-40 rounded-full bg-accent/15 blur-3xl" />
          <div className="relative z-10">
            <h2 className="mt-0 section-heading">
              How we make money
            </h2>
          <p className="mt-4 text-text-muted">
            Some links on this site may be affiliate links.
          </p>
          <p className="mt-4 text-text-muted">
            This never affects:
          </p>
          <ul className="mt-4 space-y-2 text-text-muted">
            <li>Which products are listed</li>
            <li>How they are scored</li>
            <li>How they are described</li>
          </ul>
          <p className="mt-6 font-medium text-text">
            If a product doesn&apos;t meet our criteria, it doesn&apos;t get
            listed — paid or not.
          </p>
          </div>
        </section>

        {/* Disclaimer */}
        <section className="card mb-16 border-l-4 border-l-amber-400 bg-gradient-to-r from-amber-50/80 to-transparent p-8 md:p-10">
          <h2 className="mt-0 section-heading text-amber-900">
            What this platform is not
          </h2>
          <ul className="mt-4 space-y-2 text-text-muted">
            <li>We do not offer medical advice</li>
            <li>We do not diagnose conditions</li>
            <li>We do not claim to treat or cure diseases</li>
          </ul>
          <p className="mt-6 text-text-muted">
            The information here is for{" "}
            <strong className="text-text">
              general awareness and product education only
            </strong>
            .
          </p>
          <p className="mt-4 text-text-muted">
            If you have a medical condition, allergy, skin disorder, or ongoing
            health concern,{" "}
            <strong className="text-text">
              please consult a qualified doctor or healthcare professional
              before using any product
            </strong>
            .
          </p>
          <p className="mt-4 text-text-muted">
            Always patch-test new products and follow professional advice when
            needed.
          </p>
        </section>

        {/* Our Commitment */}
        <section className="mb-16 text-center md:text-left">
          <h2 className="section-heading">
            Our commitment
          </h2>
          <p className="mt-4 text-text-muted">
            If something is listed here, it means we&apos;ve done the work to
            understand it. If something is missing, it&apos;s usually because it
            didn&apos;t clear the bar.
          </p>
          <p className="mt-4 text-text-muted">
            If you spot an error, outdated information, or something that
            doesn&apos;t align with our criteria — we want to hear from you.
          </p>
          <p className="mt-4 font-medium text-text">
            Trust is built by being open, careful, and willing to correct
            mistakes.
          </p>
        </section>

        {/* CTA */}
        <section className="cta-section overflow-hidden relative shadow-xl">
          <div className="absolute inset-0 bg-hero-start opacity-90 mix-blend-multiply" />
          <div className="absolute -top-24 -left-24 h-64 w-64 rounded-full bg-primary-light/20 blur-3xl" />
          <div className="absolute -bottom-24 -right-24 h-64 w-64 rounded-full bg-accent/20 blur-3xl" />
          <div className="relative z-10">
            <h2 className="mt-0 text-3xl font-display text-white">
              Ready to explore?
            </h2>
          <p className="mt-4 text-white/70">
            Browse our curated collection of health products or learn about our
            evaluation methodology.
          </p>
          <div className="mt-6 flex flex-wrap justify-center gap-4">
            <Link
              href="/products"
              className="btn-primary"
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
              className="btn-secondary"
            >
              Our Methodology
            </Link>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}
