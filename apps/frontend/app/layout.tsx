import type { ReactNode } from "react";
import "./globals.css";

export const metadata = {
  title: "Curated Health Products",
  description: "A carefully selected catalog of holistic wellness essentials.",
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body className="bg-slate-950 text-slate-100">
        <main className="min-h-screen bg-gradient-to-b from-slate-950 via-slate-900 to-slate-950">
          {children}
        </main>
      </body>
    </html>
  );
}
