package api

import (
	"context"
	"encoding/json"
	"errors"
	"io"
	"log"
	"net/http"
	"net/mail"
	"strings"
	"time"

	ai "github.com/Jaisheesh-2006/healthiswealth/backend/internal/ai"
	mailer "github.com/Jaisheesh-2006/healthiswealth/backend/internal/email"
)

const (
	maxFeedbackBodySize = 8 * 1024
	maxFeedbackLength   = 2000
	feedbackTimeout     = 25 * time.Second
)

type feedbackRequest struct {
	Email    string `json:"email"`
	Feedback string `json:"feedback"`
}

type feedbackResponse struct {
	Status string `json:"status"`
}

func PostFeedback(w http.ResponseWriter, r *http.Request) {
	repository, err := getRepo()
	if err != nil {
		errorJSON(w, http.StatusServiceUnavailable, "database not connected")
		return
	}

	r.Body = http.MaxBytesReader(w, r.Body, maxFeedbackBodySize)
	defer r.Body.Close()

	var req feedbackRequest
	decoder := json.NewDecoder(r.Body)
	decoder.DisallowUnknownFields()

	if err := decoder.Decode(&req); err != nil {
		errorJSON(w, http.StatusBadRequest, "invalid request body")
		return
	}

	if err := decoder.Decode(&struct{}{}); !errors.Is(err, io.EOF) {
		errorJSON(w, http.StatusBadRequest, "request body must contain a single JSON object")
		return
	}

	email := strings.TrimSpace(req.Email)
	feedback := strings.TrimSpace(req.Feedback)

	if feedback == "" {
		errorJSON(w, http.StatusBadRequest, "feedback is required")
		return
	}

	if len(feedback) > maxFeedbackLength {
		errorJSON(w, http.StatusBadRequest, "feedback is too long")
		return
	}

	if err := validateFeedbackEmail(email); err != nil {
		errorJSON(w, http.StatusBadRequest, err.Error())
		return
	}

	if _, err := repository.SaveFeedback(r.Context(), email, feedback); err != nil {
		log.Printf("failed to save feedback: %v", err)
		errorJSON(w, http.StatusInternalServerError, "failed to save feedback")
		return
	}

	writeJSON(w, http.StatusAccepted, feedbackResponse{Status: "received"}, nil)

	go processFeedbackReply(email, feedback)
}

func validateFeedbackEmail(email string) error {
	if email == "" {
		return errors.New("email is required")
	}

	address, err := mail.ParseAddress(email)
	if err != nil || address.Address != email {
		return errors.New("email must be valid")
	}

	return nil
}

func processFeedbackReply(customerEmail string, feedback string) {
	ctx, cancel := context.WithTimeout(context.Background(), feedbackTimeout)
	defer cancel()

	result, err := ai.ClassifyFeedback(ctx, feedback)
	if err != nil {
		log.Printf("feedback sentiment classification failed: %v", err)
		return
	}

	if err := mailer.SendFeedbackReply(customerEmail, result.Sentiment); err != nil {
		log.Printf("feedback reply email failed: %v", err)
	}
}
