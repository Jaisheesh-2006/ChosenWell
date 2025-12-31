package api

import (
	"net/http"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/mock"
)

// GetCategories returns all product categories as JSON.
func GetCategories(w http.ResponseWriter, r *http.Request) {
	categories := mock.GetCategories()
	writeJSON(w, http.StatusOK, categories, nil)
}
