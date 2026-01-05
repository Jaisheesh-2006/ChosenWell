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

// getPort returns the port from PORT env variable or defaults to 8080
func getPort() string {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080" // Default for local development
	}
	return port
}

func main() {
	// Initialize router FIRST (before database)
	// This ensures health checks pass while database is connecting
	router := chi.NewRouter()

	// Health check MUST be before any middleware for Railway/cloud health checks
	router.Get("/api/health", healthHandler)

	// CORS configuration
	allowedOrigins := []string{
		"http://localhost:3000",
		"http://127.0.0.1:3000",
		"https://chosenwell.co.in",
		"https://www.chosenwell.co.in",
	}
	if frontendURL := os.Getenv("FRONTEND_URL"); frontendURL != "" {
		allowedOrigins = append(allowedOrigins, frontendURL)
	}

	router.Use(cors.Handler(cors.Options{
		AllowedOrigins:   allowedOrigins,
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
	port := getPort()
	addr := fmt.Sprintf("0.0.0.0:%s", port)
	server := &http.Server{
		Addr:    addr,
		Handler: router,
	}

	log.Printf("CORS allowed origins: %v", allowedOrigins)

	// Start server FIRST (so health checks pass immediately)
	serverErrors := make(chan error, 1)
	go func() {
		log.Printf("Starting server on port %s\n", port)
		serverErrors <- server.ListenAndServe()
	}()

	// Connect to database AFTER server starts (in background)
	go func() {
		log.Println("Connecting to database...")
		repo, err := db.New()
		if err != nil {
			log.Printf("Warning: Failed to connect to database: %v\n", err)
			log.Println("API endpoints will return 503 until database is available")
			return
		}
		log.Println("Connected to PostgreSQL database successfully!")
		api.SetRepository(repo)
	}()

	// Setup graceful shutdown
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)

	select {
	case <-sigChan:
		log.Println("Shutdown signal received, gracefully shutting down...")
		shutdownServer(server)
	case err := <-serverErrors:
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
