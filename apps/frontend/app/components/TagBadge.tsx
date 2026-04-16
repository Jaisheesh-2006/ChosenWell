interface TagBadgeProps {
  tag: string;
  variant?: "default" | "organic" | "budget" | "kids";
}

const variantStyles: Record<string, string> = {
  default: "bg-surface text-text border-border",
  organic: "bg-primary-lighter text-primary border-primary/20",
  budget: "bg-amber-50 text-amber-700 border-amber-200",
  kids: "bg-pink-50 text-pink-700 border-pink-200",
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
