package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

type Product struct {
	ID          string `json:"id"`
	Name        string `json:"name"`
	Description string `json:"description"`
	Tag         string `json:"tag"`
}

var curatedProducts = []Product{
	{
		ID:          "rejuve-elixir",
		Name:        "Rejuve+ Herbal Elixir",
		Description: "Adaptogenic blend for calm focus.",
		Tag:         "Limited run",
	},
	{
		ID:          "oceanic-collagen",
		Name:        "Oceanic Collagen Blend",
		Description: "Marine collagen with vitamin C for skin resilience.",
		Tag:         "Research-backed",
	},
	{
		ID:          "grounded-ritual",
		Name:        "Grounded Adaptogenic Ritual",
		Description: "Functional cacao blend to reset the nervous system.",
		Tag:         "Editors' pick",
	},
}

type OrderRequest struct {
	ProductID string `json:"productId"`
	Quantity  int    `json:"quantity"`
}

func main() {
	r := chi.NewRouter()
	r.Use(middleware.RequestLogger(&middleware.DefaultLogFormatter{Logger: middleware.NewLogger()}))

	r.Get("/health", healthHandler)
	r.Get("/products", listProductsHandler)
	r.Get("/products/{productID}", getProductHandler)
	r.Post("/orders", createOrderHandler)

	fmt.Println("Backend running on http://localhost:8081")
	http.ListenAndServe(":8081", r)
}

func healthHandler(w http.ResponseWriter, _ *http.Request) {
	respondJSON(w, http.StatusOK, map[string]string{"status": "ok", "service": "curated-health backend"})
}

func listProductsHandler(w http.ResponseWriter, _ *http.Request) {
	respondJSON(w, http.StatusOK, curatedProducts)
}

func getProductHandler(w http.ResponseWriter, r *http.Request) {
	productID := chi.URLParam(r, "productID")
	for _, product := range curatedProducts {
		if product.ID == productID {
			respondJSON(w, http.StatusOK, product)
			return
		}
	}
	http.Error(w, "product not found", http.StatusNotFound)
}

func createOrderHandler(w http.ResponseWriter, r *http.Request) {
	var order OrderRequest
	if err := json.NewDecoder(r.Body).Decode(&order); err != nil {
		http.Error(w, "invalid payload", http.StatusBadRequest)
		return
	}

	// TODO: wire up real order capture and persistence
	respondJSON(w, http.StatusAccepted, map[string]string{
		"message":   "order queued",
		"productId": order.ProductID,
		"estimated": "Expect shipment confirmation within 24 hours",
	})
}

func respondJSON(w http.ResponseWriter, status int, payload any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(payload)
}
