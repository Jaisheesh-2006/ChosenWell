package api

import (
	"net/http"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/mock"
)

// GetCurrencies returns all supported currencies with exchange rates.
func GetCurrencies(w http.ResponseWriter, r *http.Request) {
	currencies := mock.GetCurrencies()
	writeJSON(w, http.StatusOK, currencies, nil)
}
