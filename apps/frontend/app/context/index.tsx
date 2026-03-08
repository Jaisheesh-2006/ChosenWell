"use client";

import { ReactNode } from "react";
import { ThemeProvider } from "./ThemeContext";
import { CurrencyProvider } from "./CountryContext";
import { RecentlyViewedProvider } from "./RecentlyViewedContext";
import FeedbackWidget from "../components/FeedbackWidget";

export { useTheme, ThemeProvider } from "./ThemeContext";
export { useCurrency, CurrencyProvider } from "./CountryContext";
export {
  useRecentlyViewed,
  RecentlyViewedProvider,
} from "./RecentlyViewedContext";

interface ProvidersProps {
  children: ReactNode;
}

export function Providers({ children }: ProvidersProps) {
  return (
    <ThemeProvider>
      <CurrencyProvider>
        <RecentlyViewedProvider>
          <FeedbackWidget />
          {children}
        </RecentlyViewedProvider>
      </CurrencyProvider>
    </ThemeProvider>
  );
}
