FROM python:3.13-alpine AS builder
COPY --from=ghcr.io/astral-sh/uv:0.12 /uv /bin/
ENV UV_LINK_MODE=copy UV_COMPILE_BYTECODE=0
WORKDIR /app
COPY pyproject.toml uv.lock .python-version ./
RUN uv sync --frozen --no-dev --no-install-project --python-preference only-system
COPY . .
RUN uv run --no-sync mkdocs build --strict

FROM registry.gitlab.com/ngine/docker-images/caddy:2
COPY --from=builder /app/site/ /usr/share/caddy/
