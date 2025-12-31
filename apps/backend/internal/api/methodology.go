package api

import (
	"net/http"
)

// ScoringCriterion describes one dimension of the health score.
type ScoringCriterion struct {
	Name        string `json:"name"`
	Weight      int    `json:"weight"`
	Description string `json:"description"`
}

// Methodology describes how products are evaluated and scored.
type Methodology struct {
	Title       string             `json:"title"`
	Description string             `json:"description"`
	Criteria    []ScoringCriterion `json:"criteria"`
}

// methodology is the static scoring explanation returned by the API.
var methodology = Methodology{
	Title: "Health Score Methodology",
	Description: "Each product is evaluated across multiple dimensions by our team of " +
		"nutrition scientists and wellness researchers. The final score (0–100) reflects " +
		"overall quality, safety, and alignment with evidence-based health principles.",
	Criteria: []ScoringCriterion{
		{
			Name:   "Trust",
			Weight: 30,
			Description: "Brand transparency, third-party certifications, and supply chain " +
				"traceability. We prioritize companies with open sourcing practices.",
		},
		{
			Name:   "Ingredients",
			Weight: 40,
			Description: "Purity of ingredients, absence of harmful additives, and use of " +
				"bioavailable forms. Organic, non-GMO, and sustainably sourced inputs score higher.",
		},
		{
			Name:   "Effectiveness",
			Weight: 30,
			Description: "Clinical evidence, dosage adequacy, and real-world user feedback. " +
				"Products must demonstrate tangible health benefits without overclaiming.",
		},
	},
}

// GetMethodology returns the static scoring methodology as JSON.
func GetMethodology(w http.ResponseWriter, r *http.Request) {
	writeJSON(w, http.StatusOK, methodology, nil)
}
