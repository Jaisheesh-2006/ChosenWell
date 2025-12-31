_Status: scaffolding for the curated health-products experience._

# Curated Health Products Monorepo

## Structure

- `apps/frontend` – Next.js App Router (TypeScript), Tailwind, and MDX-driven editorial content with a hero, spotlight cards, and a story placeholder.
- `apps/backend` – Go `chi` HTTP service with health, catalog, and order handlers plus TODO notes for persistence and auth.
- `contracts/openapi.yaml` – shared OpenAPI definition for the exposed endpoints.
- `scripts/` – helper shells (`dev.sh`, `start-all`) that boot both services together.
- `Makefile` – orchestrates dev, build, lint, and Docker flows.
- `docker-compose.yml` and Dockerfiles – quick spin-up of both apps in one command.

## Getting started

1. Install prerequisites (run from the repo root):

   ```bash
   npm install --prefix apps/frontend
   go mod download
   ```

2. Launch both services in dev mode with live reload:

   ```bash
   ./scripts/dev.sh
   ```

3. Run the production-style stack (build + start):

   ```bash
   ./scripts/start-all.sh
   ```

4. Use Docker Compose to mirror container deployments:

   ```bash
   docker-compose up --build
   ```

5. Refer to `contracts/openapi.yaml` for the latest API contract.

## TODOs

- Frontend: swap the placeholder MDX story, pull content from the CMS, and add personalization hooks.
- Backend: connect to a datastore, add authentication/authorization, and expand order fulfillment logic.
- Ops: automate `npm run lint`, `go test`, and Docker smoke tests in CI.
