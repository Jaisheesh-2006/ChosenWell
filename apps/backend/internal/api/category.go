package api

import (
	"errors"
	"net/http"

	"github.com/go-chi/chi/v5"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/mock"
)

// GetCategories returns all product categories as JSON.
func GetCategories(w http.ResponseWriter, r *http.Request) {
	categories := mock.GetCategories()
	writeJSON(w, http.StatusOK, categories, nil)
}

// GetCategory returns a single category with its curated products as JSON.
func GetCategory(w http.ResponseWriter, r *http.Request) {
	slug := chi.URLParam(r, "slug")

	category, err := mock.GetCategoryDetail(slug)
	if err != nil {
		if errors.Is(err, mock.ErrCategoryNotFound) {
			errorJSON(w, http.StatusNotFound, "category not found")
			return
		}
		errorJSON(w, http.StatusInternalServerError, "internal server error")
		return
	}

	writeJSON(w, http.StatusOK, category, nil)
}
