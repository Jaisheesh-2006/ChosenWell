package email

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
)

const defaultResendAPIURL = "https://api.resend.com"

type resendEmailRequest struct {
	From    string   `json:"from"`
	To      []string `json:"to"`
	Subject string   `json:"subject"`
	Text    string   `json:"text"`
}

func SendFeedbackReply(toEmail string, sentiment string) error {
	apiKey := strings.TrimSpace(os.Getenv("RESEND_API_KEY"))
	fromEmail := strings.TrimSpace(os.Getenv("RESEND_FROM_EMAIL"))
	fromName := strings.TrimSpace(os.Getenv("RESEND_FROM_NAME"))
	apiURL := strings.TrimRight(strings.TrimSpace(os.Getenv("RESEND_API_URL")), "/")

	if apiKey == "" {
		return fmt.Errorf("RESEND_API_KEY is not configured")
	}
	if fromEmail == "" {
		return fmt.Errorf("RESEND_FROM_EMAIL is not configured")
	}
	if fromName == "" {
		fromName = "ChosenWell"
	}
	if apiURL == "" {
		apiURL = defaultResendAPIURL
	}

	subject, body := buildReplyTemplate(sentiment)
	payload := resendEmailRequest{
		From:    fmt.Sprintf("%s <%s>", fromName, fromEmail),
		To:      []string{toEmail},
		Subject: subject,
		Text:    body,
	}

	requestBody, err := json.Marshal(payload)
	if err != nil {
		return fmt.Errorf("failed to marshal resend payload: %w", err)
	}

	req, err := http.NewRequest(http.MethodPost, apiURL+"/emails", bytes.NewReader(requestBody))
	if err != nil {
		return fmt.Errorf("failed to create resend request: %w", err)
	}
	req.Header.Set("Authorization", "Bearer "+apiKey)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return fmt.Errorf("failed to call resend API: %w", err)
	}
	defer resp.Body.Close()

	responseBody, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Errorf("failed to read resend response: %w", err)
	}

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		return fmt.Errorf("resend API returned %d: %s", resp.StatusCode, strings.TrimSpace(string(responseBody)))
	}

	return nil
}

func buildReplyTemplate(sentiment string) (string, string) {
	if sentiment == "positive" {
		return "Thank you for your feedback to ChosenWell", strings.TrimSpace(`Hi,

Thank you for taking the time to share your feedback with ChosenWell.

We are glad the experience felt useful to you. Notes like yours help us keep improving the site in the right direction.

Warm regards,
ChosenWell Team`)
	}

	return "We appreciate your feedback to ChosenWell", strings.TrimSpace(`Hi,

Thank you for writing to us and being honest about your experience.

We are sorry that something did not feel right. Your feedback has been noted carefully, and we are using it to improve ChosenWell.

If you are open to it, replying with one more detail would help us fix the issue faster.

Warm regards,
ChosenWell Team`)
}