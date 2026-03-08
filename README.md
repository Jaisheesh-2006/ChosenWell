_Status: scaffolding for the curated health-products experience._

# Curated Health Products Monorepo

## Structure

- `apps/frontend` – Next.js App Router (TypeScript), Tailwind, and MDX-driven editorial content with a hero, spotlight cards, and a story placeholder.
- `apps/backend` – Go `chi` HTTP service with health, catalog, and feedback handlers.
- `apps/feedback-ai` – FastAPI + LangChain service for feedback sentiment classification.
- `contracts/openapi.yaml` – shared OpenAPI definition for the exposed endpoints.
- `scripts/` – helper shells (`dev.sh`, `start-all`) that boot the local services together.
- `Makefile` – orchestrates dev, build, lint, and Docker flows.
- `docker-compose.yml` and Dockerfiles – quick spin-up of frontend, backend, and AI service.

## Getting started

1. Install prerequisites (run from the repo root):

   ```bash
   npm install --prefix apps/frontend
   go mod download
   pip install -r apps/feedback-ai/requirements.txt
   ```

2. Launch the local services in dev mode with live reload:

   ```bash
   ./scripts/dev.sh
   ```

3. Run the production-style stack (build + start):

   ```bash
   ./scripts/start-all.sh
   ```

4. Use Docker Compose to mirror local multi-service startup:

   ```bash
   docker-compose up --build
   ```

5. Refer to `contracts/openapi.yaml` for the latest API contract.

## TODOs

- Frontend: swap the placeholder MDX story, pull content from the CMS, and add personalization hooks.
- Backend: add stronger feedback persistence, retries, and auth/rate limiting as needed.
- Ops: automate `npm run lint`, `go test`, and Docker smoke tests in CI.
