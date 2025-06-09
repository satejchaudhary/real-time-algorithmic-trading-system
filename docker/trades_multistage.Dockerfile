# First, build the application in the `/app` directory.
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS builder
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy
ENV UV_PYTHON_DOWNLOADS=0

WORKDIR /app

# Copy project files first
COPY pyproject.toml uv.lock ./
COPY services /app/services

# Install dependencies
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync  --frozen --no-install-project --no-dev

# Install project
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev


# Then, use a final image without uv
FROM python:3.12-slim-bookworm
# It is important to use the image that matches the builder, as the path to the
# Python executable must be the same, e.g., using `python:3.11-slim-bookworm`
# will fail.

# Copy the application from the builder
COPY --from=builder --chown=app:app /app /app

# Place executables in the environment at the front of the path
ENV PATH="/app/.venv/bin:$PATH"

# Run the application by default
CMD ["python", "/app/services/trades/src/trades/main.py"]


# If you want to debug the file system, uncomment the line below
# This will keep the container running and allow you to exec into it
# CMD ["/bin/bash", "-c", "sleep 999999"]