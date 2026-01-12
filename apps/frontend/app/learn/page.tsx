import type { Metadata } from "next";
import Link from "next/link";
import Breadcrumbs from "../components/Breadcrumbs";

export const metadata: Metadata = {
  title: "Learn - Understand Products Before You Buy | ChosenWell",
  description:
    "Educational resources to help Indian consumers understand ingredient labels, certifications, and product claims. Make informed decisions about daily-use products.",
  alternates: {
    canonical: "/learn",
  },
  openGraph: {
    title: "Learn Before You Buy | ChosenWell",
    description:
      "Understand ingredient labels, certifications, and marketing claims. Educational content for informed product choices in India.",
    url: "/learn",
  },
};

// Article categories organized by decision context
const articleCategories = [
  {
    id: "labels",
    title: "Understanding Ingredient Labels",
    description:
      "Learn to read and interpret product labels. Know what's actually in your daily-use products.",
    color: "cyan",
    articles: [
      {
        slug: "what-base-qs-means",
        title: "What 'Base Q.S.' Actually Means on Indian Product Labels",
        excerpt:
          "Why this common label term hides information and what to look for instead.",
        readTime: "4 min read",
      },
      {
        slug: "ingredient-order-matters",
        title: "Why Ingredient Order Matters More Than You Think",
        excerpt:
          "How to identify if key ingredients are present in meaningful amounts.",
        readTime: "3 min read",
      },
      {
        slug: "inci-list-explained",
        title: "INCI Lists Explained: A Guide for Indian Consumers",
        excerpt:
          "Understanding the international naming system used on product labels.",
        readTime: "5 min read",
      },
    ],
  },
  {
    id: "certifications",
    title: "Certifications & What They Mean",
    description:
      "Not all certifications are equal. Learn what different certifications actually guarantee.",
    color: "emerald",
    articles: [
      {
        slug: "fssai-certification-explained",
        title:
          "What FSSAI Certification Actually Guarantees (And What It Doesn't)",
        excerpt:
          "Understanding the scope and limitations of India's food safety certification.",
        readTime: "4 min read",
      },
      {
        slug: "bis-certification-guide",
        title: "BIS Certification: When It Matters and When It's Optional",
        excerpt:
          "A guide to Bureau of Indian Standards marks on consumer products.",
        readTime: "4 min read",
      },
      {
        slug: "organic-certifications-india",
        title: "Organic Certifications in India: NPOP, USDA, and Others",
        excerpt:
          "Comparing different organic certifications and what each one verifies.",
        readTime: "5 min read",
      },
    ],
  },
  {
    id: "daily-use",
    title: "Daily-Use vs Occasional-Use",
    description:
      "Products you use every day deserve different scrutiny than occasional purchases.",
    color: "amber",
    articles: [
      {
        slug: "daily-use-ingredient-safety",
        title: "Daily-Use Products: Why Long-Term Ingredient Safety Matters",
        excerpt:
          "Understanding cumulative exposure and why daily products need extra evaluation.",
        readTime: "4 min read",
      },
      {
        slug: "preservatives-daily-products",
        title: "Are Preservatives Always Bad for Daily-Use Products?",
        excerpt:
          "A balanced look at preservatives: when they're necessary and when to be cautious.",
        readTime: "3 min read",
      },
      {
        slug: "natural-vs-synthetic",
        title: "Natural vs Synthetic: What Actually Matters for Long-Term Use?",
        excerpt:
          "Moving beyond the natural-synthetic debate to focus on what's relevant.",
        readTime: "5 min read",
      },
    ],
  },
  {
    id: "marketing",
    title: "Marketing Terms vs Reality",
    description:
      "Common marketing claims decoded. Know what terms actually mean under Indian regulations.",
    color: "rose",
    articles: [
      {
        slug: "dermatologically-tested-meaning",
        title: "What 'Dermatologically Tested' Actually Means in India",
        excerpt:
          "This common claim doesn't mean what most consumers think it does.",
        readTime: "3 min read",
      },
      {
        slug: "natural-label-india",
        title: "'Natural' Products in India: No Legal Definition Exists",
        excerpt:
          "Why the 'natural' label has no regulatory meaning and what to check instead.",
        readTime: "4 min read",
      },
      {
        slug: "clinically-proven-claims",
        title: "Decoding 'Clinically Proven' Claims on Indian Products",
        excerpt:
          "What these claims require and how to evaluate them critically.",
        readTime: "4 min read",
      },
    ],
  },
];

// Get color classes based on category
function getCategoryColors(color: string) {
  const colors: Record<
    string,
    { badge: string; border: string; text: string }
  > = {
    cyan: {
      badge: "bg-cyan-100 text-cyan-700 dark:bg-cyan-900/30 dark:text-cyan-400",
      border: "border-cyan-200 dark:border-cyan-800/30",
      text: "text-cyan-600 dark:text-cyan-400",
    },
    emerald: {
      badge:
        "bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400",
      border: "border-emerald-200 dark:border-emerald-800/30",
      text: "text-emerald-600 dark:text-emerald-400",
    },
    amber: {
      badge:
        "bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400",
      border: "border-amber-200 dark:border-amber-800/30",
      text: "text-amber-600 dark:text-amber-400",
    },
    rose: {
      badge: "bg-rose-100 text-rose-700 dark:bg-rose-900/30 dark:text-rose-400",
      border: "border-rose-200 dark:border-rose-800/30",
      text: "text-rose-600 dark:text-rose-400",
    },
  };
  return colors[color] || colors.cyan;
}

