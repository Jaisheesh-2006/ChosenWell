#!/bin/bash
set -e

echo "Running database migrations..."

# Run all migration files in order
for f in /docker-entrypoint-initdb.d/migrations/*.sql; do
    if [ -f "$f" ]; then
        echo "Executing $f..."
        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f "$f"
    fi
done

echo "Migrations completed successfully!"

echo "Running database seeds..."

# Run all seed files in order
for f in /docker-entrypoint-initdb.d/seeds/*.sql; do
    if [ -f "$f" ]; then
        echo "Executing $f..."
        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f "$f"
    fi
done

echo "Seeds completed successfully!"
