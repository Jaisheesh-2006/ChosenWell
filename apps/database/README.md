# HealthIsWealth Database

PostgreSQL database for the curated health products platform.

## Structure

```
apps/database/
├── migrations/          # Ordered SQL migration files
│   ├── 001_initial_schema.sql
│   └── 002_add_views.sql
├── seeds/               # Sample data for development
│   └── 001_seed_data.sql
├── docker-compose.yml   # Local PostgreSQL container
├── .env.example         # Environment template
└── README.md
```

## Quick Start

### Using Docker (Recommended)

```bash
cd apps/database
docker-compose up -d
```

This starts PostgreSQL on port 5432 with:

- Database: `healthiswealth`
- User: `healthuser`
- Password: `healthpass` (change in production!)

### Run Migrations

```bash
# Using psql directly
psql -h localhost -U healthuser -d healthiswealth -f migrations/001_initial_schema.sql
psql -h localhost -U healthuser -d healthiswealth -f migrations/002_add_views.sql

# Or all at once
cat migrations/*.sql | psql -h localhost -U healthuser -d healthiswealth
```

### Seed Development Data

```bash
psql -h localhost -U healthuser -d healthiswealth -f seeds/001_seed_data.sql
```

## Connection String

```
postgresql://healthuser:healthpass@localhost:5432/healthiswealth
```

For the Go backend, set this as `DATABASE_URL` environment variable.

## Schema Overview

### Core Tables

- `categories` - Product categories (toothpaste, cooking-oil, vitamins)
- `products` - Main product catalog with scores and descriptions
- `certifications` - Third-party certifications (USDA Organic, NSF, etc.)
- `tags` - Filterable tags (vegan, organic, budget)

### Relationship Tables

- `product_recommendations` - Why we recommend each product
- `product_pros` / `product_cons` - Pros and cons lists
- `product_certifications` - Many-to-many product ↔ certification
- `product_tags` - Many-to-many product ↔ tag
- `buy_links` - Purchase links per product

### Views

- `v_category_summary` - For `/categories` endpoint
- `v_product_summary` - For `/products` listing
- `v_product_detail` - For `/products/{slug}` endpoint
- `v_category_detail` - For `/categories/{slug}` endpoint
- `v_current_methodology` - For `/methodology` endpoint

## Environment Variables

| Variable            | Description            | Default          |
| ------------------- | ---------------------- | ---------------- |
| `POSTGRES_USER`     | Database user          | `healthuser`     |
| `POSTGRES_PASSWORD` | Database password      | `healthpass`     |
| `POSTGRES_DB`       | Database name          | `healthiswealth` |
| `DATABASE_URL`      | Full connection string | -                |
