interface TagBadgeProps {
  tag: string;
  variant?: "default" | "organic" | "budget" | "kids";
}

const variantStyles: Record<string, string> = {
  default: "bg-slate-200 text-slate-700 border-slate-300 dark:bg-slate-700/50 dark:text-slate-300 dark:border-slate-600",
  organic: "bg-emerald-500/10 text-emerald-600 border-emerald-500/30 dark:text-emerald-400",
  budget: "bg-amber-500/10 text-amber-600 border-amber-500/30 dark:text-amber-400",
  kids: "bg-pink-500/10 text-pink-600 border-pink-500/30 dark:text-pink-400",
};

function getVariantFromTag(tag: string): string {
  const lowercaseTag = tag.toLowerCase();
  if (lowercaseTag.includes("organic")) return "organic";
  if (lowercaseTag.includes("budget") || lowercaseTag.includes("value"))
    return "budget";
  if (lowercaseTag.includes("kids") || lowercaseTag.includes("children"))
    return "kids";
  return "default";
}

export default function TagBadge({ tag, variant }: TagBadgeProps) {
  const effectiveVariant = variant || getVariantFromTag(tag);

  return (
    <span
      className={`inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-medium ${variantStyles[effectiveVariant]}`}
    >
      {tag}
    </span>
  );
}
