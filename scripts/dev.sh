#!/usr/bin/env bash
set -euo pipefail

npm install --prefix "$(dirname "$0")/../apps/frontend"

npm run dev --prefix "$(dirname "$0")/../apps/frontend" &
frontend_pid=$!

python -m uvicorn app.main:app --app-dir "$(dirname "$0")/../apps/feedback-ai" --host 0.0.0.0 --port 8000 &
ai_pid=$!

go run ./apps/backend &
backend_pid=$!

trap "kill $frontend_pid $ai_pid $backend_pid" EXIT
wait
