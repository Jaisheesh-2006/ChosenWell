import type { ReactNode } from "react";
import type { Metadata } from "next";
import "./globals.css";
import Header from "./components/Header";
import Footer from "./components/Footer";

export const metadata: Metadata = {
  title: {
    default: "HealthIsWealth - Curated Health Product Comparisons",
    template: "%s | HealthIsWealth",
  },
  description:
    "Compare health products with transparent scoring. We analyze ingredients, certifications, and value to help you make informed wellness decisions.",
  keywords: [
    "health products",
    "product comparison",
    "wellness",
    "organic products",
    "supplement reviews",
    "ingredient analysis",
  ],
  authors: [{ name: "HealthIsWealth" }],
  openGraph: {
    type: "website",
    locale: "en_US",
    siteName: "HealthIsWealth",
    title: "HealthIsWealth - Curated Health Product Comparisons",
    description:
      "Compare health products with transparent scoring. We analyze ingredients, certifications, and value to help you make informed wellness decisions.",
  },
  twitter: {
    card: "summary_large_image",
    title: "HealthIsWealth - Curated Health Product Comparisons",
    description:
      "Compare health products with transparent scoring. We analyze ingredients, certifications, and value to help you make informed wellness decisions.",
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
    <html lang="en" className="scroll-smooth">
      <body className="flex min-h-screen flex-col bg-slate-950 text-slate-100 antialiased">
        <Header />
        <main className="flex-1 bg-gradient-to-b from-slate-950 via-slate-900 to-slate-950">
          {children}
        </main>
        <Footer />
      </body>
    </html>
  );
}
