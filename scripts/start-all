#!/usr/bin/env bash
set -euo pipefail

npm run build --prefix "$(dirname "$0")/../apps/frontend"
npm run start --prefix "$(dirname "$0")/../apps/frontend" &
frontend_pid=$!
python -m uvicorn app.main:app --app-dir "$(dirname "$0")/../apps/feedback-ai" --host 0.0.0.0 --port 8000 &
ai_pid=$!
go build -o curated-backend ./apps/backend
./curated-backend &
backend_pid=$!

trap "kill $frontend_pid $ai_pid $backend_pid" EXIT
wait
