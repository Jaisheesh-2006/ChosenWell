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
    <div className="relative mx-auto max-w-4xl px-4 py-12 sm:px-6 lg:px-8 sm:py-16 lg:py-20">
      <div className="absolute inset-0 -z-10 bg-[radial-gradient(ellipse_at_top,_var(--tw-gradient-stops))] from-primary-lighter/40 via-background to-background" />
      <Breadcrumbs items={[{ label: "Privacy Policy" }]} />

      {/* Header */}
      <header className="mb-16 mt-8 md:mb-20">
        <div className="mb-4 inline-flex items-center rounded-full bg-primary-lighter px-3 py-1 text-xs font-semibold uppercase tracking-widest text-primary">
          Legal
        </div>
        <h1 className="page-heading">
          Privacy Policy
        </h1>
        <div className="mt-6 flex items-center gap-2 text-sm text-text-muted">
          <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
          Last updated: January 5, 2026
        </div>
        <p className="mt-6 text-lg text-text-muted">
          ChosenWell respects your privacy. This page explains what information
          we collect, why we collect it, and how it is used.
        </p>
      </header>

      {/* Content */}
      <div className="space-y-16">
        {/* Section 1 */}
        <section>
          <h2 className="text-3xl font-display text-text border-b border-border pb-4">
            1. Information we collect
          </h2>

          <div className="mt-8 space-y-6">
            <div className="card card-hover p-6 md:p-8">
              <h3 className="text-lg font-semibold text-text">
                a) Information you provide voluntarily
              </h3>
              <p className="mt-3 text-text-muted">
                We may collect limited information if you choose to contact us,
                such as:
              </p>
              <ul className="mt-3 space-y-1 text-text-muted">
                <li>• Your name (if provided)</li>
                <li>• Your email address</li>
                <li>• The content of your message</li>
              </ul>
              <p className="mt-3 text-sm text-text-muted">
                This typically happens when you email us or submit a contact
                form.
              </p>
            </div>

            <div className="card card-hover p-6 md:p-8">
              <h3 className="text-lg font-semibold text-text">
                b) Automatically collected information
              </h3>
              <p className="mt-3 text-text-muted">
                When you visit ChosenWell, we may automatically collect basic
                technical information, including:
              </p>
              <ul className="mt-3 space-y-1 text-text-muted">
                <li>• Browser type and device information</li>
                <li>• Pages visited and time spent</li>
                <li>• Approximate location (city or country level)</li>
                <li>• Referring website</li>
              </ul>
              <p className="mt-3 text-sm text-text-muted">
                This data is collected via standard analytics tools to help us
                understand how the site is used.
              </p>
            </div>
          </div>
        </section>

        {/* Section 2 */}
        <section>
          <h2 className="text-3xl font-display text-text border-b border-border pb-4">
            2. How we use your information
          </h2>
          <p className="mt-8 text-text-muted">
            We use information only to:
          </p>
          <ul className="mt-3 space-y-1 text-text-muted">
            <li>• Respond to queries or feedback</li>
            <li>• Improve site performance and content</li>
            <li>• Understand which pages are useful to users</li>
            <li>• Maintain site security and reliability</li>
          </ul>
          <div className="mt-6 rounded-xl border border-primary/20 bg-primary/5 p-4">
            <p className="font-medium text-text">
              We do NOT:
            </p>
            <ul className="mt-2 space-y-1 text-text-muted">
              <li>• Sell personal data</li>
              <li>• Run targeted advertising</li>
              <li>• Collect sensitive personal or health information</li>
            </ul>
          </div>
        </section>

        {/* Section 3 */}
        <section>
          <h2 className="text-3xl font-display text-text border-b border-border pb-4">
            3. Cookies
          </h2>
          <p className="mt-8 text-text-muted">
            ChosenWell may use cookies or similar technologies to:
          </p>
          <ul className="mt-3 space-y-1 text-text-muted">
            <li>• Measure traffic and usage patterns</li>
            <li>• Ensure basic site functionality</li>
          </ul>
          <p className="mt-4 text-sm text-text-muted">
            You can control or disable cookies through your browser settings.
          </p>
        </section>

        {/* Section 4 */}
        <section>
          <h2 className="text-3xl font-display text-text border-b border-border pb-4">
            4. Third-party services
          </h2>
          <p className="mt-8 text-text-muted">
            We may use trusted third-party services such as:
          </p>
          <ul className="mt-3 space-y-1 text-text-muted">
            <li>• Website analytics (e.g., Google Analytics)</li>
            <li>• Hosting and infrastructure providers</li>
          </ul>
          <p className="mt-4 text-text-muted">
            These services may process limited data as required to provide their
            functionality. We do not control how third parties independently use
            data, and their use is governed by their own privacy policies.
          </p>
        </section>

        {/* Section 5 */}
        <section>
          <h2 className="text-3xl font-display text-text border-b border-border pb-4">
            5. Affiliate links
          </h2>
          <p className="mt-8 text-text-muted">
            Some pages may contain affiliate links. If you click such a link,
            the external site may collect data according to their own privacy
            policies.
          </p>
          <p className="mt-3 text-text-muted">
            ChosenWell does not receive access to your personal information from
            affiliate partners.
          </p>
        </section>

        {/* Section 6 */}
        <section>
          <h2 className="text-3xl font-display text-text border-b border-border pb-4">
            6. Data security
          </h2>
          <p className="mt-8 text-text-muted">
            We take reasonable steps to protect the information we collect.
            However, no method of transmission over the internet is completely
            secure.
          </p>
        </section>

        {/* Section 7 */}
        <section>
          <h2 className="text-3xl font-display text-text border-b border-border pb-4">
            7. Children&apos;s privacy
          </h2>
          <p className="mt-8 text-text-muted">
            ChosenWell is not intended for children under the age of 13, and we
            do not knowingly collect personal data from children.
          </p>
        </section>

        {/* Section 8 - Medical Disclaimer */}
        <section className="card border-l-4 border-l-amber-400 bg-gradient-to-r from-amber-50/80 to-transparent p-8 md:p-10">
          <h2 className="text-3xl font-display text-amber-900 border-b border-amber-200/50 pb-4">
            8. Medical disclaimer
          </h2>
          <p className="mt-8 text-text-muted">
            The content on ChosenWell is provided for general informational
            purposes only.
          </p>
          <p className="mt-3 font-medium text-text">
            It is NOT medical advice, diagnosis, or treatment.
          </p>
          <p className="mt-3 text-text-muted">
            Always consult a qualified healthcare professional before making
            decisions related to your health or medical conditions.
          </p>
        </section>

        {/* Section 9 */}
        <section>
          <h2 className="text-3xl font-display text-text border-b border-border pb-4">
            9. Changes to this policy
          </h2>
          <p className="mt-8 text-text-muted">
            We may update this Privacy Policy from time to time. Any changes
            will be posted on this page with an updated date.
          </p>
        </section>

        {/* Section 10 - Contact */}
        <section className="card card-hover relative overflow-hidden bg-surface-raised p-8 md:p-10 border border-border">
          <div className="absolute -left-16 -top-16 h-48 w-48 rounded-full bg-primary-lighter/30 blur-3xl z-0" />
          <div className="relative z-10">
            <h2 className="text-3xl font-display text-text border-b border-border pb-4">
              10. Contact us
            </h2>
            <p className="mt-8 text-text-muted">
            If you have questions about this Privacy Policy or how your data is
            handled, you can contact us at:
          </p>
          <a
            href="mailto:chosenwell0501@gmail.com"
            className="mt-4 inline-flex items-center gap-2 text-primary hover:text-primary-light"
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
          </div>
        </section>

        {/* CTA */}
        <section className="mt-16 cta-section relative overflow-hidden shadow-xl">
          <div className="absolute inset-0 bg-hero-start opacity-90 mix-blend-multiply" />
          <div className="absolute -left-24 -top-24 h-64 w-64 rounded-full bg-primary-light/20 blur-3xl" />
          <div className="absolute -bottom-24 -right-24 h-64 w-64 rounded-full bg-accent/20 blur-3xl" />
          <div className="relative z-10">
            <h2 className="text-3xl font-display text-white">
              Have more questions?
            </h2>
          <p className="mt-4 text-white/70">
            Learn more about who we are and how we evaluate products.
          </p>
          <div className="mt-6 flex flex-wrap justify-center gap-4">
            <Link
              href="/about"
              className="btn-primary"
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
              className="btn-secondary"
            >
              Contact Us
            </Link>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}
