import type { Metadata } from "next";
import Link from "next/link";
import { getMethodology } from "../lib/api";
import { Methodology } from "../lib/types";
import Breadcrumbs from "../components/Breadcrumbs";

export const metadata: Metadata = {
  title: "Our Methodology - How We Verify Products",
  description:
    "Learn how ChosenWell evaluates health products. Our transparent methodology covers ingredient quality, certifications, full INCI disclosure, and value for money.",
  alternates: {
    canonical: "/methodology",
  },
  openGraph: {
    title: "Our Methodology | ChosenWell",
    description:
      "Learn how we evaluate and verify health products with our transparent, unbiased methodology.",
    url: "/methodology",
  },
};

// Fallback methodology data
const fallbackMethodology: Methodology = {
  version: "1.0",
  summary:
    "Our evaluation methodology is designed to give you actionable, trustworthy information about health products. We analyze each product across multiple dimensions including ingredient quality, safety certifications, ingredient transparency, and overall value.",
  last_updated: new Date().toISOString().split("T")[0],
};

async function getMethodologyData(): Promise<Methodology> {
  try {
    return await getMethodology();
  } catch {
    return fallbackMethodology;
  }
}

export default async function MethodologyPage() {
  const methodology = await getMethodologyData();

  return (
    <div className="mx-auto max-w-4xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs items={[{ label: "Methodology" }]} />

      {/* Header */}
      <header className="mb-12">
        <p className="text-sm font-medium uppercase tracking-wider text-cyan-600 dark:text-cyan-400">
          Version {methodology.version}
        </p>
        <h1 className="mt-2 text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          How We Verify Products
        </h1>
        {/* <p className="mt-6 text-xl text-slate-600 dark:text-slate-300">
          {methodology.summary}
        </p> */}
      </header>

      {/* Our Approach */}
      <section className="mb-16">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          Our Verification Process
        </h2>
        <p className="mt-4 text-slate-600 dark:text-slate-400">
          Content-first evaluation focusing on ingredient safety, efficacy for
          stated concerns, and long-term health. All products must pass a strict
          safety gate before being featured.
        </p>

        <div className="mt-6 space-y-4">
          <p className="font-medium text-slate-800 dark:text-slate-200">
            We evaluate:
          </p>
          <ol className="list-decimal list-inside space-y-3 text-slate-600 dark:text-slate-400">
            <li>
              <span className="font-semibold text-slate-800 dark:text-slate-200">
                Ingredient Safety & Transparency
              </span>
              <span className="text-slate-500 dark:text-slate-400">
                {" "}
                — Full INCI disclosure required, no hidden bases
              </span>
            </li>
            <li>
              <span className="font-semibold text-slate-800 dark:text-slate-200">
                Formulation Quality
              </span>
              <span className="text-slate-500 dark:text-slate-400">
                {" "}
                — Appropriate actives at meaningful concentrations
              </span>
            </li>
            <li>
              <span className="font-semibold text-slate-800 dark:text-slate-200">
                Efficacy for Concern
              </span>
              <span className="text-slate-500 dark:text-slate-400">
                {" "}
                — Evidence-based effectiveness for primary concerns
              </span>
            </li>
            <li>
              <span className="font-semibold text-slate-800 dark:text-slate-200">
                Long-term Health
              </span>
              <span className="text-slate-500 dark:text-slate-400">
                {" "}
                — No dependency cycles, rebound effects, or cumulative harm
              </span>
            </li>
            <li>
              <span className="font-semibold text-slate-800 dark:text-slate-200">
                Certifications & Trust Signals
              </span>
              <span className="text-slate-500 dark:text-slate-400">
                {" "}
                — Third-party validations valued
              </span>
            </li>
          </ol>
        </div>
      </section>

      {/* Detailed Explanation */}
      <section className="mb-16 space-y-8">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          What We Evaluate
        </h2>

        <div className="grid gap-6 sm:grid-cols-2">
          {[
            {
              title: "Ingredient Quality",
              icon: (
                <svg
                  className="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={1.5}
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M9.75 3.104v5.714a2.25 2.25 0 01-.659 1.591L5 14.5M9.75 3.104c-.251.023-.501.05-.75.082m.75-.082a24.301 24.301 0 014.5 0m0 0v5.714c0 .597.237 1.17.659 1.591L19.8 15.3M14.25 3.104c.251.023.501.05.75.082M19.8 15.3l-1.57.393A9.065 9.065 0 0112 15a9.065 9.065 0 00-6.23.693L5 14.5m14.8.8l1.402 1.402c1.232 1.232.65 3.318-1.067 3.611A48.309 48.309 0 0112 21c-2.773 0-5.491-.235-8.135-.687-1.718-.293-2.3-2.379-1.067-3.61L5 14.5"
                  />
                </svg>
              ),
              description:
                "We analyze active and inactive ingredients, looking for beneficial compounds and flagging potentially harmful additives.",
            },
            {
              title: "Certifications",
              icon: (
                <svg
                  className="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={1.5}
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z"
                  />
                </svg>
              ),
              description:
                "We verify certifications (FSSAI, USDA Organic, BIS, etc.) and check if products meet established safety standards relevant to India.",
            },
            {
              title: "Ingredient Transparency",
              icon: (
                <svg
                  className="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={1.5}
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z"
                  />
                </svg>
              ),
              description:
                "We require full INCI disclosure from all brands. No hidden 'Base Q.S.' or vague ingredient labeling is accepted.",
            },
            {
              title: "Value for Money",
              icon: (
                <svg
                  className="h-6 w-6"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={1.5}
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                  />
                </svg>
              ),
              description:
                "We consider price relative to quality, helping you find the best products at every price point.",
            },
          ].map((item) => (
            <div
              key={item.title}
              className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50"
            >
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-cyan-500/20 to-emerald-500/20 text-cyan-600 dark:text-cyan-400">
                {item.icon}
              </div>
              <h3 className="mt-4 text-lg font-semibold text-slate-900 dark:text-white">
                {item.title}
              </h3>
              <p className="mt-2 text-sm text-slate-600 dark:text-slate-400">
                {item.description}
              </p>
            </div>
          ))}
        </div>
      </section>

      {/* What We Look For */}
      <section className="mb-16">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          Our Verification Standards
        </h2>
        <p className="mt-4 text-slate-600 dark:text-slate-400">
          Products must meet these criteria to be featured on our platform.
        </p>

        <div className="mt-8 space-y-4">
          {[
            {
              icon: "✓",
              label: "Full Ingredient Disclosure",
              description:
                "Complete INCI list with no hidden ingredients or vague terms",
            },
            {
              icon: "✓",
              label: "Valid Certifications",
              description:
                "Verified regulatory compliance (FSSAI, BIS, etc.) for Indian market",
            },
            {
              icon: "✓",
              label: "No Harmful Additives",
              description:
                "Free from ingredients flagged by health authorities",
            },
            {
              icon: "✓",
              label: "Honest Marketing",
              description: "Claims that match the actual product formulation",
            },
            {
              icon: "✓",
              label: "Clear Pricing",
              description: "Transparent pricing with no hidden costs",
            },
          ].map((item) => (
            <div
              key={item.label}
              className="flex items-start gap-4 rounded-xl border border-slate-200 bg-white p-4 shadow-sm dark:border-white/10 dark:bg-slate-900/30"
            >
              <div className="flex h-8 w-8 items-center justify-center rounded-full bg-gradient-to-br from-emerald-500 to-green-500 text-white font-bold text-sm">
                {item.icon}
              </div>
              <div>
                <p className="font-medium text-slate-900 dark:text-white">
                  {item.label}
                </p>
                <p className="text-sm text-slate-600 dark:text-slate-400">
                  {item.description}
                </p>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* How we evaluate products in each category - SEO Rule 4 compliance */}
      <section className="mb-16">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          How we evaluate products in each category
        </h2>
        <p className="mt-4 text-slate-600 dark:text-slate-400">
          Our evaluation framework is applied consistently across different
          product categories, with category-specific considerations for
          ingredients, safety, and efficacy.
        </p>
        <ul className="mt-6 space-y-3">
          <li>
            <a
              href="/categories/shampoo"
              className="inline-flex items-center gap-2 text-cyan-600 dark:text-cyan-400 hover:text-cyan-700 dark:hover:text-cyan-300 hover:underline"
            >
              How we evaluate shampoos
              <svg
                className="h-4 w-4"
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
            </a>
          </li>
          <li>
            <a
              href="/categories/sunscreen"
              className="inline-flex items-center gap-2 text-cyan-600 dark:text-cyan-400 hover:text-cyan-700 dark:hover:text-cyan-300 hover:underline"
            >
              How we evaluate sunscreens
              <svg
                className="h-4 w-4"
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
            </a>
          </li>
          <li>
            <a
              href="/categories/hair_oil"
              className="inline-flex items-center gap-2 text-cyan-600 dark:text-cyan-400 hover:text-cyan-700 dark:hover:text-cyan-300 hover:underline"
            >
              How we evaluate hair oils
              <svg
                className="h-4 w-4"
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
            </a>
          </li>
        </ul>
      </section>

      {/* CTA */}
      <section className="rounded-2xl bg-gradient-to-r from-cyan-500/10 via-emerald-500/10 to-cyan-500/10 p-8 text-center">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          Ready to find better products?
        </h2>
        <p className="mt-4 text-slate-600 dark:text-slate-400">
          Browse our curated collection of health products, all evaluated with
          this methodology.
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
            href="/categories"
            className="inline-flex items-center gap-2 rounded-full border border-slate-300 bg-white/80 px-6 py-3 font-semibold text-slate-900 backdrop-blur-sm transition-all hover:bg-slate-100 dark:border-white/20 dark:bg-white/5 dark:text-white dark:hover:bg-white/10"
          >
            View Categories
          </Link>
        </div>
      </section>

            {/* Last Updated */}
      {methodology.last_updated && (
        <section className="mt-16 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
          <p className="text-sm text-slate-600 dark:text-slate-400">
            This methodology was last updated on{" "}
            <span className="text-slate-900 dark:text-white">
              {new Date(methodology.last_updated).toLocaleDateString("en-US", {
                year: "numeric",
                month: "long",
                day: "numeric",
              })}
            </span>
          </p>
        </section>
      )}
    </div>
  );
}
