package api

import (
	"errors"

	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/db"
)

// repo is the shared database repository
var repo *db.Repository

// ErrNoDatabase is returned when database is not connected
var ErrNoDatabase = errors.New("database not connected")

// SetRepository sets the database repository for all handlers
func SetRepository(r *db.Repository) {
	repo = r
}

// getRepo returns the repository or an error if not connected
func getRepo() (*db.Repository, error) {
	if repo == nil {
		return nil, ErrNoDatabase
	}
	return repo, nil
}
