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
          className="pointer-events-auto w-[min(22rem,calc(100vw-2rem))] overflow-hidden rounded-[1.75rem] border border-slate-200/80 bg-white/95 shadow-2xl shadow-slate-900/15 backdrop-blur dark:border-white/10 dark:bg-slate-950/95 dark:shadow-black/30"
        >
          <div className="bg-[radial-gradient(circle_at_top_left,_rgba(250,204,21,0.18),_transparent_30%),radial-gradient(circle_at_bottom_right,_rgba(14,165,233,0.18),_transparent_40%),linear-gradient(135deg,rgba(15,23,42,0.98),rgba(30,41,59,0.9))] px-5 py-4 text-white dark:bg-[radial-gradient(circle_at_top_left,_rgba(250,204,21,0.18),_transparent_28%),radial-gradient(circle_at_bottom_right,_rgba(56,189,248,0.2),_transparent_42%),linear-gradient(135deg,rgba(2,6,23,0.98),rgba(15,23,42,0.92))]">
            <div className="flex items-start justify-between gap-4">
              <div>
                <div className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/10 px-3 py-1 text-[11px] font-semibold uppercase tracking-[0.22em] text-amber-100/95 backdrop-blur">
                  <span className="inline-flex h-2 w-2 rounded-full bg-emerald-400 shadow-[0_0_12px_rgba(74,222,128,0.75)]" />
                  ChosenWell Feedback
                </div>
                <h2 className="mt-1 text-lg font-semibold">
                  Tell us one real thing.
                </h2>
                <p className="mt-2 max-w-xs text-sm leading-6 text-slate-200">
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
                className="rounded-full border border-white/15 p-2 text-slate-100 transition hover:bg-white/10"
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
              <span className="mb-2 block text-sm font-medium text-slate-700 dark:text-slate-200">
                Your feedback
              </span>
              <textarea
                value={feedback}
                onChange={(event) => setFeedback(event.target.value)}
                placeholder="What felt useful, confusing, missing, or worth fixing?"
                rows={5}
                maxLength={MAX_FEEDBACK_LENGTH}
                className="w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm text-slate-900 outline-none transition focus:border-sky-400 focus:bg-white focus:ring-2 focus:ring-sky-100 dark:border-white/10 dark:bg-slate-900 dark:text-slate-100 dark:focus:border-sky-400 dark:focus:bg-slate-950 dark:focus:ring-sky-500/20"
              />
              <span className="mt-2 block text-right text-xs text-slate-500 dark:text-slate-400">
                {remainingCharacters} characters left
              </span>
            </label>

            <label className="block">
              <span className="mb-2 block text-sm font-medium text-slate-700 dark:text-slate-200">
                Email
              </span>
              <input
                type="email"
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                placeholder="you@example.com"
                autoComplete="email"
                className="w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm text-slate-900 outline-none transition focus:border-sky-400 focus:bg-white focus:ring-2 focus:ring-sky-100 dark:border-white/10 dark:bg-slate-900 dark:text-slate-100 dark:focus:border-sky-400 dark:focus:bg-slate-950 dark:focus:ring-sky-500/20"
              />
            </label>

            {error ? (
              <p className="rounded-2xl border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-700 dark:border-rose-500/20 dark:bg-rose-500/10 dark:text-rose-200">
                {error}
              </p>
            ) : null}

            {successMessage ? (
              <p className="rounded-2xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700 dark:border-emerald-500/20 dark:bg-emerald-500/10 dark:text-emerald-200">
                {successMessage}
              </p>
            ) : null}

            <div className="flex items-center justify-between gap-3">
              <p className="text-xs text-slate-500 dark:text-slate-400">
                We read every note and reply by email.
              </p>
              <button
                type="submit"
                disabled={isSubmitting}
                className="inline-flex min-w-28 items-center justify-center rounded-full bg-slate-900 px-4 py-2.5 text-sm font-semibold text-white transition hover:bg-slate-700 disabled:cursor-not-allowed disabled:opacity-60 dark:bg-sky-400 dark:text-slate-950 dark:hover:bg-sky-300"
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
        className="pointer-events-auto group relative ml-auto inline-flex items-center gap-3 rounded-full border border-slate-200/80 bg-white/90 px-3 py-3 pr-4 text-left text-slate-900 shadow-[0_20px_60px_rgba(15,23,42,0.18)] transition duration-200 hover:-translate-y-1 hover:border-sky-300 hover:shadow-[0_26px_70px_rgba(14,165,233,0.22)] dark:border-white/10 dark:bg-slate-900/90 dark:text-slate-100 dark:shadow-[0_20px_60px_rgba(2,6,23,0.55)] dark:hover:border-sky-400 dark:hover:shadow-[0_28px_70px_rgba(14,165,233,0.16)]"
        aria-expanded={isOpen}
        aria-controls="feedback-panel"
      >
        <span className="absolute inset-0 -z-10 rounded-full bg-[radial-gradient(circle_at_left,_rgba(250,204,21,0.2),_transparent_30%),radial-gradient(circle_at_right,_rgba(14,165,233,0.2),_transparent_38%)] opacity-0 blur-xl transition duration-200 group-hover:opacity-100" />
        <span className="relative inline-flex h-11 w-11 items-center justify-center rounded-full bg-[linear-gradient(135deg,#0f172a,#1e3a8a_55%,#0ea5e9)] text-white shadow-[0_10px_24px_rgba(14,165,233,0.35)] dark:bg-[linear-gradient(135deg,#f59e0b,#f97316_45%,#0ea5e9)] dark:text-slate-950">
          <FeedbackSparkIcon />
        </span>
        <span className="flex flex-col">
          <span className="text-[10px] font-semibold uppercase tracking-[0.24em] text-slate-400 transition group-hover:text-sky-500 dark:text-slate-500 dark:group-hover:text-sky-300">
            Quick Note
          </span>
          <span className="text-sm font-semibold text-slate-900 dark:text-slate-100">
            Share feedback
          </span>
        </span>
      </button>
    </div>
  );
}
