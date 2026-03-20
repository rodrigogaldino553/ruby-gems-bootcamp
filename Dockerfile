# syntax=docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    postgresql-client \
    gnupg2 \
    build-essential \
    git \
    libpq-dev \
    libyaml-dev \
    pkg-config && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    npm install -g yarn && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set environment variables.
# For production, these should be overridden in docker-compose or environment.
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so" \
    NODE_OPTIONS="--openssl-legacy-provider"

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install node dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy application code
COPY . .

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start server
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
