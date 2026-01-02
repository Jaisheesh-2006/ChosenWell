package api

import (
	"github.com/Jaisheesh-2006/healthiswealth/backend/internal/db"
)

// repo is the shared database repository
var repo *db.Repository

// SetRepository sets the database repository for all handlers
func SetRepository(r *db.Repository) {
	repo = r
}
