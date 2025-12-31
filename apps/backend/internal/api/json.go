package api

import (
	"encoding/json"
	"log"
	"net/http"
)

// writeJSON sends a JSON response with the given status code, data, and optional headers.
func writeJSON(w http.ResponseWriter, status int, data any, headers http.Header) {
	// Apply custom headers first
	for key, values := range headers {
		for _, v := range values {
			w.Header().Add(key, v)
		}
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)

	if data != nil {
		if err := json.NewEncoder(w).Encode(data); err != nil {
			log.Printf("Failed to encode JSON response: %v\n", err)
		}
	}
}

// errorJSON sends a standardized JSON error response.
func errorJSON(w http.ResponseWriter, status int, message string) {
	payload := map[string]string{"error": message}
	writeJSON(w, status, payload, nil)
}
