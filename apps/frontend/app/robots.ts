import { MetadataRoute } from "next";

/**
 * robots.txt configuration for https://www.chosenwell.co.in
 *
 * YMYL (Your Money Your Life) Health Website Best Practices:
 * - Allow all major search engine bots full access to public content
 * - Block only non-public, non-SEO URLs (API, admin, auth)
 * - Ensure CSS, JS, images are NOT blocked (critical for rendering)
 * - Declare sitemap location explicitly for faster indexing
 */
export default function robots(): MetadataRoute.Robots {
  // Use canonical www subdomain with HTTPS
  const baseUrl = "https://www.chosenwell.co.in";

  return {
    rules: [
      // Googlebot - Primary search engine, full access to public content
      {
        userAgent: "Googlebot",
        allow: "/",
        disallow: [
          "/api/", // API endpoints - not for indexing
          "/admin/", // Admin panel - private
          "/auth/", // Authentication routes - private
        ],
      },
      // Googlebot-Image - Allow image crawling for Google Images
      {
        userAgent: "Googlebot-Image",
        allow: "/",
      },
      // Bingbot - Microsoft/Bing search engine
      {
        userAgent: "Bingbot",
        allow: "/",
        disallow: ["/api/", "/admin/", "/auth/"],
      },
      // DuckDuckBot - DuckDuckGo search engine
      {
        userAgent: "DuckDuckBot",
        allow: "/",
        disallow: ["/api/", "/admin/", "/auth/"],
      },
      // Yandex - Russian search engine
      {
        userAgent: "Yandex",
        allow: "/",
        disallow: ["/api/", "/admin/", "/auth/"],
      },
      // Baidu - Chinese search engine
      {
        userAgent: "Baiduspider",
        allow: "/",
        disallow: ["/api/", "/admin/", "/auth/"],
      },
      // Default rule for all other bots
      {
        userAgent: "*",
        allow: "/",
        disallow: [
          "/api/", // REST API endpoints
          "/admin/", // Admin dashboard
          "/auth/", // Login/logout/signup
          "/private/", // Any private routes
          "/*?*", // Block URLs with query strings (prevents duplicate content)
        ],
      },
    ],
    // Sitemap index pointing to all sitemaps
    sitemap: `${baseUrl}/sitemap-index.xml`,
    // Additional host directive (some bots use this)
    host: baseUrl,
  };
}
