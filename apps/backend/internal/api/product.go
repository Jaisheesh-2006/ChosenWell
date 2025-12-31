package api

import (
	"errors"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/mock"
)

// GetProduct returns a single product by slug as JSON.
func GetProduct(w http.ResponseWriter, r *http.Request) {
	slug := chi.URLParam(r, "slug")

	product, err := mock.GetProduct(slug)
	if err != nil {
		if errors.Is(err, mock.ErrProductNotFound) {
			errorJSON(w, http.StatusNotFound, "product not found")
			return
		}

		// Unexpected error
		log.Printf("Error fetching product %q: %v\n", slug, err)
		errorJSON(w, http.StatusInternalServerError, "internal server error")
		return
	}

	writeJSON(w, http.StatusOK, product, nil)
}
