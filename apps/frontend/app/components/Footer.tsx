import Link from "next/link";
import Image from "next/image";

const footerLinks = {
  explore: [
    { name: "All Products", href: "/products" },
    { name: "Methodology", href: "/methodology" },
    { name: "Learn", href: "/learn" },
  ],
  categories: [
    { name: "Shampoo", href: "/categories/shampoo" },
    { name: "Toothpaste", href: "/categories/toothpaste" },
    { name: "Sunscreen", href: "/categories/sunscreen" },
    { name: "Soap", href: "/categories/soap" },
    { name: "Hair Oil", href: "/categories/hair_oil" },
    { name: "View all categories", href: "/categories" },
  ],
  company: [
    { name: "About Us", href: "/about" },
    { name: "Contact", href: "/contact" },
    { name: "Privacy Policy", href: "/privacy" },
  ],
};

export default function Footer() {
  return (
    <footer className="bg-hero-start text-white/80">
      <div className="mx-auto max-w-7xl px-4 py-16 lg:px-8">
        <div className="grid gap-10 md:grid-cols-5">
          {/* Brand */}
          <div className="md:col-span-2">
            <Link href="/" className="flex items-center gap-3 group">
              <Image
                src="/Logo-dark.jpeg"
                alt="ChosenWell Logo"
                width={44}
                height={44}
                className="rounded-xl brightness-110"
              />
              <span className="text-xl font-bold text-white">
                ChosenWell
              </span>
            </Link>
            <p className="mt-5 max-w-md text-sm leading-relaxed text-white/60">
              Your trusted source for curated health product comparisons. We
              analyze ingredients, certifications, and value to help you make
              informed decisions for your wellness journey.
            </p>
          </div>

          {/* Explore Links */}
          <div>
            <h3 className="text-xs font-bold uppercase tracking-[0.2em] text-accent">
              Explore
            </h3>
            <ul className="mt-5 space-y-3">
              {footerLinks.explore.map((link) => (
                <li key={link.name}>
                  <Link
                    href={link.href}
                    className="text-sm text-white/60 transition-colors duration-200 hover:text-white"
                  >
                    {link.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Category Links */}
          <div>
            <h3 className="text-xs font-bold uppercase tracking-[0.2em] text-accent">
              Categories
            </h3>
            <ul className="mt-5 space-y-3">
              {footerLinks.categories.map((link) => (
                <li key={link.name}>
                  <Link
                    href={link.href}
                    className="text-sm text-white/60 transition-colors duration-200 hover:text-white"
                  >
                    {link.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Company Links */}
          <div>
            <h3 className="text-xs font-bold uppercase tracking-[0.2em] text-accent">
              Company
            </h3>
            <ul className="mt-5 space-y-3">
              {footerLinks.company.map((link) => (
                <li key={link.name}>
                  <Link
                    href={link.href}
                    className="text-sm text-white/60 transition-colors duration-200 hover:text-white"
                  >
                    {link.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Bottom bar */}
        <div className="mt-14 border-t border-white/10 pt-8">
          <p className="text-center text-sm text-white/40">
            © {new Date().getFullYear()} ChosenWell. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  );
}
