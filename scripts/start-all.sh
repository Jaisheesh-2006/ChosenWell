#!/usr/bin/env bash
set -euo pipefail

npm run build --prefix "$(dirname "$0")/../apps/frontend"
npm run start --prefix "$(dirname "$0")/../apps/frontend" &
frontend_pid=$!
go build -o curated-backend ./apps/backend
./curated-backend &
backend_pid=$!

trap "kill $frontend_pid $backend_pid" EXIT
wait
