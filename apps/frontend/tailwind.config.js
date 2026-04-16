/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/**/*.{ts,tsx,md,mdx}",
    "./components/**/*.{ts,tsx}",
    "./content/**/*.{md,mdx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['var(--font-sans)'],
        display: ['var(--font-display)', 'Georgia', 'serif'],
      },
      colors: {
        primary:          '#1B4D3E',
        'primary-light':  '#2A7B5F',
        'primary-lighter':'#E6F2ED',
        accent:           '#D4A853',
        'accent-light':   '#F5EEDC',
        text:             '#1A1A2E',
        'text-muted':     '#6B7280',
        background:       '#FAFAF7',
        surface:          '#F3F1EC',
        'surface-raised': '#FFFFFF',
        border:           '#E5E2DB',
        'border-strong':  '#D1CDC4',
        'hero-start':     '#0F2E23',
        'hero-end':       '#1B4D3E',
        success:          '#16A34A',
        warning:          '#D97706',
        danger:           '#DC2626',
      },
      boxShadow: {
        'sm':   '0 1px 2px rgba(0,0,0,0.05)',
        'md':   '0 4px 12px rgba(0,0,0,0.08)',
        'lg':   '0 8px 30px rgba(0,0,0,0.1)',
        'xl':   '0 16px 48px rgba(0,0,0,0.12)',
        'glow': '0 0 24px rgba(27,77,62,0.15)',
        'glow-gold': '0 0 24px rgba(212,168,83,0.2)',
        'card': '0 1px 3px rgba(0,0,0,0.04), 0 4px 12px rgba(0,0,0,0.03)',
        'card-hover': '0 8px 30px rgba(0,0,0,0.08), 0 2px 8px rgba(0,0,0,0.04)',
        'feedback': '0 20px 60px rgba(27,77,62,0.12)',
        'feedback-hover': '0 26px 70px rgba(27,77,62,0.18)',
        'feedback-icon': '0 10px 24px rgba(27,77,62,0.25)',
      },
      borderRadius: {
        'sm':   '8px',
        'md':   '12px',
        'lg':   '16px',
        'xl':   '24px',
        '2xl':  '32px',
      },
      animation: {
        "fade-in":      "fadeIn 0.6s ease-out both",
        "slide-up":     "slideUp 0.6s ease-out both",
        "float":        "float 6s ease-in-out infinite",
        "shimmer":      "shimmer 2s ease-in-out infinite",
        "pulse-slow":   "pulse 3s ease-in-out infinite",
        "slide-in-up":  "slideInUp 0.5s cubic-bezier(0.16,1,0.3,1) both",
        "scale-in":     "scaleIn 0.4s cubic-bezier(0.16,1,0.3,1) both",
      },
      keyframes: {
        fadeIn: {
          "0%":   { opacity: "0" },
          "100%": { opacity: "1" },
        },
        slideUp: {
          "0%":   { opacity: "0", transform: "translateY(20px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        float: {
          "0%, 100%": { transform: "translateY(0)" },
          "50%":      { transform: "translateY(-10px)" },
        },
        shimmer: {
          "0%, 100%": { opacity: "0.7" },
          "50%":      { opacity: "1" },
        },
        slideInUp: {
          "0%":   { opacity: "0", transform: "translateY(24px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        scaleIn: {
          "0%":   { opacity: "0", transform: "scale(0.95)" },
          "100%": { opacity: "1", transform: "scale(1)" },
        },
      },
    },
  },
  plugins: [],
};
