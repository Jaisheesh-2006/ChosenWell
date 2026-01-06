import type { Metadata } from "next";
import Link from "next/link";
import Breadcrumbs from "../components/Breadcrumbs";

export const metadata: Metadata = {
  title: "Contact Us",
  description:
    "Get in touch with ChosenWell. Reach out for ingredient corrections, methodology questions, feedback, or brand submissions.",
  openGraph: {
    title: "Contact Us | ChosenWell",
    description:
      "Get in touch with us for corrections, feedback, or brand submissions.",
  },
};

export default function ContactPage() {
  return (
    <div className="mx-auto max-w-4xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs items={[{ label: "Contact Us" }]} />

      {/* Header */}
      <header className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          Contact Us
        </h1>
        <p className="mt-4 text-lg text-slate-600 dark:text-slate-400">
          We keep our communication simple and intentional. Please choose the
          channel that best fits your purpose below.
        </p>
      </header>

      {/* Contact Methods */}
      <div className="grid gap-6 md:grid-cols-2">
        {/* Email */}
        <section className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
          <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-cyan-500/20 to-emerald-500/20 text-cyan-600 dark:text-cyan-400">
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
                d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75"
              />
            </svg>
          </div>
          <h2 className="mt-4 text-xl font-semibold text-slate-900 dark:text-white">
            Email (Primary)
          </h2>
          <a
            href="mailto:chosenwell0501@gmail.com"
            className="mt-2 block text-cyan-600 hover:text-cyan-700 dark:text-cyan-400 dark:hover:text-cyan-300"
          >
            chosenwell0501@gmail.com
          </a>
          <p className="mt-4 text-sm text-slate-600 dark:text-slate-400">
            Email us for:
          </p>
          <ul className="mt-2 space-y-1 text-sm text-slate-600 dark:text-slate-400">
            <li>• Ingredient corrections or factual errors</li>
            <li>• Questions about how a product was evaluated</li>
            <li>• Feedback on our criteria or methodology</li>
            <li>• Brand submissions (if criteria is met)</li>
          </ul>
          <p className="mt-4 text-sm text-slate-500 dark:text-slate-500">
            We usually respond within 48–72 hours.
          </p>
        </section>

        {/* Instagram */}
        <section className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
          <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-pink-500/20 to-purple-500/20 text-pink-600 dark:text-pink-400">
            <svg className="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
              <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" />
            </svg>
          </div>
          <h2 className="mt-4 text-xl font-semibold text-slate-900 dark:text-white">
            Instagram
          </h2>
          <a
            href="https://www.instagram.com/chosenwell_51/"
            target="_blank"
            rel="noopener noreferrer"
            className="mt-2 block text-pink-600 hover:text-pink-700 dark:text-pink-400 dark:hover:text-pink-300"
          >
            @chosenwell_51
          </a>
          <p className="mt-4 text-sm text-slate-600 dark:text-slate-400">
            Use Instagram for:
          </p>
          <ul className="mt-2 space-y-1 text-sm text-slate-600 dark:text-slate-400">
            <li>• Updates and announcements</li>
            <li>• New category launches</li>
            <li>• General questions and discussions</li>
          </ul>
          <p className="mt-4 text-sm text-slate-500 dark:text-slate-500">
            Note: We don&apos;t review products over DMs.
          </p>
        </section>

        {/* Twitter */}
        <section className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
          <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br from-sky-500/20 to-blue-500/20 text-sky-600 dark:text-sky-400">
            <svg className="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
              <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
            </svg>
          </div>
          <h2 className="mt-4 text-xl font-semibold text-slate-900 dark:text-white">
            Twitter / X
          </h2>
          <a
            href="https://x.com/ChosenWell_51"
            target="_blank"
            rel="noopener noreferrer"
            className="mt-2 block text-sky-600 hover:text-sky-700 dark:text-sky-400 dark:hover:text-sky-300"
          >
            @ChosenWell_51
          </a>
          <p className="mt-4 text-sm text-slate-600 dark:text-slate-400">
            Use Twitter for:
          </p>
          <ul className="mt-2 space-y-1 text-sm text-slate-600 dark:text-slate-400">
            <li>• Quick clarifications</li>
            <li>• Public conversations on ingredients & safety</li>
            <li>• Platform updates</li>
          </ul>
        </section>

        {/* Brand Submissions */}
        <section className="rounded-2xl border border-emerald-200 bg-emerald-50 p-6 dark:border-emerald-500/20 dark:bg-emerald-500/10">
          <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-emerald-500/20 text-emerald-600 dark:text-emerald-400">
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
          </div>
          <h2 className="mt-4 text-xl font-semibold text-slate-900 dark:text-white">
            Brand Submissions
          </h2>
          <p className="mt-4 text-sm text-slate-600 dark:text-slate-400">
            We review products <strong>only</strong> if they meet our baseline
            criteria. Before contacting us, please ensure:
          </p>
          <ul className="mt-2 space-y-1 text-sm text-slate-600 dark:text-slate-400">
            <li>• Full ingredient list (INCI) is publicly available</li>
            <li>• No hidden &ldquo;proprietary base&rdquo; formulations</li>
            <li>• Clear positioning for long-term, everyday use</li>
          </ul>
          <p className="mt-4 text-sm font-medium text-slate-900 dark:text-white">
            Submissions without ingredient transparency will not be reviewed.
          </p>
        </section>
      </div>

      {/* Corrections Section */}
      <section className="mt-12 rounded-2xl border border-amber-200 bg-amber-50 p-8 dark:border-amber-500/20 dark:bg-amber-500/10">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          Corrections are welcome
        </h2>
        <p className="mt-4 text-slate-600 dark:text-slate-400">
          If you notice:
        </p>
        <ul className="mt-2 space-y-1 text-slate-600 dark:text-slate-400">
          <li>• An incorrect ingredient</li>
          <li>• Outdated information</li>
          <li>• A mismatch between claims and formulation</li>
        </ul>
        <p className="mt-4 text-slate-600 dark:text-slate-400">
          Please email us. Corrections help keep this platform honest and
          useful.
        </p>
      </section>

      {/* Quick Note */}
      <section className="mt-12 text-center">
        <p className="text-slate-600 dark:text-slate-400">
          We are a small team and we read everything carefully.
        </p>
        <p className="mt-2 text-slate-600 dark:text-slate-400">
          Clear, specific messages help us respond faster.
        </p>
        <p className="mt-4 font-medium text-slate-900 dark:text-white">
          Thank you for helping us build something trustworthy.
        </p>
      </section>

      {/* CTA */}
      <section className="mt-12 rounded-2xl bg-gradient-to-r from-cyan-500/10 via-emerald-500/10 to-cyan-500/10 p-8 text-center">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          Want to learn more?
        </h2>
        <p className="mt-4 text-slate-600 dark:text-slate-400">
          Read about who we are and how we evaluate products.
        </p>
        <div className="mt-6 flex flex-wrap justify-center gap-4">
          <Link
            href="/about"
            className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-6 py-3 font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
          >
            About Us
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
  );
}
