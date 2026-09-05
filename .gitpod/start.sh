#!/usr/bin/env bash
set -euo pipefail

# Start script: runs DB setup, builds Vite SSR assets, and starts Rails
cd hackatime

# Ensure env exists — we use Gitpod env vars for secrets
if [ ! -f .env ]; then
  echo ".env not found — creating from .env.example if present"
  cp .env.example .env || true
fi

echo "Running database setup (db:create db:schema:load db:seed) — this may fail if DATABASE_URL is not set."
# Run DB setup if rails and database are available
if [ -f bin/rails ]; then
  bin/rails db:create db:schema:load db:seed || echo "DB setup failed — you can run these commands manually once DATABASE_URL is set."
fi

if [ -f bin/vite ]; then
  echo "Building Vite (SSR)..."
  bin/vite build --ssr || echo "Vite build failed — try running 'yarn install' and re-run bin/vite build --ssr" 
fi

# Start Rails bound to all interfaces so Gitpod port forwarding works
if [ -f bin/rails ]; then
  echo "Starting Rails server on 0.0.0.0:3000"
  bin/rails server -b 0.0.0.0 -p 3000
else
  echo "No bin/rails found — aborting start."
  exit 1
fi
