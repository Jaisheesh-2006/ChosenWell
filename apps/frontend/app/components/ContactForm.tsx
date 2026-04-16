"use client";

import { useEffect, useRef, useState } from "react";
import { submitFeedback } from "../lib/api";

type FormState = "idle" | "submitting" | "success" | "error";

const SUBJECT_OPTIONS = [
  "Ingredient correction",
  "Methodology question",
  "Brand submission",
  "General feedback",
  "Other",
];

function SubjectDropdown({
  value,
  onChange,
}: {
  value: string;
  onChange: (val: string) => void;
}) {
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  // Close when clicking outside
  useEffect(() => {
    function onPointerDown(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) {
        setOpen(false);
      }
    }
    document.addEventListener("mousedown", onPointerDown);
    return () => document.removeEventListener("mousedown", onPointerDown);
  }, []);

  // Close on Escape
  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      if (e.key === "Escape") setOpen(false);
    }
    document.addEventListener("keydown", onKey);
    return () => document.removeEventListener("keydown", onKey);
  }, []);

  const label = value || "Select a topic";
  const hasValue = Boolean(value);

  return (
    <div ref={ref} className="relative">
      <button
        type="button"
        aria-haspopup="listbox"
        aria-expanded={open}
        onClick={() => setOpen((o) => !o)}
        className={[
          "input-field flex items-center justify-between text-left transition-colors",
          open ? "border-primary bg-white ring-2 ring-primary/20" : "",
          !hasValue ? "text-text-muted" : "text-text",
        ]
          .filter(Boolean)
          .join(" ")}
      >
        <span>{label}</span>
        <svg
          className={[
            "h-4 w-4 shrink-0 text-text-muted transition-transform duration-200",
            open ? "rotate-180" : "",
          ]
            .filter(Boolean)
            .join(" ")}
          fill="none"
          viewBox="0 0 24 24"
          strokeWidth={2}
          stroke="currentColor"
          aria-hidden="true"
        >
          <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
        </svg>
      </button>

      {open && (
        <ul
          role="listbox"
          className="absolute z-10 mt-1.5 w-full overflow-hidden rounded-2xl border border-border bg-white py-1 shadow-lg shadow-primary/10"
        >
          {SUBJECT_OPTIONS.map((option) => {
            const selected = value === option;
            return (
              <li
                key={option}
                role="option"
                aria-selected={selected}
                onClick={() => {
                  onChange(option);
                  setOpen(false);
                }}
                className={[
                  "flex cursor-pointer items-center justify-between px-4 py-2.5 text-sm transition-colors",
                  selected
                    ? "bg-primary/10 font-medium text-primary"
                    : "text-text hover:bg-surface",
                ]
                  .filter(Boolean)
                  .join(" ")}
              >
                <span>{option}</span>
                {selected && (
                  <svg
                    className="h-4 w-4 text-primary"
                    fill="none"
                    viewBox="0 0 24 24"
                    strokeWidth={2.5}
                    stroke="currentColor"
                    aria-hidden="true"
                  >
                    <path strokeLinecap="round" strokeLinejoin="round" d="M4.5 12.75l6 6 9-13.5" />
                  </svg>
                )}
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}

export default function ContactForm() {
  const [state, setState] = useState<FormState>("idle");
  const [form, setForm] = useState({
    name: "",
    email: "",
    subject: "",
    message: "",
  });
  const [errorMessage, setErrorMessage] = useState("");
  const [subjectTouched, setSubjectTouched] = useState(false);

  function handleChange(
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
  ) {
    setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setSubjectTouched(true);
    if (!form.subject) return;

    setState("submitting");
    setErrorMessage("");

    try {
      const feedback = `From: ${form.name}\nSubject: ${form.subject}\n\n${form.message}`;
      await submitFeedback({ email: form.email, feedback });
      setState("success");
      setForm({ name: "", email: "", subject: "", message: "" });
      setSubjectTouched(false);
    } catch (err) {
      setState("error");
      setErrorMessage(
        err instanceof Error ? err.message : "Something went wrong. Please try again.",
      );
    }
  }

  if (state === "success") {
    return (
      <div className="rounded-2xl border border-primary/20 bg-primary/5 p-8 text-center">
        <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-primary/10 text-primary">
          <svg
            className="h-7 w-7"
            fill="none"
            viewBox="0 0 24 24"
            strokeWidth={2}
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M4.5 12.75l6 6 9-13.5"
            />
          </svg>
        </div>
        <h3 className="text-xl font-semibold text-text">Message sent</h3>
        <p className="mt-2 text-text-muted">
          Thank you for reaching out. We usually respond within 48–72 hours.
        </p>
        <button
          type="button"
          onClick={() => setState("idle")}
          className="mt-6 text-sm font-medium text-primary hover:text-primary-light"
        >
          Send another message
        </button>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      <div className="grid gap-5 sm:grid-cols-2">
        {/* Name */}
        <div>
          <label
            htmlFor="contact-name"
            className="mb-1.5 block text-sm font-medium text-text"
          >
            Name
          </label>
          <input
            id="contact-name"
            name="name"
            type="text"
            required
            value={form.name}
            onChange={handleChange}
            placeholder="Your name"
            className="input-field"
          />
        </div>

        {/* Email */}
        <div>
          <label
            htmlFor="contact-email"
            className="mb-1.5 block text-sm font-medium text-text"
          >
            Email
          </label>
          <input
            id="contact-email"
            name="email"
            type="email"
            required
            value={form.email}
            onChange={handleChange}
            placeholder="you@example.com"
            className="input-field"
          />
        </div>
      </div>

      {/* Subject */}
      <div>
        <label className="mb-1.5 block text-sm font-medium text-text">
          Subject
        </label>
        <SubjectDropdown
          value={form.subject}
          onChange={(val) => setForm((prev) => ({ ...prev, subject: val }))}
        />
        {subjectTouched && !form.subject && (
          <p className="mt-1.5 text-xs text-red-500">Please select a topic.</p>
        )}
      </div>

      {/* Message */}
      <div>
        <label
          htmlFor="contact-message"
          className="mb-1.5 block text-sm font-medium text-text"
        >
          Message
        </label>
        <textarea
          id="contact-message"
          name="message"
          required
          rows={5}
          value={form.message}
          onChange={handleChange}
          placeholder="Be as specific as possible — it helps us respond faster."
          className="input-field resize-none"
        />
      </div>

      {/* Error */}
      {state === "error" && (
        <p className="text-sm text-red-600">{errorMessage}</p>
      )}

      {/* Submit */}
      <button
        type="submit"
        disabled={state === "submitting"}
        className="btn-primary w-full justify-center disabled:opacity-60"
      >
        {state === "submitting" ? "Sending…" : "Send message"}
        {state !== "submitting" && (
          <svg
            className="h-4 w-4"
            fill="none"
            viewBox="0 0 24 24"
            strokeWidth={2}
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
            />
          </svg>
        )}
      </button>
    </form>
  );
}
