import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import Breadcrumbs from "../../components/Breadcrumbs";

// Article content database - in production, this would come from a CMS or MDX files
const articles: Record<
  string,
  {
    title: string;
    description: string;
    category: string;
    categorySlug: string;
    readTime: string;
    publishedDate: string;
    content: {
      type: "paragraph" | "heading" | "list" | "callout";
      text?: string;
      items?: string[];
      variant?: "info" | "warning" | "tip";
    }[];
    relatedCategories: string[];
    relatedArticles: string[];
  }
> = {
  "dermatologically-tested-meaning": {
    title: "What 'Dermatologically Tested' Actually Means in India",
    description:
      "This common claim doesn't mean what most consumers think it does. Learn what dermatological testing actually involves and what it guarantees.",
    category: "Marketing Claims",
    categorySlug: "marketing",
    readTime: "3 min read",
    publishedDate: "2026-01-10",
    content: [
      {
        type: "paragraph",
        text: "Walk through any Indian store's personal care aisle and you'll see 'Dermatologically Tested' on countless products. It sounds reassuring — like doctors have verified the product is safe. But what does this claim actually mean under Indian regulations?",
      },
      {
        type: "heading",
        text: "What the claim actually means",
      },
      {
        type: "paragraph",
        text: "'Dermatologically Tested' simply means the product was tested on human skin at some point. It doesn't specify the results of that testing, the sample size, or whether the testing was conducted by independent labs.",
      },
      {
        type: "callout",
        variant: "info",
        text: "A product can be 'dermatologically tested' even if 20% of test subjects experienced irritation — as long as the testing occurred.",
      },
      {
        type: "heading",
        text: "What it doesn't guarantee",
      },
      {
        type: "list",
        items: [
          "The product won't cause irritation or allergic reactions",
          "The testing was conducted by dermatologists (vs general lab technicians)",
          "The sample size was statistically significant",
          "The test results were favorable",
          "The testing was done by an independent laboratory",
        ],
      },
      {
        type: "heading",
        text: "What to look for instead",
      },
      {
        type: "paragraph",
        text: "Rather than relying on vague claims, consider looking for products that provide specific information about their testing protocols, or that carry certifications from recognized bodies.",
      },
      {
        type: "list",
        items: [
          "Full ingredient disclosure (INCI list)",
          "Specific claims like 'tested on X subjects for Y weeks'",
          "Third-party certifications from recognized bodies",
          "Transparent information about testing methodology",
        ],
      },
      {
        type: "callout",
        variant: "tip",
        text: "The absence of 'Dermatologically Tested' doesn't mean a product is unsafe — and its presence doesn't guarantee safety. Focus on ingredient transparency instead.",
      },
    ],
    relatedCategories: ["soap", "shampoo", "sunscreen"],
    relatedArticles: ["natural-label-india", "clinically-proven-claims"],
  },
  "preservatives-daily-products": {
    title: "Are Preservatives Always Bad for Daily-Use Products?",
    description:
      "A balanced look at preservatives in personal care and food products. When they're necessary and when to be cautious.",
    category: "Common Questions",
    categorySlug: "daily-use",
    readTime: "4 min read",
    publishedDate: "2026-01-08",
    content: [
      {
        type: "paragraph",
        text: "'Preservative-free' has become a selling point in India. But are preservatives actually harmful? And what happens to products without them? Let's look at this with a balanced perspective.",
      },
      {
        type: "heading",
        text: "Why preservatives exist",
      },
      {
        type: "paragraph",
        text: "Preservatives prevent the growth of bacteria, mold, and yeast in products — especially those containing water. Without them, many products would become contaminated within days or weeks, potentially causing infections or skin reactions.",
      },
      {
        type: "callout",
        variant: "warning",
        text: "A contaminated 'preservative-free' product can be more harmful than a properly preserved one. Microbial growth in products used on skin or consumed can cause serious health issues.",
      },
      {
        type: "heading",
        text: "The nuanced reality",
      },
      {
        type: "list",
        items: [
          "Some preservatives have documented safety concerns at high concentrations",
          "Others have been used safely for decades with no significant issues",
          "Concentration matters — the same ingredient can be safe at 0.1% but concerning at 5%",
          "Individual sensitivities vary — what irritates one person may be fine for another",
        ],
      },
      {
        type: "heading",
        text: "What matters for daily-use products",
      },
      {
        type: "paragraph",
        text: "For products you use every day, cumulative exposure matters more than for occasional-use products. This doesn't mean avoiding all preservatives — it means being thoughtful about which ones and at what concentrations.",
      },
      {
        type: "list",
        items: [
          "Check if full ingredient concentrations are disclosed",
          "Look for products with well-studied preservative systems",
          "Consider packaging — airless pumps reduce preservative needs",
          "Be skeptical of 'preservative-free' claims for water-based products",
        ],
      },
      {
        type: "callout",
        variant: "tip",
        text: "The question isn't 'preservatives or no preservatives' — it's whether the product uses appropriate preservation for its formulation and intended use.",
      },
    ],
    relatedCategories: ["toothpaste", "shampoo", "soap"],
    relatedArticles: ["daily-use-ingredient-safety", "natural-vs-synthetic"],
  },
  "fssai-certification-explained": {
    title: "What FSSAI Certification Actually Guarantees (And What It Doesn't)",
    description:
      "Understanding the scope and limitations of India's food safety certification. What FSSAI means and what consumers should still verify.",
    category: "Certifications",
    categorySlug: "certifications",
    readTime: "4 min read",
    publishedDate: "2026-01-05",
    content: [
      {
        type: "paragraph",
        text: "FSSAI (Food Safety and Standards Authority of India) certification is mandatory for food products sold in India. But many consumers overestimate what this certification actually guarantees about product quality or safety.",
      },
      {
        type: "heading",
        text: "What FSSAI certification means",
      },
      {
        type: "paragraph",
        text: "An FSSAI license indicates that a food business has registered with the authority and commits to following food safety regulations. It's a compliance requirement, not a quality endorsement.",
      },
      {
        type: "list",
        items: [
          "The business is registered and has a valid license",
          "Basic hygiene and manufacturing standards should be followed",
          "The product should not contain banned substances",
          "Labeling should meet minimum regulatory requirements",
        ],
      },
      {
        type: "heading",
        text: "What FSSAI doesn't guarantee",
      },
      {
        type: "callout",
        variant: "info",
        text: "FSSAI certification is about regulatory compliance, not product quality. A certified product has met minimum legal requirements — not necessarily optimal health standards.",
      },
      {
        type: "list",
        items: [
          "The product is the healthiest option in its category",
          "Ingredients are of premium quality",
          "The product is suitable for your specific health needs",
          "Regular quality testing is being conducted",
          "The product is free from all potentially concerning ingredients",
        ],
      },
      {
        type: "heading",
        text: "How to use this information",
      },
      {
        type: "paragraph",
        text: "FSSAI certification is a baseline requirement — think of it as a minimum threshold, not a recommendation. Products without FSSAI certification should be avoided, but having certification doesn't mean a product automatically meets your standards.",
      },
      {
        type: "callout",
        variant: "tip",
        text: "Look at FSSAI certification as 'necessary but not sufficient.' It's the starting point for evaluation, not the end point.",
      },
    ],
    relatedCategories: ["toothpaste"],
    relatedArticles: [
      "bis-certification-guide",
      "organic-certifications-india",
    ],
  },
  "natural-label-india": {
    title: "'Natural' Products in India: No Legal Definition Exists",
    description:
      "Why the 'natural' label has no regulatory meaning in India and what consumers should check instead.",
    category: "Marketing Claims",
    categorySlug: "marketing",
    readTime: "4 min read",
    publishedDate: "2026-01-03",
    content: [
      {
        type: "paragraph",
        text: "The word 'natural' on Indian product labels carries significant marketing weight. Consumers often assume it means the product is safer, healthier, or more environmentally friendly. But here's what many don't realize: 'natural' has no legal definition in India.",
      },
      {
        type: "heading",
        text: "The regulatory gap",
      },
      {
        type: "paragraph",
        text: "Unlike terms such as 'organic' (which requires certification), 'natural' can be used freely by any brand. There's no regulatory body verifying natural claims, no minimum standards, and no consequences for misleading use.",
      },
      {
        type: "callout",
        variant: "warning",
        text: "A product labeled 'natural' can legally contain synthetic preservatives, artificial fragrances, and lab-created ingredients. The term has no binding meaning.",
      },
      {
        type: "heading",
        text: "Common misconceptions",
      },
      {
        type: "list",
        items: [
          "'Natural' doesn't mean 'organic' — organic has certification requirements",
          "'Natural' doesn't mean 'chemical-free' — everything is made of chemicals",
          "'Natural' doesn't mean 'safe' — many natural substances can be harmful",
          "'Natural' doesn't mean 'effective' — efficacy depends on formulation, not source",
        ],
      },
      {
        type: "heading",
        text: "What to check instead",
      },
      {
        type: "paragraph",
        text: "Rather than relying on 'natural' claims, focus on concrete information that actually tells you what's in the product.",
      },
      {
        type: "list",
        items: [
          "Full INCI ingredient list — are ingredients actually disclosed?",
          "Specific certifications (NPOP, USDA Organic, Ecocert) that have real standards",
          "Ingredient concentrations where disclosed",
          "Third-party testing or verification claims",
        ],
      },
      {
        type: "callout",
        variant: "tip",
        text: "The absence of 'natural' labeling doesn't make a product bad, and its presence doesn't make it good. Judge products by their actual ingredients, not marketing terms.",
      },
    ],
    relatedCategories: ["shampoo", "soap", "hair_oil"],
    relatedArticles: [
      "dermatologically-tested-meaning",
      "organic-certifications-india",
    ],
  },
};

