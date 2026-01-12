package api

import (
	"encoding/json"
	"log"
	"net/http"
)

// writeJSON sends a JSON response with the given status code, data, and optional headers.
// It ensures the response body contains only valid JSON with no extra output.
func writeJSON(w http.ResponseWriter, status int, data any, headers http.Header) {
	// Apply custom headers first
	for key, values := range headers {
		for _, v := range values {
			w.Header().Add(key, v)
		}
	}

	// Set JSON content type - must be before WriteHeader
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.Header().Set("X-Content-Type-Options", "nosniff")
	w.WriteHeader(status)

	if data != nil {
		// Marshal to bytes for cleaner output (no trailing newline from Encoder)
		jsonBytes, err := json.Marshal(data)
		if err != nil {
			// On marshal error, write a fallback error JSON
			log.Printf("Failed to marshal JSON response: %v", err)
			fallback := []byte(`{"error":"failed to encode response"}`)
			w.Write(fallback)
			return
		}
		if _, err := w.Write(jsonBytes); err != nil {
			log.Printf("Failed to write JSON response: %v", err)
		}
	}
}

// errorJSON sends a standardized JSON error response.
func errorJSON(w http.ResponseWriter, status int, message string) {
	payload := map[string]string{"error": message}
	writeJSON(w, status, payload, nil)
}

// SafeHandler wraps an HTTP handler with panic recovery that returns JSON errors.
// Use this for additional safety on critical endpoints.
func SafeHandler(handler http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		defer func() {
			if err := recover(); err != nil {
				log.Printf("Handler panic: %v", err)
				errorJSON(w, http.StatusInternalServerError, "internal server error")
			}
		}()
		handler(w, r)
	}
}