export default function LearnPage() {
  return (
    <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs items={[{ label: "Learn" }]} />

      {/* Header */}
      <header className="mb-12 max-w-3xl">
        <p className="text-sm font-medium uppercase tracking-wider text-cyan-600 dark:text-cyan-400">
          Consumer Education
        </p>
        <h1 className="mt-2 text-4xl font-bold tracking-tight text-slate-900 dark:text-white">
          Understand Before You Buy
        </h1>
        <p className="mt-6 text-xl text-slate-600 dark:text-slate-300">
          Labels, certifications, and marketing claims can be confusing. We
          break down what they actually mean for Indian consumers — so you can
          make informed decisions, not emotional ones.
        </p>
        <p className="mt-4 text-sm text-slate-500 dark:text-slate-400">
          All content is educational and neutral. No brand accusations, no
          fear-mongering — just clear, India-relevant information.
        </p>
      </header>

      {/* Why This Matters */}
      <section className="mb-16 rounded-2xl bg-gradient-to-r from-slate-100 via-slate-50 to-slate-100 p-8 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          Why Understanding Labels Matters
        </h2>
        <div className="mt-6 grid gap-6 sm:grid-cols-3">
          {[
            {
              stat: "70%+",
              label: "of Indian consumers",
              description: "find ingredient labels confusing or misleading",
            },
            {
              stat: "No legal",
              label: "definition exists",
              description:
                "for terms like 'natural' or 'chemical-free' in India",
            },
            {
              stat: "Daily use",
              label: "compounds exposure",
              description:
                "making ingredient safety more important than occasional products",
            },
          ].map((item) => (
            <div key={item.label}>
              <p className="text-3xl font-bold text-cyan-600 dark:text-cyan-400">
                {item.stat}
              </p>
              <p className="font-medium text-slate-900 dark:text-white">
                {item.label}
              </p>
              <p className="mt-1 text-sm text-slate-600 dark:text-slate-400">
                {item.description}
              </p>
            </div>
          ))}
        </div>
      </section>

      {/* Article Categories */}
      <section className="space-y-16">
        {articleCategories.map((category) => {
          const colors = getCategoryColors(category.color);
          return (
            <div key={category.id}>
              <div className="mb-6">
                <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
                  {category.title}
                </h2>
                <p className="mt-2 text-slate-600 dark:text-slate-400">
                  {category.description}
                </p>
              </div>

              <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
                {category.articles.map((article) => (
                  <Link
                    key={article.slug}
                    href={`/learn/${article.slug}`}
                    className={`group rounded-2xl border bg-white p-6 shadow-sm transition-all hover:shadow-md dark:bg-slate-900/50 ${colors.border}`}
                  >
                    <span
                      className={`inline-block text-xs font-medium px-2 py-1 rounded mb-3 ${colors.badge}`}
                    >
                      {category.title.split(" ")[0]}
                    </span>
                    <h3 className="text-lg font-semibold text-slate-900 dark:text-white group-hover:text-cyan-600 dark:group-hover:text-cyan-400 transition-colors">
                      {article.title}
                    </h3>
                    <p className="mt-2 text-sm text-slate-600 dark:text-slate-400">
                      {article.excerpt}
                    </p>
                    <p className="mt-4 text-xs text-slate-500 dark:text-slate-500">
                      {article.readTime}
                    </p>
                  </Link>
                ))}
              </div>
            </div>
          );
        })}
      </section>

      {/* CTA - Connect to Products */}
      <section className="mt-20 rounded-2xl bg-gradient-to-r from-cyan-500/10 via-emerald-500/10 to-cyan-500/10 p-8 text-center dark:from-cyan-500/5 dark:via-emerald-500/5 dark:to-cyan-500/5">
        <h2 className="text-2xl font-bold text-slate-900 dark:text-white">
          Ready to apply what you&apos;ve learned?
        </h2>
        <p className="mt-4 max-w-2xl mx-auto text-slate-600 dark:text-slate-400">
          Browse products that have been evaluated using the standards discussed
          in our educational content. Only products meeting our criteria are
          shown.
        </p>
        <div className="mt-6 flex flex-wrap justify-center gap-4">
          <Link
            href="/products"
            className="inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-cyan-500 to-emerald-500 px-6 py-3 font-semibold text-white shadow-lg shadow-cyan-500/25 transition-all hover:shadow-xl hover:shadow-cyan-500/30"
          >
            See Evaluated Products
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
            See Our Evaluation Criteria
          </Link>
        </div>
      </section>
    </div>
  );
}
