import Hero from "./components/Hero";
import FeaturedWriteup from "../content/featured.mdx";

const spotlightProducts = [
  {
    name: "Rejuve+ Herbal Elixir",
    description: "Botanicals for calm, clarity, and core strength.",
    tag: "Limited run",
  },
  {
    name: "Oceanic Collagen Blend",
    description:
      "Marine-sourced collagen plus vitamin C to support skin resilience.",
    tag: "Research-backed",
  },
  {
    name: "Grounded Adaptogenic Ritual",
    description: "Functional cacao blend for stress reset moments.",
    tag: "Editors' pick",
  },
];

export default function Page() {
  return (
    <div className="mx-auto flex max-w-5xl flex-col gap-16 px-4 py-12">
      <Hero />
      <section className="rounded-3xl border border-white/10 bg-white/5 p-8 shadow-xl">
        <header className="mb-6 space-y-2">
          <p className="text-sm uppercase text-slate-400">Curated drops</p>
          <h2 className="text-3xl font-semibold text-white">
            Spotlight products
          </h2>
        </header>
        <div className="grid gap-6 md:grid-cols-3">
          {spotlightProducts.map((product) => (
            <article
              key={product.name}
              className="space-y-2 rounded-2xl border border-white/10 bg-slate-900/60 p-4"
            >
              <div className="flex items-center justify-between text-sm text-slate-400">
                <span>{product.tag}</span>
                <span className="text-white/70">New</span>
              </div>
              <h3 className="text-xl font-semibold text-white">
                {product.name}
              </h3>
              <p className="text-sm text-slate-300">{product.description}</p>
            </article>
          ))}
        </div>
      </section>
      <section className="space-y-6 rounded-3xl border border-cyan-400/20 bg-cyan-500/5 p-8">
        <header>
          <h2 className="text-2xl font-semibold text-white">Editorial story</h2>
          <p className="text-sm text-cyan-200">
            In-depth rationale from the curator floor.
          </p>
        </header>
        <div className="prose prose-invert max-w-none text-slate-200">
          <FeaturedWriteup />
        </div>
      </section>
    </div>
  );
}
