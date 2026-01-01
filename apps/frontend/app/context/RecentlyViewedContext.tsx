"use client";

import {
  createContext,
  useContext,
  useEffect,
  useState,
  ReactNode,
  useCallback,
} from "react";
import { ProductSummary } from "../lib/types";

const MAX_RECENT_PRODUCTS = 10;
const STORAGE_KEY = "recentlyViewed";

interface RecentlyViewedContextType {
  recentProducts: ProductSummary[];
  addProduct: (product: ProductSummary) => void;
  clearHistory: () => void;
}

const RecentlyViewedContext = createContext<RecentlyViewedContextType | undefined>(
  undefined
);

export function RecentlyViewedProvider({ children }: { children: ReactNode }) {
  const [recentProducts, setRecentProducts] = useState<ProductSummary[]>([]);
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
    // Load from localStorage
    try {
      const stored = localStorage.getItem(STORAGE_KEY);
      if (stored) {
        const parsed = JSON.parse(stored);
        if (Array.isArray(parsed)) {
          setRecentProducts(parsed);
        }
      }
    } catch (e) {
      console.error("Failed to load recently viewed products:", e);
    }
  }, []);

  const saveToStorage = useCallback((products: ProductSummary[]) => {
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(products));
    } catch (e) {
      console.error("Failed to save recently viewed products:", e);
    }
  }, []);

  const addProduct = useCallback(
    (product: ProductSummary) => {
      setRecentProducts((prev) => {
        // Remove if already exists (to move to front)
        const filtered = prev.filter((p) => p.slug !== product.slug);
        // Add to front, limit to max items
        const updated = [product, ...filtered].slice(0, MAX_RECENT_PRODUCTS);
        saveToStorage(updated);
        return updated;
      });
    },
    [saveToStorage]
  );

  const clearHistory = useCallback(() => {
    setRecentProducts([]);
    localStorage.removeItem(STORAGE_KEY);
  }, []);

  // Always provide context - empty array during SSR
  return (
    <RecentlyViewedContext.Provider
      value={{
        recentProducts,
        addProduct,
        clearHistory,
      }}
    >
      {children}
    </RecentlyViewedContext.Provider>
  );
}

export function useRecentlyViewed() {
  const context = useContext(RecentlyViewedContext);
  if (context === undefined) {
    throw new Error(
      "useRecentlyViewed must be used within a RecentlyViewedProvider"
    );
  }
  return context;
}
