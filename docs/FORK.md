# Форк docs-to-ai (проект AI Assistant)

Базовый upstream: [dorianmeric/docs-to-ai](https://github.com/dorianmeric/docs-to-ai)

## Отличия форка

| Изменение | Файл |
|-----------|------|
| MCP tools не рекурсируют | `mcp_server.py` → вызов `app.mcp_tools` |
| Модель эмбеддингов из env | `app/config.py` → `EMBEDDING_MODEL`, `EMBEDDING_DIMENSION`, префиксы E5 |
| Reranker из env, дефолт для RU | `RERANKER_MODEL` → `BAAI/bge-reranker-v2-m3` |
| Папка документов из `.env` | `HOST_DOCS_DIR` + `DOCS_DIR`, `app/config.py` |
| HTTP MCP для Docker | `docker-compose.yml` → `--sse`, `MCP_TRANSPORT=websocket` |

**Папка с документами:** по умолчанию `../data/documents` на диске → `/app/documents` в контейнере (см. `.env.example`).

### Модели по умолчанию (форк)

| Назначение | Hugging Face id | Размерность |
|------------|-----------------|-------------|
| Embedding | `intfloat/multilingual-e5-base` | 768 |
| Rerank | `BAAI/bge-reranker-v2-m3` | cross-encoder |

Для **multilingual-e5** автоматически добавляются префиксы `query: ` / `passage: ` при индексации и поиске.

Легче по RAM (хуже качество): `intfloat/multilingual-e5-small` + `EMBEDDING_DIMENSION=384`.

После смены embedding **обязательно** новая коллекция или очистка `data/cache/chromadb`, затем полный scan:

```powershell
cd D:\Project_AI_Assistent\docs-to-ai
docker compose up -d --build
docker exec docs-to-ai uv run python -m app.scan_all_my_documents
```

Пример `.env`:

```env
HOST_DOCS_DIR=../data/documents
DOCS_DIR=/app/documents
EMBEDDING_MODEL=intfloat/multilingual-e5-base
EMBEDDING_DIMENSION=768
RERANKER_MODEL=BAAI/bge-reranker-v2-m3
CHROMA_COLLECTION_NAME=documents-v1
USE_BM25=True
```

## Один раз: создать форк на GitHub

1. Откройте https://github.com/dorianmeric/docs-to-ai → **Fork** → ваш аккаунт (или org).
2. В PowerShell:

```powershell
cd D:\Project_AI_Assistent\docs-to-ai
git remote rename origin upstream
git remote add origin https://github.com/<ВАШ-LOGIN>/docs-to-ai.git
git push -u origin main
```

Дальше работаете с **origin** (форк), upstream — только для подтягивания обновлений:

```powershell
git fetch upstream
git merge upstream/main
```

## Клон для другой машины

```powershell
git clone https://github.com/<ВАШ-LOGIN>/docs-to-ai.git
cd docs-to-ai
copy .env.example .env
docker compose up -d --build
```

Папку документов задайте в `.env` (`HOST_DOCS_DIR`, `DOCS_DIR`), см. `.env.example`.
