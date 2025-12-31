package api

import (
	"net/http"
)

// Methodology describes how products are evaluated and scored (matches OpenAPI).
type Methodology struct {
	Version     string             `json:"version"`
	Summary     string             `json:"summary"`
	Scoring     map[string]float64 `json:"scoring"`
	LastUpdated string             `json:"last_updated"`
}

// methodology is the static scoring explanation returned by the API.
var methodology = Methodology{
	Version: "1.0",
	Summary: "Each product is evaluated across multiple dimensions by our team of " +
		"nutrition scientists and wellness researchers. The final score (0–100) reflects " +
		"overall quality, safety, and alignment with evidence-based health principles. " +
		"We assess Trust (brand transparency, certifications), Ingredients (purity, bioavailability), " +
		"and Effectiveness (clinical evidence, real-world feedback).",
	Scoring: map[string]float64{
		"trust":         0.30,
		"ingredients":   0.40,
		"effectiveness": 0.30,
	},
	LastUpdated: "2025-12-15",
}

// GetMethodology returns the static scoring methodology as JSON.
func GetMethodology(w http.ResponseWriter, r *http.Request) {
	writeJSON(w, http.StatusOK, methodology, nil)
}
