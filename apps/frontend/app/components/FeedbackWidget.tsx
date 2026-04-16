"use client";

import { useMemo, useState } from "react";
import { submitFeedback } from "../lib/api";

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const MAX_FEEDBACK_LENGTH = 2000;

function validateEmail(email: string): boolean {
  return EMAIL_REGEX.test(email);
}

function FeedbackSparkIcon() {
  return (
    <svg
      className="h-5 w-5"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="1.8"
      aria-hidden="true"
    >
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M7.5 15H6a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-6l-4.5 4V15Z"
      />
      <path
        strokeLinecap="round"
        strokeLinejoin="round"
        d="M12 8.75v2.5M10.75 10h2.5"
      />
    </svg>
  );
}

export default function FeedbackWidget() {
  const [isOpen, setIsOpen] = useState(false);
  const [feedback, setFeedback] = useState("");
  const [email, setEmail] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const remainingCharacters = useMemo(
    () => MAX_FEEDBACK_LENGTH - feedback.length,
    [feedback],
  );

  async function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const trimmedFeedback = feedback.trim();
    const trimmedEmail = email.trim();

    if (!trimmedFeedback) {
      setError("Please share your feedback before submitting.");
      return;
    }

    if (trimmedFeedback.length > MAX_FEEDBACK_LENGTH) {
      setError(`Feedback must stay within ${MAX_FEEDBACK_LENGTH} characters.`);
      return;
    }

    if (!trimmedEmail || !validateEmail(trimmedEmail)) {
      setError("Please enter a valid email address.");
      return;
    }

    setIsSubmitting(true);
    setError(null);
    setSuccessMessage(null);

    try {
      await submitFeedback({
        email: trimmedEmail,
        feedback: trimmedFeedback,
      });
      setSuccessMessage("Thank you. Your feedback is on its way to us.");
      setFeedback("");
      setEmail("");
    } catch (submissionError) {
      setError(
        submissionError instanceof Error
          ? submissionError.message
          : "We could not send your feedback right now. Please try again.",
      );
    } finally {
      setIsSubmitting(false);
    }
  }

  return (
    <div className="pointer-events-none fixed bottom-4 right-4 z-[60] sm:bottom-6 sm:right-6">
      {isOpen ? (
        <section
          id="feedback-panel"
          className="pointer-events-auto w-[min(22rem,calc(100vw-2rem))] overflow-hidden rounded-2xl border border-border bg-surface-raised/95 shadow-xl backdrop-blur-xl animate-slide-up"
        >
          <div className="bg-gradient-to-br from-hero-start to-hero-end px-5 py-4 text-white">
            <div className="flex items-start justify-between gap-4">
              <div>
                <div className="inline-flex items-center gap-2 rounded-full border border-white/20 bg-white/10 px-3 py-1 text-[11px] font-semibold uppercase tracking-[0.22em] text-white/90 backdrop-blur">
                  <span className="inline-flex h-2 w-2 rounded-full bg-accent shadow-[0_0_12px_rgba(212,168,83,0.5)]" />
                  ChosenWell Feedback
                </div>
                <h2 className="mt-1 text-lg font-semibold">
                  Tell us one real thing.
                </h2>
                <p className="mt-2 max-w-xs text-sm leading-6 text-white/70">
                  Got a minute? Share one genuine thought so we can improve.
                </p>
              </div>
              <button
                type="button"
                onClick={() => {
                  setIsOpen(false);
                  setError(null);
                  setSuccessMessage(null);
                }}
                className="rounded-full border border-white/20 p-2 text-white transition hover:bg-white/10"
                aria-label="Close feedback form"
              >
                <svg
                  className="h-4 w-4"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.8"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    d="M6 6l12 12M18 6L6 18"
                  />
                </svg>
              </button>
            </div>
          </div>

          <form className="space-y-4 px-5 py-5" onSubmit={handleSubmit}>
            <label className="block">
              <span className="mb-2 block text-sm font-medium text-text">
                Your feedback
              </span>
              <textarea
                value={feedback}
                onChange={(event) => setFeedback(event.target.value)}
                placeholder="What felt useful, confusing, missing, or worth fixing?"
                rows={5}
                maxLength={MAX_FEEDBACK_LENGTH}
                className="input-field"
              />
              <span className="mt-2 block text-right text-xs text-text-muted">
                {remainingCharacters} characters left
              </span>
            </label>

            <label className="block">
              <span className="mb-2 block text-sm font-medium text-text">
                Email
              </span>
              <input
                type="email"
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                placeholder="you@example.com"
                autoComplete="email"
                className="input-field"
              />
            </label>

            {error ? (
              <p className="rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
                {error}
              </p>
            ) : null}

            {successMessage ? (
              <p className="rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700">
                {successMessage}
              </p>
            ) : null}

            <div className="flex items-center justify-between gap-3">
              <p className="text-xs text-text-muted">
                We read every note and reply by email.
              </p>
              <button
                type="submit"
                disabled={isSubmitting}
                className="inline-flex min-w-28 items-center justify-center rounded-full bg-primary px-4 py-2.5 text-sm font-semibold text-white transition-all duration-200 hover:bg-primary-light disabled:cursor-not-allowed disabled:opacity-60"
              >
                {isSubmitting ? "Sending..." : "Send"}
              </button>
            </div>
          </form>
        </section>
      ) : null}

      <button
        type="button"
        onClick={() => {
          setIsOpen(true);
          setError(null);
          setSuccessMessage(null);
        }}
        className="pointer-events-auto group relative ml-auto inline-flex items-center gap-3 rounded-full border border-border bg-surface-raised/90 px-3 py-3 pr-4 text-left text-text shadow-feedback backdrop-blur-sm transition duration-300 hover:-translate-y-1 hover:border-primary/30 hover:shadow-feedback-hover"
        aria-expanded={isOpen}
        aria-controls="feedback-panel"
      >
        <span className="relative inline-flex h-11 w-11 items-center justify-center rounded-full bg-gradient-to-br from-primary to-primary-light text-white shadow-feedback-icon">
          <FeedbackSparkIcon />
        </span>
        <span className="flex flex-col">
          <span className="text-[10px] font-semibold uppercase tracking-[0.24em] text-text-muted transition-colors group-hover:text-primary">
            Quick Note
          </span>
          <span className="text-sm font-semibold text-text">
            Share feedback
          </span>
        </span>
      </button>
    </div>
  );
}
