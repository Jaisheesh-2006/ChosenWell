"use client";

import { useState } from "react";

interface CriteriaSectionProps {
  title: string;
  content: string;
}

export default function CriteriaSection({
  title,
  content,
}: CriteriaSectionProps) {
  const [isExpanded, setIsExpanded] = useState(false);

  if (!content) return null;

  return (
    <section className="mb-16">
      <button
        onClick={() => setIsExpanded(!isExpanded)}
        className="group flex w-full items-center justify-between rounded-2xl border border-border bg-surface p-6 text-left transition-all hover:border-primary/30 hover:shadow-lg"
      >
        <div className="flex items-center gap-3">
          <div className="flex h-10 w-10 items-center justify-center rounded-full bg-primary/10">
            <svg
              className="h-5 w-5 text-primary"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M9.879 7.519c1.171-1.025 3.071-1.025 4.242 0 1.172 1.025 1.172 2.687 0 3.712-.203.179-.43.326-.67.442-.745.361-1.45.999-1.45 1.827v.75M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9 5.25h.008v.008H12v-.008z"
              />
            </svg>
          </div>
          <span className="text-lg font-semibold text-text">
            How we evaluate {title}
          </span>
        </div>
        <svg
          className={`h-5 w-5 text-text-muted transition-transform duration-300 ${
            isExpanded ? "rotate-180" : ""
          }`}
          fill="none"
          viewBox="0 0 24 24"
          strokeWidth={2}
          stroke="currentColor"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="M19.5 8.25l-7.5 7.5-7.5-7.5"
          />
        </svg>
      </button>

      <div
        className={`overflow-hidden transition-all duration-300 ${
          isExpanded ? "mt-4 max-h-[5000px] opacity-100" : "max-h-0 opacity-0"
        }`}
      >
        <div className="card p-6">
          <div
            className="prose prose-slate max-w-none prose-headings:text-text prose-h2:mt-8 prose-h2:text-xl prose-h3:mt-6 prose-h3:text-lg prose-p:text-text-muted prose-strong:text-text prose-ul:text-text-muted prose-li:marker:text-primary"
            dangerouslySetInnerHTML={{ __html: formatMarkdown(content) }}
          />
        </div>
      </div>
    </section>
  );
}

// Simple markdown to HTML converter with Unicode support
function formatMarkdown(text: string): string {
  // First, normalize the text to handle any encoding issues
  const normalized = text
    // Fix common encoding issues - replace replacement character with proper characters
    .replace(/\ufffd/g, "'") // Replace replacement character with apostrophe
    .replace(/â€™/g, "'") // Fix incorrectly encoded apostrophe
    .replace(/â€"/g, "—") // Fix incorrectly encoded em dash
    .replace(/â€œ/g, '"') // Fix incorrectly encoded left quote
    .replace(/â€/g, '"'); // Fix incorrectly encoded right quote

  return (
    normalized
      // Headers
      .replace(/^### (.*$)/gm, '<h3 class="font-semibold mt-6 mb-2">$1</h3>')
      .replace(/^## (.*$)/gm, '<h2 class="font-bold text-xl mt-8 mb-3 font-display">$1</h2>')
      .replace(/^# (.*$)/gm, '<h1 class="font-bold text-2xl mt-8 mb-4 font-display">$1</h1>')
      // Horizontal rules
      .replace(
        /^---$/gm,
        '<hr class="my-6 border-border" />'
      )
      // Bold
      .replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>")
      // Checkmarks and X marks (emoji-style)
      .replace(
        /^✅\s*(.*$)/gm,
        '<div class="flex items-start gap-2 my-1"><span class="text-green-500 mt-0.5">✓</span><span>$1</span></div>'
      )
      .replace(
        /^❌\s*(.*$)/gm,
        '<div class="flex items-start gap-2 my-1"><span class="text-red-500 mt-0.5">✗</span><span>$1</span></div>'
      )
      // Lists - handle both * and - style
      .replace(/^[\*\-]\s+(.*$)/gm, "<li>$1</li>")
      // Wrap consecutive li elements in ul
      .replace(
        /(<li>.*<\/li>\n?)+/g,
        '<ul class="list-disc pl-5 my-3 space-y-1">$&</ul>'
      )
      // Paragraphs - wrap text blocks
      .replace(/\n\n+/g, '</p><p class="my-3">')
      // Clean up empty paragraphs
      .replace(/<p class="my-3"><\/p>/g, "")
      .replace(/<p class="my-3">(<[hud])/g, "$1")
      .replace(/(<\/[hud].*?>)<\/p>/g, "$1")
  );
}
