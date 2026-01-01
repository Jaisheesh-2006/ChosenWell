export default function Hero() {
  return (
    <section className="space-y-4 rounded-3xl border border-cyan-500/20 bg-gradient-to-br from-cyan-600/40 to-emerald-600/30 p-8 shadow-2xl dark:border-white/10">
      <p className="text-sm uppercase tracking-[0.3em] text-cyan-100 dark:text-cyan-200">
        Curated health + rituals
      </p>
      <h1 className="text-4xl font-semibold text-white">
        Connection, calm, craft.
      </h1>
      <p className="text-lg text-cyan-50">
        Explore pantry-ready formulations, deeply vetted partners, and seasonal
        rituals designed to keep the body and mind in balance.
      </p>
      <div className="flex flex-wrap gap-2 text-sm text-cyan-50 dark:text-cyan-100">
        <span className="rounded-full border border-white/30 px-3 py-1">
          MDX-led editorial
        </span>
        <span className="rounded-full border border-white/30 px-3 py-1">
          Responsible sourcing
        </span>
        <span className="rounded-full border border-white/30 px-3 py-1">
          Biomarker prompts
        </span>
      </div>
    </section>
  );
}
