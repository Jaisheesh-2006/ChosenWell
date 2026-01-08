import type { ReactNode } from "react";
import type { Metadata } from "next";
import "./globals.css";
import Header from "./components/Header";
import Footer from "./components/Footer";
import { Providers } from "./context";
import { Analytics } from "@vercel/analytics/next";
import { SpeedInsights } from "@vercel/speed-insights/next"
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://chosenwell.co.in";

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: {
    default: "ChosenWell - Curated Health Products for Everyday Use in India",
    template: "%s | ChosenWell",
  },
  description:
    "Find genuinely safe, transparent health products curated for long-term use in India. We analyze ingredients, certifications, and value - no sponsored rankings, just honest comparisons.",
  keywords: [
    "health products India",
    "safe personal care",
    "ingredient analysis",
    "natural products",
    "transparent product reviews",
    "chemical-free products",
    "curated wellness",
    "product comparisons",
    "shampoo reviews India",
    "toothpaste reviews India",
    "sunscreen India",
    "soap reviews",
    "hair oil India",
  ],
  authors: [{ name: "ChosenWell" }],
  creator: "ChosenWell",
  publisher: "ChosenWell",
  alternates: {
    canonical: "/",
  },
  openGraph: {
    type: "website",
    locale: "en_IN",
    url: siteUrl,
    siteName: "ChosenWell",
    title: "ChosenWell - Curated Health Products for Everyday Use in India",
    description:
      "Find genuinely safe, transparent health products curated for long-term use in India. We analyze ingredients, certifications, and value - no sponsored rankings.",
  },
  twitter: {
    card: "summary_large_image",
    title: "ChosenWell - Curated Health Products for Everyday Use in India",
    description:
      "Find genuinely safe, transparent health products curated for long-term use in India. No sponsored rankings, just honest comparisons.",
    creator: "@ChosenWell_51",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
  verification: {
    google: process.env.GOOGLE_SITE_VERIFICATION,
  },
  icons: {
    icon: [
      {
        url: "/favicon-light.jpeg",
        type: "image/jpeg",
        media: "(prefers-color-scheme: light)",
      },
      {
        url: "/favicon-dark.jpeg",
        type: "image/jpeg",
        media: "(prefers-color-scheme: dark)",
      },
    ],
    apple: [
      { url: "/apple-touch-icon.png", sizes: "180x180", type: "image/png" },
    ],
    other: [
      {
        rel: "android-chrome",
        url: "/android-chrome-192x192.png",
        sizes: "192x192",
      },
      {
        rel: "android-chrome",
        url: "/android-chrome-512x512.png",
        sizes: "512x512",
      },
    ],
  },
  manifest: "/site.webmanifest",
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en" className="scroll-smooth dark" suppressHydrationWarning>
      <body className="flex min-h-screen flex-col bg-slate-50 text-slate-900 antialiased transition-colors dark:bg-slate-950 dark:text-slate-100">
        <Providers>
          <Header />
          <main className="flex-1 bg-gradient-to-b from-slate-50 via-white to-slate-50 dark:from-slate-950 dark:via-slate-900 dark:to-slate-950">
            {children}
          </main>
          <Footer />
          <Analytics />
          <SpeedInsights />
        </Providers>
      </body>
    </html>
  );
}
