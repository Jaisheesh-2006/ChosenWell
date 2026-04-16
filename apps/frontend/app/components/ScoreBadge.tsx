interface ScoreBadgeProps {
  score: number;
  size?: "sm" | "md" | "lg";
}

function getScoreColor(score: number): string {
  if (score >= 80) return "from-emerald-500 to-green-600";
  if (score >= 60) return "from-primary to-primary-light";
  if (score >= 40) return "from-amber-500 to-orange-500";
  return "from-orange-500 to-red-500";
}

function getScoreLabel(score: number): string {
  if (score >= 90) return "Excellent";
  if (score >= 80) return "Great";
  if (score >= 70) return "Good";
  if (score >= 60) return "Fair";
  if (score >= 50) return "Average";
  return "Below Average";
}

export default function ScoreBadge({ score, size = "md" }: ScoreBadgeProps) {
  const sizeClasses = {
    sm: "h-10 w-10 text-sm",
    md: "h-14 w-14 text-lg",
    lg: "h-20 w-20 text-2xl",
  };

  const labelSizeClasses = {
    sm: "text-xs",
    md: "text-xs",
    lg: "text-sm",
  };

  return (
    <div className="flex flex-col items-center gap-1.5">
      <div
        className={`flex items-center justify-center rounded-full bg-gradient-to-br ${getScoreColor(
          score
        )} font-bold text-white shadow-lg ring-4 ring-white ${sizeClasses[size]}`}
      >
        {Math.round(score)}
      </div>
      <span className={`font-medium text-text-muted ${labelSizeClasses[size]}`}>
        {getScoreLabel(score)}
      </span>
    </div>
  );
}
