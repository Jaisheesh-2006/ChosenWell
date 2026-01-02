package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/cors"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/api"
	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/db"
)

const Port = 8081

func main() {
	// Initialize database connection
	repo, err := db.New()
	if err != nil {
		log.Printf("Warning: Failed to connect to database: %v. Using mock data.\n", err)
		repo = nil
	} else {
		defer repo.Close()
		log.Println("Connected to PostgreSQL database")
	}

	// Set repository for API handlers
	api.SetRepository(repo)

	// Initialize router with middleware
	router := chi.NewRouter()

	// CORS must be at the very top of the middleware stack
	router.Use(cors.Handler(cors.Options{
		AllowedOrigins:   []string{"http://localhost:3000", "http://127.0.0.1:3000"},
		AllowedMethods:   []string{"GET", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Content-Type"},
		AllowCredentials: false,
		MaxAge:           300,
	}))

	router.Use(middleware.Logger)
	router.Use(middleware.Recoverer)

	// Register routes
	registerRoutes(router)

	// Server configuration
	addr := fmt.Sprintf(":%d", Port)
	server := &http.Server{
		Addr:    addr,
		Handler: router,
	}

	// Start server in a goroutine
	serverErrors := make(chan error, 1)
	go func() {
		log.Printf("Starting server on http://localhost%s\n", addr)
		serverErrors <- server.ListenAndServe()
	}()

	// Setup graceful shutdown with signal handling
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)

	select {
	case <-sigChan:
		log.Println("Shutdown signal received, gracefully shutting down...")
		shutdownServer(server)
	case err := <-serverErrors:
		// Only log non-nil errors; http.ErrServerClosed is expected on shutdown
		if err != nil && err != http.ErrServerClosed {
			log.Fatalf("Server error: %v\n", err)
		}
	}
}

// shutdownServer performs a graceful shutdown with a 5-second timeout.
func shutdownServer(server *http.Server) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := server.Shutdown(ctx); err != nil {
		log.Fatalf("Graceful shutdown failed: %v\n", err)
	}

	log.Println("Server shut down successfully")
}

// registerRoutes registers all API endpoints.
func registerRoutes(router *chi.Mux) {
	router.Get("/health", healthHandler)
	router.Get("/categories", api.GetCategories)
	router.Get("/categories/{slug}", api.GetCategory)
	router.Get("/products", api.GetProducts)
	router.Get("/products/filters", api.GetAvailableFilters)
	router.Get("/products/{slug}", api.GetProduct)
	router.Get("/products/{slug}/similar", api.GetSimilarProducts)
	router.Get("/currencies", api.GetCurrencies)
	router.Get("/methodology", api.GetMethodology)
}

// healthHandler returns the health status of the API.
func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	response := map[string]string{"status": "ok", "service": "health-products-api"}
	if err := json.NewEncoder(w).Encode(response); err != nil {
		log.Printf("Failed to encode health response: %v\n", err)
	}
}
