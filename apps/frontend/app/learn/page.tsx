import type { Metadata } from "next";
import Link from "next/link";
import Breadcrumbs from "../components/Breadcrumbs";

export const metadata: Metadata = {
  title: "Learn - Understand Products Before You Buy",
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
      badge: "bg-primary/10 text-primary",
      border: "border-primary/20",
      text: "text-primary",
    },
    emerald: {
      badge: "bg-primary/10 text-primary",
      border: "border-primary/20",
      text: "text-primary",
    },
    amber: {
      badge: "bg-amber-100 text-amber-700",
      border: "border-amber-200",
      text: "text-amber-600",
    },
    rose: {
      badge: "bg-rose-100 text-rose-700",
      border: "border-rose-200",
      text: "text-rose-600",
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
        <p className="section-label">
          Consumer Education
        </p>
        <h1 className="mt-2 page-heading">
          Understand Before You Buy
        </h1>
        <p className="mt-6 text-xl text-text-muted">
          Labels, certifications, and marketing claims can be confusing. We
          break down what they actually mean for Indian consumers — so you can
          make informed decisions, not emotional ones.
        </p>
        <p className="mt-4 text-sm text-text-muted">
          All content is educational and neutral. No brand accusations, no
          fear-mongering — just clear, India-relevant information.
        </p>
      </header>

      {/* Why This Matters */}
      <section className="mb-16 rounded-xl bg-surface p-8 border border-border">
        <h2 className="section-heading">
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
              <p className="text-3xl font-bold text-primary">
                {item.stat}
              </p>
              <p className="font-medium text-text">
                {item.label}
              </p>
              <p className="mt-1 text-sm text-text-muted">
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
                <h2 className="section-heading">
                  {category.title}
                </h2>
                <p className="mt-2 text-text-muted">
                  {category.description}
                </p>
              </div>

              <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
                {category.articles.map((article) => (
                  <Link
                    key={article.slug}
                    href={`/learn/${article.slug}`}
                    className={`group card p-6 transition-all duration-300 hover:shadow-card-hover hover:border-primary-light/30 hover:-translate-y-0.5`}
                  >
                    <span
                      className={`inline-block text-xs font-medium px-2 py-1 rounded mb-3 ${colors.badge}`}
                    >
                      {category.title.split(" ")[0]}
                    </span>
                    <h3 className="text-lg font-semibold text-text group-hover:text-primary transition-colors duration-200 leading-snug">
                      {article.title}
                    </h3>
                    <p className="mt-2 text-sm text-text-muted">
                      {article.excerpt}
                    </p>
                    <p className="mt-4 text-xs text-text-muted">
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
      <section className="mt-20 cta-section">
        <h2 className="text-2xl font-display text-white">
          Ready to apply what you&apos;ve learned?
        </h2>
        <p className="mt-4 max-w-2xl mx-auto text-white/70">
          Browse products that have been evaluated using the standards discussed
          in our educational content. Only products meeting our criteria are
          shown.
        </p>
        <div className="mt-6 flex flex-wrap justify-center gap-4">
          <Link
            href="/products"
            className="btn-primary"
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
            className="btn-secondary"
          >
            See Our Evaluation Criteria
          </Link>
        </div>
      </section>
    </div>
  );
}
