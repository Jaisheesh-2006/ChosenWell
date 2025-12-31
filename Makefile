FRONTEND_DIR := apps/frontend
BACKEND_DIR := apps/backend

.PHONY: dev frontend backend build lint docker clean

dev:
	./scripts/dev.sh

frontend:
	npm run dev --prefix $(FRONTEND_DIR)

backend:
	go run ./$(BACKEND_DIR)

build:
	npm run build --prefix $(FRONTEND_DIR)
	go build -o curated-backend ./$(BACKEND_DIR)

lint:
	npm run lint --prefix $(FRONTEND_DIR)

docker:
	docker-compose up --build

clean:
	rm -rf node_modules
	rm curated-backend
