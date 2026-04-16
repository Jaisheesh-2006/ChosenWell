import type { ReactNode } from "react";
import type { Metadata } from "next";
import { Inter, Instrument_Serif } from "next/font/google";
import "./globals.css";
import Header from "./components/Header";
import Footer from "./components/Footer";
import { Providers } from "./context";
import { Analytics } from "@vercel/analytics/next";
import { SpeedInsights } from "@vercel/speed-insights/next";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-sans",
  display: "swap",
});

const instrumentSerif = Instrument_Serif({
  subsets: ["latin"],
  weight: "400",
  style: ["normal", "italic"],
  variable: "--font-display",
  display: "swap",
});

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
    // India-First High-Intent Keywords
    "best shampoo for Indian hair type",
    "toothpaste comparison India",
    "sunscreen for Indian skin tone",
    "hair oil for Indian climate humidity",
    "soap for hard water India",
    "personal care products Indian weather",
    "dermatologist recommended products India",
    "sulfate-free shampoo India",
    "paraben-free products India",
    // India-Specific Ingredient & Safety Keywords
    "ingredient safety check India",
    "how to read product labels India",
    "FSSAI approved ingredients",
    "BIS certified personal care",
    "ingredients to avoid sensitive Indian skin",
    "skincare for humid Indian summers",
    "hard water hair care India",
    "pollution protection skincare India",
    // Global but India-Relevant Keywords
    "unbiased product reviews personal care",
    "ingredient transparency cosmetics",
    "safe daily use personal care",
    "hypoallergenic products India",
    "dermatologically tested products",
    "pregnancy-safe personal care",
    "sensitive skin ingredient guide",
  ],
  authors: [{ name: "ChosenWell" }],
  creator: "ChosenWell",
  publisher: "ChosenWell",
  openGraph: {
    type: "website",
    locale: "en_IN",
    url: siteUrl,
    siteName: "ChosenWell",
    title: "ChosenWell - Curated Health Products for Everyday Use in India",
    description:
      "Find genuinely safe, transparent health products curated for long-term use in India. We analyze ingredients, certifications, and value - no sponsored rankings.",
    images: [
      {
        url: "/opengraph-image",
        width: 1200,
        height: 630,
        alt: "ChosenWell - Curated Health Products for Everyday Use in India",
      },
    ],
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
        url: "/android-chrome-192x192.png",
        type: "image/png",
        sizes: "192x192",
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
    <html lang="en-IN" className={`scroll-smooth ${inter.variable} ${instrumentSerif.variable}`} suppressHydrationWarning>
      <body className="flex min-h-screen flex-col bg-background text-text antialiased">
        <Providers>
          <Header />
          <main className="flex-1">
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