type Props = {
  params: Promise<{ slug: string }>;
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params;
  const article = articles[slug];

  if (!article) {
    return {
      title: "Article Not Found | ChosenWell",
    };
  }

  return {
    title: `${article.title} | ChosenWell Learn`,
    description: article.description,
    alternates: {
      canonical: `/learn/${slug}`,
    },
    openGraph: {
      title: article.title,
      description: article.description,
      url: `/learn/${slug}`,
      type: "article",
      publishedTime: article.publishedDate,
    },
  };
}

export async function generateStaticParams() {
  return Object.keys(articles).map((slug) => ({ slug }));
}

export default async function LearnArticlePage({ params }: Props) {
  const { slug } = await params;
  const article = articles[slug];

  if (!article) {
    notFound();
  }

  return (
    <div className="mx-auto max-w-4xl px-4 py-12 sm:px-6 lg:px-8">
      <Breadcrumbs
        items={[{ label: "Learn", href: "/learn" }, { label: article.title }]}
      />

      {/* Back link above the fold */}
      <Link
        href="/learn"
        className="mb-6 inline-flex items-center gap-2 text-sm font-medium text-text-muted hover:text-primary"
      >
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
            d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18"
          />
        </svg>
        Back to all articles
      </Link>

      {/* Article Header */}
      <header className="mb-10">
        <div className="flex items-center gap-3 mb-4">
          <span className="inline-block text-xs font-medium text-primary bg-primary-lighter px-2 py-1 rounded">
            {article.category}
          </span>
          <span className="text-sm text-text-muted">
            {article.readTime}
          </span>
        </div>
        <h1 className="page-heading">
          {article.title}
        </h1>
        <p className="mt-4 text-xl text-text-muted">
          {article.description}
        </p>
        <p className="mt-4 text-sm text-text-muted">
          Last updated:{" "}
          {new Date(article.publishedDate).toLocaleDateString("en-IN", {
            year: "numeric",
            month: "long",
            day: "numeric",
          })}
        </p>
      </header>

      {/* Article Content */}
      <article className="prose prose-slate max-w-none">
        {article.content.map((block, index) => {
          if (block.type === "paragraph") {
            return (
              <p
                key={index}
                className="text-text-muted leading-relaxed"
              >
                {block.text}
              </p>
            );
          }

          if (block.type === "heading") {
            return (
              <h2
                key={index}
                className="text-xl font-bold text-text mt-8 mb-4"
              >
                {block.text}
              </h2>
            );
          }

          if (block.type === "list" && block.items) {
            return (
              <ul key={index} className="space-y-2 my-4">
                {block.items.map((item, i) => (
                  <li
                    key={i}
                    className="flex items-start gap-2 text-text-muted"
                  >
                    <span className="text-primary mt-1">•</span>
                    <span>{item}</span>
                  </li>
                ))}
              </ul>
            );
          }

          if (block.type === "callout") {
            const variants = {
              info: "bg-primary-lighter border-primary/20 text-primary",
              warning:
                "bg-amber-50 border-amber-200 text-amber-800",
              tip: "bg-emerald-50 border-emerald-200 text-emerald-800",
            };
            const variant = block.variant || "info";
            return (
              <div
                key={index}
                className={`rounded-lg border p-4 my-6 ${variants[variant]}`}
              >
                <p className="text-sm font-medium">{block.text}</p>
              </div>
            );
          }

          return null;
        })}
      </article>

      {/* Related Products CTA */}
      {article.relatedCategories.length > 0 && (
        <section className="cta-section mt-12 p-6">
          <h3 className="text-lg font-semibold text-white">
            See products evaluated using these criteria
          </h3>
          <p className="mt-2 text-sm text-white/70">
            Browse products in related categories that meet our evaluation
            standards.
          </p>
          <div className="mt-4 flex flex-wrap gap-2">
            {article.relatedCategories.map((category) => (
              <Link
                key={category}
                href={`/categories/${category}`}
                className="inline-flex items-center gap-1 rounded-full bg-white px-4 py-2 text-sm font-medium text-text shadow-sm hover:shadow transition-all"
              >
                {category
                  .replace("_", " ")
                  .replace(/\b\w/g, (l) => l.toUpperCase())}
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
              </Link>
            ))}
          </div>
        </section>
      )}

      {/* Related Articles */}
      {article.relatedArticles.length > 0 && (
        <section className="mt-12">
          <h3 className="text-lg font-semibold text-text mb-4">
            Continue learning
          </h3>
          <div className="grid gap-4 sm:grid-cols-2">
            {article.relatedArticles
              .filter((slug) => articles[slug])
              .map((slug) => {
                const related = articles[slug];
                return (
                  <Link
                    key={slug}
                    href={`/learn/${slug}`}
                    className="group card p-4 transition-all duration-300 hover:shadow-card-hover hover:border-primary-light/30"
                  >
                    <span className="inline-block text-xs font-medium text-text-muted mb-2">
                      {related.category}
                    </span>
                    <h4 className="font-semibold text-text group-hover:text-primary transition-colors">
                      {related.title}
                    </h4>
                    <p className="mt-1 text-sm text-text-muted">
                      {related.readTime}
                    </p>
                  </Link>
                );
              })}
          </div>
        </section>
      )}

      {/* Back to Learn */}
      <div className="mt-12 pt-8 border-t border-border">
        <Link
          href="/learn"
          className="inline-flex items-center gap-2 text-sm font-medium text-text-muted hover:text-primary"
        >
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
              d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18"
            />
          </svg>
          Back to all articles
        </Link>
      </div>
    </div>
  );
}
