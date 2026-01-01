package api

import (
	"errors"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/mock"
)

// GetProducts returns a list of product summaries, optionally filtered.
func GetProducts(w http.ResponseWriter, r *http.Request) {
	categorySlug := r.URL.Query().Get("category")

	var products interface{}
	if categorySlug != "" {
		products = mock.GetProductSummariesByCategory(categorySlug)
	} else {
		products = mock.GetAllProducts()
	}

	writeJSON(w, http.StatusOK, products, nil)
}

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
		log.Printf("Error fetching product %q: %v\\n", slug, err)
		errorJSON(w, http.StatusInternalServerError, "internal server error")
		return
	}

	writeJSON(w, http.StatusOK, product, nil)
}

// GetSimilarProducts returns products similar to the given product.
func GetSimilarProducts(w http.ResponseWriter, r *http.Request) {
	slug := chi.URLParam(r, "slug")

	// Parse limit query param, default to 6
	limit := 6
	if limitStr := r.URL.Query().Get("limit"); limitStr != "" {
		if parsed, err := strconv.Atoi(limitStr); err == nil && parsed > 0 {
			limit = parsed
		}
	}

	similar, err := mock.GetSimilarProducts(slug, limit)
	if err != nil {
		if errors.Is(err, mock.ErrProductNotFound) {
			errorJSON(w, http.StatusNotFound, "product not found")
			return
		}

		log.Printf("Error fetching similar products for %q: %v\\n", slug, err)
		errorJSON(w, http.StatusInternalServerError, "internal server error")
		return
	}

	writeJSON(w, http.StatusOK, similar, nil)
}
