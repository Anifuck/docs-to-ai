# # One-stage build for docs-to-ai MCP server using UV


FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

# Install only runtime dependencies for Debian
RUN apt-get update && apt-get install -y --no-install-recommends libmupdf-dev libfreetype6 libharfbuzz0b libopenjp2-7 libjbig2dec0 libjpeg62-turbo zlib1g 

# Set working directory
WORKDIR /app

# Copy manifests first for caching
COPY pyproject.toml uv.lock /app/

# Install dependencies (cached). --locked to ensure the dependencies in the lock file are used.
ENV UV_LINK_MODE=copy
RUN --mount=type=cache,target=/root/.cache/uv  uv sync --no-install-project

# Copy application code
COPY app/ /app/app/
COPY mcp_server.py /app/

# Pre-download models baked into the image (override at build via compose build.args)
ARG EMBEDDING_MODEL=intfloat/multilingual-e5-base
ARG RERANKER_MODEL=BAAI/bge-reranker-v2-m3
ARG USE_RERANKER=True
ENV EMBEDDING_MODEL=${EMBEDDING_MODEL}
ENV RERANKER_MODEL=${RERANKER_MODEL}
ENV USE_RERANKER=${USE_RERANKER}

RUN uv run python -m app.download_models

# Expose HTTP port
EXPOSE 38777

# Entrypoint runs both stdio and HTTP transports
ENTRYPOINT ["uv", "run", "python", "mcp_server.py"]

