package api

import (
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/db"
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

	dbFilters := db.ProductFilters{
		Category:   filters.Category,
		Concern:    filters.Concern,
		Philosophy: filters.Philosophy,
		Budget:     filters.Budget,
		Usage:      filters.Usage,
		SortBy:     filters.SortBy,
		Order:      filters.Order,
		Page:       filters.Page,
		Limit:      filters.Limit,
	}
	result, err := repo.GetProducts(r.Context(), dbFilters)
	if err != nil {
		log.Printf("Database error getting products: %v", err)
		errorJSON(w, http.StatusInternalServerError, "failed to fetch products")
		return
	}
	writeJSON(w, http.StatusOK, result, nil)
}

// GetAvailableFilters returns the available filter options for products.
func GetAvailableFilters(w http.ResponseWriter, r *http.Request) {
	categorySlug := r.URL.Query().Get("category")

	filters, err := repo.GetAvailableFilters(r.Context(), categorySlug)
	if err != nil {
		log.Printf("Database error getting filters: %v", err)
		errorJSON(w, http.StatusInternalServerError, "failed to fetch filters")
		return
	}
	writeJSON(w, http.StatusOK, filters, nil)
}

// GetProduct returns a single product by slug as JSON.
func GetProduct(w http.ResponseWriter, r *http.Request) {
	slug := chi.URLParam(r, "slug")

	product, err := repo.GetProduct(r.Context(), slug)
	if err != nil {
		log.Printf("Database error getting product %s: %v", slug, err)
		errorJSON(w, http.StatusInternalServerError, "failed to fetch product")
		return
	}
	if product == nil {
		errorJSON(w, http.StatusNotFound, "product not found")
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

	similar, err := repo.GetSimilarProducts(r.Context(), slug, limit)
	if err != nil {
		log.Printf("Database error getting similar products for %s: %v", slug, err)
		errorJSON(w, http.StatusInternalServerError, "failed to fetch similar products")
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
