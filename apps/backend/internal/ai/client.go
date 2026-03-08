package ai

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
)

const defaultAIServiceURL = "http://localhost:8000"

type classifyFeedbackRequest struct {
	Feedback string `json:"feedback"`
}

type SentimentResult struct {
	Sentiment string `json:"sentiment"`
	Reason    string `json:"reason"`
}

func ClassifyFeedback(ctx context.Context, feedback string) (*SentimentResult, error) {
	serviceURL := strings.TrimRight(os.Getenv("AI_SERVICE_URL"), "/")
	if serviceURL == "" {
		serviceURL = defaultAIServiceURL
	}

	body, err := json.Marshal(classifyFeedbackRequest{Feedback: feedback})
	if err != nil {
		return nil, fmt.Errorf("failed to encode feedback request: %w", err)
	}

	req, err := http.NewRequestWithContext(
		ctx,
		http.MethodPost,
		serviceURL+"/classify",
		bytes.NewReader(body),
	)
	if err != nil {
		return nil, fmt.Errorf("failed to create sentiment request: %w", err)
	}
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to call sentiment service: %w", err)
	}
	defer resp.Body.Close()

	responseBody, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read sentiment response: %w", err)
	}

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("sentiment service returned %d: %s", resp.StatusCode, strings.TrimSpace(string(responseBody)))
	}

	var result SentimentResult
	if err := json.Unmarshal(responseBody, &result); err != nil {
		return nil, fmt.Errorf("failed to parse sentiment response: %w", err)
	}

	if result.Sentiment != "positive" && result.Sentiment != "negative" {
		return nil, fmt.Errorf("sentiment service returned invalid sentiment %q", result.Sentiment)
	}

	return &result, nil
}
