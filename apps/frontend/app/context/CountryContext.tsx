"use client";

import {
  createContext,
  useContext,
  ReactNode,
} from "react";

// Indian Rupee currency configuration
const INR_CURRENCY = {
  code: "INR",
  symbol: "₹",
  name: "Indian Rupee",
};

// Exchange rate from USD to INR
const USD_TO_INR_RATE = 83.12;

interface CurrencyContextType {
  currency: typeof INR_CURRENCY;
  formatPrice: (priceUSD: number) => string;
  formatPriceRange: (minUSD: number, maxUSD?: number) => string;
  formatPriceString: (priceString: string) => string;
}

const CurrencyContext = createContext<CurrencyContextType | undefined>(undefined);

export function CurrencyProvider({ children }: { children: ReactNode }) {
  const formatPrice = (priceUSD: number): string => {
    const convertedPrice = priceUSD * USD_TO_INR_RATE;
    return `${INR_CURRENCY.symbol}${convertedPrice.toLocaleString("en-IN", { maximumFractionDigits: 0 })}`;
  };

  const formatPriceRange = (minUSD: number, maxUSD?: number): string => {
    const minConverted = minUSD * USD_TO_INR_RATE;
    
    if (!maxUSD || minUSD === maxUSD) {
      return `${INR_CURRENCY.symbol}${minConverted.toLocaleString("en-IN", { maximumFractionDigits: 0 })}`;
    }
    
    const maxConverted = maxUSD * USD_TO_INR_RATE;
    return `${INR_CURRENCY.symbol}${minConverted.toLocaleString("en-IN", { maximumFractionDigits: 0 })} - ${INR_CURRENCY.symbol}${maxConverted.toLocaleString("en-IN", { maximumFractionDigits: 0 })}`;
  };

  // Parse and convert a price string like "$29-35" or "$45"
  const formatPriceString = (priceString: string): string => {
    const numbers = priceString.match(/[\d.]+/g);
    if (!numbers || numbers.length === 0) {
      return priceString;
    }

    const prices = numbers.map((n) => parseFloat(n));
    
    if (prices.length === 1) {
      return formatPrice(prices[0]);
    }
    
    return formatPriceRange(prices[0], prices[1]);
  };

  return (
    <CurrencyContext.Provider
      value={{
        currency: INR_CURRENCY,
        formatPrice,
        formatPriceRange,
        formatPriceString,
      }}
    >
      {children}
    </CurrencyContext.Provider>
  );
}

export function useCurrency() {
  const context = useContext(CurrencyContext);
  if (context === undefined) {
    throw new Error("useCurrency must be used within a CurrencyProvider");
  }
  return context;
}
