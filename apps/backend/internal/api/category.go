package api

import (
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
)

// GetCategories returns all product categories as JSON.
func GetCategories(w http.ResponseWriter, r *http.Request) {
	repository, err := getRepo()
	if err != nil {
		log.Printf("Database not connected: %v", err)
		errorJSON(w, http.StatusServiceUnavailable, "database not connected")
		return
	}

	categories, err := repository.GetCategories(r.Context())
	if err != nil {
		log.Printf("Database error getting categories: %v", err)
		errorJSON(w, http.StatusInternalServerError, "failed to fetch categories")
		return
	}
	writeJSON(w, http.StatusOK, categories, nil)
}

// GetCategory returns a single category with its curated products as JSON.
func GetCategory(w http.ResponseWriter, r *http.Request) {
	slug := chi.URLParam(r, "slug")

	repository, err := getRepo()
	if err != nil {
		log.Printf("Database not connected: %v", err)
		errorJSON(w, http.StatusServiceUnavailable, "database not connected")
		return
	}

	category, err := repository.GetCategory(r.Context(), slug)
	if err != nil {
		log.Printf("Database error getting category %s: %v", slug, err)
		errorJSON(w, http.StatusInternalServerError, "failed to fetch category")
		return
	}
	if category == nil {
		errorJSON(w, http.StatusNotFound, "category not found")
		return
	}
	writeJSON(w, http.StatusOK, category, nil)
}
