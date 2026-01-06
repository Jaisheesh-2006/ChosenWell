import type { Metadata } from "next";
import Link from "next/link";
import Breadcrumbs from "../components/Breadcrumbs";

export const metadata: Metadata = {
  title: "Privacy Policy - Data Protection & Your Rights",
  description:
    "ChosenWell Privacy Policy - Learn how we collect, use, and protect your information. We respect your privacy and do not sell personal data.",
  alternates: {
    canonical: "/privacy",
  },
  openGraph: {
    title: "Privacy Policy | ChosenWell",
    description:
      "Learn how ChosenWell collects, uses, and protects your information.",
    url: "/privacy",
  },
};

export default function PrivacyPage() {
  return (
    <div className="mx-auto max-w-4xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs items={[{ label: "Privacy Policy" }]} />

      {/* Header */}
      <header className="mb-12">
        <h1 className="text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          Privacy Policy
        </h1>
        <p className="mt-4 text-sm text-slate-500 dark:text-slate-400">
          Last updated: January 5, 2026
        </p>
        <p className="mt-4 text-lg text-slate-600 dark:text-slate-400">
          ChosenWell respects your privacy. This page explains what information
          we collect, why we collect it, and how it is used.
        </p>
      </header>

      {/* Content */}
      <div className="space-y-12">
        {/* Section 1 */}
        <section>
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            1. Information we collect
          </h2>

          <div className="mt-6 space-y-6">
            <div className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
              <h3 className="text-lg font-semibold text-slate-900 dark:text-white">
                a) Information you provide voluntarily
              </h3>
              <p className="mt-3 text-slate-600 dark:text-slate-400">
                We may collect limited information if you choose to contact us,
                such as:
              </p>
              <ul className="mt-3 space-y-1 text-slate-600 dark:text-slate-400">
                <li>• Your name (if provided)</li>
                <li>• Your email address</li>
                <li>• The content of your message</li>
              </ul>
              <p className="mt-3 text-sm text-slate-500 dark:text-slate-500">
                This typically happens when you email us or submit a contact
                form.
              </p>
            </div>

            <div className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
              <h3 className="text-lg font-semibold text-slate-900 dark:text-white">
                b) Automatically collected information
              </h3>
              <p className="mt-3 text-slate-600 dark:text-slate-400">
                When you visit ChosenWell, we may automatically collect basic
                technical information, including:
              </p>
              <ul className="mt-3 space-y-1 text-slate-600 dark:text-slate-400">
                <li>• Browser type and device information</li>
                <li>• Pages visited and time spent</li>
                <li>• Approximate location (city or country level)</li>
                <li>• Referring website</li>
              </ul>
              <p className="mt-3 text-sm text-slate-500 dark:text-slate-500">
                This data is collected via standard analytics tools to help us
                understand how the site is used.
              </p>
            </div>
          </div>
        </section>

        {/* Section 2 */}
        <section>
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            2. How we use your information
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            We use information only to:
          </p>
          <ul className="mt-3 space-y-1 text-slate-600 dark:text-slate-400">
            <li>• Respond to queries or feedback</li>
            <li>• Improve site performance and content</li>
            <li>• Understand which pages are useful to users</li>
            <li>• Maintain site security and reliability</li>
          </ul>
          <div className="mt-6 rounded-xl border border-emerald-200 bg-emerald-50 p-4 dark:border-emerald-500/20 dark:bg-emerald-500/10">
            <p className="font-medium text-slate-900 dark:text-white">
              We do NOT:
            </p>
            <ul className="mt-2 space-y-1 text-slate-600 dark:text-slate-400">
              <li>• Sell personal data</li>
              <li>• Run targeted advertising</li>
              <li>• Collect sensitive personal or health information</li>
            </ul>
          </div>
        </section>

        {/* Section 3 */}
        <section>
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            3. Cookies
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            ChosenWell may use cookies or similar technologies to:
          </p>
          <ul className="mt-3 space-y-1 text-slate-600 dark:text-slate-400">
            <li>• Measure traffic and usage patterns</li>
            <li>• Ensure basic site functionality</li>
          </ul>
          <p className="mt-4 text-sm text-slate-500 dark:text-slate-500">
            You can control or disable cookies through your browser settings.
          </p>
        </section>

        {/* Section 4 */}
        <section>
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            4. Third-party services
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            We may use trusted third-party services such as:
          </p>
          <ul className="mt-3 space-y-1 text-slate-600 dark:text-slate-400">
            <li>• Website analytics (e.g., Google Analytics)</li>
            <li>• Hosting and infrastructure providers</li>
          </ul>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            These services may process limited data as required to provide their
            functionality. We do not control how third parties independently use
            data, and their use is governed by their own privacy policies.
          </p>
        </section>

        {/* Section 5 */}
        <section>
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            5. Affiliate links
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            Some pages may contain affiliate links. If you click such a link,
            the external site may collect data according to their own privacy
            policies.
          </p>
          <p className="mt-3 text-slate-600 dark:text-slate-400">
            ChosenWell does not receive access to your personal information from
            affiliate partners.
          </p>
        </section>

        {/* Section 6 */}
        <section>
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            6. Data security
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            We take reasonable steps to protect the information we collect.
            However, no method of transmission over the internet is completely
            secure.
          </p>
        </section>

        {/* Section 7 */}
        <section>
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            7. Children&apos;s privacy
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            ChosenWell is not intended for children under the age of 13, and we
            do not knowingly collect personal data from children.
          </p>
        </section>

        {/* Section 8 - Medical Disclaimer */}
        <section className="rounded-2xl border border-amber-200 bg-amber-50 p-6 dark:border-amber-500/20 dark:bg-amber-500/10">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            8. Medical disclaimer
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            The content on ChosenWell is provided for general informational
            purposes only.
          </p>
          <p className="mt-3 font-medium text-slate-900 dark:text-white">
            It is NOT medical advice, diagnosis, or treatment.
          </p>
          <p className="mt-3 text-slate-600 dark:text-slate-400">
            Always consult a qualified healthcare professional before making
            decisions related to your health or medical conditions.
          </p>
        </section>

        {/* Section 9 */}
        <section>
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            9. Changes to this policy
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            We may update this Privacy Policy from time to time. Any changes
            will be posted on this page with an updated date.
          </p>
        </section>

        {/* Section 10 - Contact */}
        <section className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm dark:border-white/10 dark:bg-slate-900/50">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            10. Contact us
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            If you have questions about this Privacy Policy or how your data is
            handled, you can contact us at:
          </p>
          <a
            href="mailto:chosenwell0501@gmail.com"
            className="mt-4 inline-flex items-center gap-2 text-cyan-600 hover:text-cyan-700 dark:text-cyan-400 dark:hover:text-cyan-300"
          >
            <svg
              className="h-5 w-5"
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
            chosenwell0501@gmail.com
          </a>
        </section>

        {/* CTA */}
        <section className="rounded-2xl bg-gradient-to-r from-cyan-500/10 via-emerald-500/10 to-cyan-500/10 p-8 text-center">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
            Have more questions?
          </h2>
          <p className="mt-4 text-slate-600 dark:text-slate-400">
            Learn more about who we are and how we evaluate products.
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
              href="/contact"
              className="inline-flex items-center gap-2 rounded-full border border-slate-300 bg-white/80 px-6 py-3 font-semibold text-slate-900 backdrop-blur-sm transition-all hover:bg-slate-100 dark:border-white/20 dark:bg-white/5 dark:text-white dark:hover:bg-white/10"
            >
              Contact Us
            </Link>
          </div>
        </section>
      </div>
    </div>
  );
}
