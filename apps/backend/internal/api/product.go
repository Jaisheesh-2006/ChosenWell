package api

import (
	"errors"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/mock"
	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/types"
)

// ProductFilters represents the filter parameters for product queries.
type ProductFilters struct {
	Category   string
	Concern    []string
	Philosophy []string
	Budget     string
	Usage      []string
	SortBy     string
	Order      string
	Page       int
	Limit      int
}

// parseProductFilters extracts filter parameters from the request.
func parseProductFilters(r *http.Request) ProductFilters {
	query := r.URL.Query()

	page := 1
	if pageStr := query.Get("page"); pageStr != "" {
		if parsed, err := strconv.Atoi(pageStr); err == nil && parsed > 0 {
			page = parsed
		}
	}

	limit := 20
	if limitStr := query.Get("limit"); limitStr != "" {
		if parsed, err := strconv.Atoi(limitStr); err == nil && parsed > 0 && parsed <= 100 {
			limit = parsed
		}
	}

	return ProductFilters{
		Category:   query.Get("category"),
		Concern:    query["concern"],
		Philosophy: query["philosophy"],
		Budget:     query.Get("budget"),
		Usage:      query["usage"],
		SortBy:     query.Get("sortBy"),
		Order:      query.Get("order"),
		Page:       page,
		Limit:      limit,
	}
}

// GetProducts returns a list of product summaries, optionally filtered.
func GetProducts(w http.ResponseWriter, r *http.Request) {
	filters := parseProductFilters(r)

	result := mock.GetFilteredProducts(filters.Category, filters.Concern, filters.Philosophy, filters.Budget, filters.Usage, filters.SortBy, filters.Order, filters.Page, filters.Limit)

	writeJSON(w, http.StatusOK, result, nil)
}

// GetAvailableFilters returns the available filter options for products.
func GetAvailableFilters(w http.ResponseWriter, r *http.Request) {
	categorySlug := r.URL.Query().Get("category")
	filters := mock.GetAvailableFilters(categorySlug)
	writeJSON(w, http.StatusOK, filters, nil)
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

// ProductListResponse wraps the product list with pagination info.
type ProductListResponse struct {
	Products   []types.ProductSummary `json:"products"`
	TotalCount int                    `json:"totalCount"`
	Page       int                    `json:"page"`
	Limit      int                    `json:"limit"`
	TotalPages int                    `json:"totalPages"`
}
