"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useState } from "react";

export default function NotFound() {
  const router = useRouter();
  const [isRetrying, setIsRetrying] = useState(false);

  const handleRetry = () => {
    setIsRetrying(true);
    router.refresh();
    setTimeout(() => {
      window.location.reload();
    }, 500);
  };

  return (
    <div className="flex min-h-[60vh] flex-col items-center justify-center px-4 py-16">
      <div className="text-center">
        <div className="mx-auto mb-6 flex h-24 w-24 items-center justify-center rounded-full bg-primary-lighter">
          <svg
            className="h-12 w-12 text-primary"
            fill="none"
            viewBox="0 0 24 24"
            strokeWidth={1.5}
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"
            />
          </svg>
        </div>
        <p className="text-sm font-medium uppercase tracking-wider text-primary">
          404 Error
        </p>
        <h1 className="mt-2 page-heading">
          Page not found
        </h1>
        <p className="mt-4 max-w-md text-text-muted">
          Sorry, we couldn&apos;t find the page you&apos;re looking for. It
          might have been moved, deleted, or there was a temporary loading
          issue.
        </p>
        <div className="mt-8 flex flex-wrap justify-center gap-4">
          <button
            onClick={handleRetry}
            disabled={isRetrying}
            className="btn-primary disabled:opacity-50"
          >
            {isRetrying ? (
              <>
                <svg
                  className="h-5 w-5 animate-spin"
                  fill="none"
                  viewBox="0 0 24 24"
                >
                  <circle
                    className="opacity-25"
                    cx="12"
                    cy="12"
                    r="10"
                    stroke="currentColor"
                    strokeWidth="4"
                  ></circle>
                  <path
                    className="opacity-75"
                    fill="currentColor"
                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                  ></path>
                </svg>
                Retrying...
              </>
            ) : (
              <>
                <svg
                  className="h-5 w-5"
                  fill="none"
                  viewBox="0 0 24 24"
                  strokeWidth={2}
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99"
                  />
                </svg>
                Try Again
              </>
            )}
          </button>
          <Link
            href="/"
            className="btn-secondary"
          >
            <svg
              className="h-5 w-5"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25"
              />
            </svg>
            Go Home
          </Link>
        </div>

        {/* Helpful Links */}
        <div className="mt-12">
          <p className="text-sm text-text-muted">You might be looking for:</p>
          <div className="mt-4 flex flex-wrap justify-center gap-4 text-sm">
            <Link
              href="/categories"
              className="text-primary hover:text-primary-light"
            >
              Categories
            </Link>
            <span className="text-border-strong">•</span>
            <Link
              href="/products"
              className="text-primary hover:text-primary-light"
            >
              Products
            </Link>
            <span className="text-border-strong">•</span>
            <Link
              href="/methodology"
              className="text-primary hover:text-primary-light"
            >
              Methodology
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
