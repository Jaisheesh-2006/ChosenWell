#!/usr/bin/env bash
set -euo pipefail

npm install --prefix "$(dirname "$0")/../apps/frontend"

npm run dev --prefix "$(dirname "$0")/../apps/frontend" &
frontend_pid=$!

go run ./apps/backend &
backend_pid=$!

trap "kill $frontend_pid $backend_pid" EXIT
wait
