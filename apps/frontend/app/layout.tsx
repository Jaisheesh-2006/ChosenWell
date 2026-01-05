import type { ReactNode } from "react";
import type { Metadata } from "next";
import "./globals.css";
import Header from "./components/Header";
import Footer from "./components/Footer";
import { Providers } from "./context";

export const metadata: Metadata = {
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
  ],
  authors: [{ name: "ChosenWell" }],
  openGraph: {
    type: "website",
    locale: "en_IN",
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
        </Providers>
      </body>
    </html>
  );
}
