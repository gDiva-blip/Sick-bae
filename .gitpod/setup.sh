#!/usr/bin/env bash
set -euo pipefail

# This script runs once when the Gitpod workspace is created.
# It clones the upstream hackatime repo into the workspace, installs
# Ruby/JS dependencies (via bundler/yarn), and leaves instructions for
# setting secrets in the Gitpod UI.

REPO_DIR="hackatime"
UPSTREAM="https://github.com/hackclub/hackatime.git"

echo "Cloning hackclub/hackatime into ./hackatime..."
if [ -d "$REPO_DIR" ]; then
  echo "Directory $REPO_DIR already exists — pulling latest changes..."
  (cd "$REPO_DIR" && git fetch --all && git reset --hard origin/main) || true
else
  git clone "$UPSTREAM" "$REPO_DIR"
fi

cd "$REPO_DIR"

# Copy .env example if missing
if [ ! -f .env ]; then
  if [ -f .env.example ]; then
    cp .env.example .env
    echo "Created .env from .env.example"
  else
    echo "No .env.example found in hackatime — you may need to add environment variables manually."
  fi
else
  echo ".env already exists — leaving it alone."
fi

# Remind the user to set required env vars in Gitpod (securely)
cat <<'INFO'

NEXT: Open the Gitpod workspace Settings -> Environment Variables and add the following variables (don’t paste them into the repo):

  HCA_CLIENT_ID
  HCA_CLIENT_SECRET
  SECRET_KEY_BASE
  ENCRYPTION_PRIMARY_KEY
  ENCRYPTION_DETERMINISTIC_KEY
  ENCRYPTION_KEY_DERIVATION_SALT
  DATABASE_URL (optional: Gitpod has a built-in Postgres or you can use the Docker Compose DB)

If you don't have those secrets yet, generate them with:
  ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"    # SECRET_KEY_BASE
  ruby -e "require 'securerandom'; puts SecureRandom.hex(16)"    # encryption keys (32 hex chars)

INFO

# Install Ruby gems and JS packages. Gitpod image includes Ruby/node usually.
# Use bundler and yarn if present.

if command -v gem >/dev/null 2>&1; then
  echo "Installing Ruby gems with bundler..."
  gem install bundler --no-document || true
  if [ -f Gemfile ]; then
    bundle config set --local path .bundle
    bundle install --jobs 4 || true
  fi
fi

if command -v yarn >/dev/null 2>&1; then
  if [ -f package.json ]; then
    echo "Installing JS dependencies with yarn..."
    yarn install --frozen-lockfile || yarn install || true
  fi
fi

echo "Setup script finished. Start the app with the start task (it will run migrations/build and launch Rails)."
