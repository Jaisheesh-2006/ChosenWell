This file is a strict implementation spec.
Do not infer additional requirements.
Do not refactor unrelated code.


---

## ✅ **GitHub Copilot Prompt — Fix “Crawled – Currently Not Indexed” Pages**

> You are a **senior SEO engineer and Next.js App Router developer**.
>
> **Context**
>
> * Website: [https://www.chosenwell.co.in](https://www.chosenwell.co.in)
> * Tech stack: **Next.js (App Router)**
> * Google Search Console status: **“Crawled – currently not indexed”**
> * Pages affected:
>
>   * `/categories`
>   * `/products/tribe-concepts-90-day-miracle-hair-oil`
>   * `/products/minimalist-spf-60-silymarin-sunscreen`
>
> ---
>
> ## OBJECTIVE
>
> Increase perceived page value so Google confidently indexes these pages, **without keyword stuffing or redesign**.
>
> Each affected page must:
>
> * Contain **meaningful, visible text above the fold**
> * Clearly explain **who the page is for**
> * Clearly explain **what makes the page distinct**
> * Remain concise and neutral
>
> ---
>
> ## STEP 1 — VERIFY BEFORE CHANGING (MANDATORY)
>
> Inspect each affected page and verify:
>
> ### A. Content visibility
>
> * Is there **meaningful explanatory text** visible immediately on page load?
> * Is the text visible **without user interaction** (no tabs, accordions, or clicks)?
>
> ### B. Uniqueness
>
> * Is the explanatory content **unique** to this page?
> * Or is it structurally identical to other pages of the same type?
>
> ### C. Intent clarity
>
> * Does the page clearly answer:
>
>   * Who this page is for?
>   * Why this page exists separately?
>
> If all checks pass, **do not change the page**.
>
> ---
>
> ## STEP 2 — IMPLEMENT ONLY IF NON-COMPLIANT
>
> **Only apply changes where verification fails.**
>
> ---
>
> ### 1. `/categories` page
>
> If missing or insufficient, add a short explanatory paragraph **above the category grid**:
>
> **Requirements**
>
> * 3–4 lines max
> * Neutral, editorial tone
> * No keyword stuffing
>
> **Intent to convey**
>
> * This page helps users explore products by category
> * Categories are curated using a consistent evaluation framework
> * This page is more than navigation
>
> ---
>
> ### 2. Product pages (`/products/{slug}`)
>
> If missing or insufficient, add a short block **immediately below the product title**:
>
> **Requirements**
>
> * 3–5 lines max
> * Visible on initial render
> * Unique per product
>
> **Must explain**
>
> * Who this product is for
> * What type of evaluation it passed
> * Why it appears on ChosenWell
>
> **Constraints**
>
> * No marketing language
> * No exaggerated claims
> * No keyword repetition
>
> ---
>
> ## TECHNICAL CONSTRAINTS (CRITICAL)
>
> * Content must be present in **initial server-rendered HTML**
> * Do NOT:
>
>   * Add FAQs
>   * Add long paragraphs
>   * Refactor layouts
>   * Change URLs
> * Preserve existing UI and spacing
>
> ---
>
> ## OUTPUT EXPECTED
>
> * Minimal, production-safe code changes
> * Explicit note if a page was already compliant
> * Explicit note if assumptions were required
>
> Do **not** include generic SEO explanations.

---


