import Link from "next/link";
import Image from "next/image";

const footerLinks = {
  explore: [
    { name: "All Products", href: "/products" },
    { name: "Categories", href: "/categories" },
    { name: "Methodology", href: "/methodology" },
  ],
  company: [
    { name: "About Us", href: "/about" },
    { name: "Contact", href: "/contact" },
    { name: "Privacy Policy", href: "/privacy" },
  ],
};

export default function Footer() {
  return (
    <footer className="border-t border-slate-200 bg-slate-50 dark:border-white/10 dark:bg-slate-950">
      <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
        <div className="grid gap-8 md:grid-cols-4">
          {/* Brand */}
          <div className="md:col-span-2">
            <Link href="/" className="flex items-center gap-3">
              {/* Light mode logo */}
              <Image
                src="/Logo-light.jpeg"
                alt="ChosenWell Logo"
                width={44}
                height={44}
                className="hidden rounded-xl dark:block"
              />
              {/* Dark mode logo */}
              <Image
                src="/Logo-dark.jpeg"
                alt="ChosenWell Logo"
                width={44}
                height={44}
                className="rounded-xl dark:hidden"
              />
              <span className="text-xl font-bold text-slate-900 dark:text-white">
                ChosenWell
              </span>
            </Link>
            <p className="mt-4 max-w-md text-sm text-slate-600 dark:text-slate-400">
              Your trusted source for curated health product comparisons. We
              analyze ingredients, certifications, and value to help you make
              informed decisions for your wellness journey.
            </p>
          </div>

          {/* Explore Links */}
          <div>
            <h3 className="text-sm font-semibold uppercase tracking-wider text-slate-900 dark:text-white">
              Explore
            </h3>
            <ul className="mt-4 space-y-3">
              {footerLinks.explore.map((link) => (
                <li key={link.name}>
                  <Link
                    href={link.href}
                    className="text-sm text-slate-600 transition-colors hover:text-slate-900 dark:text-slate-400 dark:hover:text-white"
                  >
                    {link.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Company Links */}
          <div>
            <h3 className="text-sm font-semibold uppercase tracking-wider text-slate-900 dark:text-white">
              Company
            </h3>
            <ul className="mt-4 space-y-3">
              {footerLinks.company.map((link) => (
                <li key={link.name}>
                  <Link
                    href={link.href}
                    className="text-sm text-slate-600 transition-colors hover:text-slate-900 dark:text-slate-400 dark:hover:text-white"
                  >
                    {link.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Bottom bar */}
        <div className="mt-12 border-t border-slate-200 pt-8 dark:border-white/10">
          <p className="text-center text-sm text-slate-500 dark:text-slate-500">
            © {new Date().getFullYear()} ChosenWell. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  );
}
