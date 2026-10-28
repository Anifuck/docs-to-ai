# docs-to-ai (форк AI Assistant)

RAG + MCP для поиска по PDF/Word. Запуск через Docker.

| Что | Где |
|-----|-----|
| **Инструкция для пользователей** | [docs/INSTRUKCIYA-RAG.txt](docs/INSTRUKCIYA-RAG.txt) |
| **Отличия форка, git, модели** | [docs/FORK.md](docs/FORK.md) |
| **Документы для индекса** | папка `docs-for-index/` |
| **Настройки** | `.env` (скопировать из `.env.example`) |
| **Скрипты (dev)** | [scripts/](scripts/) |
| **Upstream README** | [docs/upstream-readme.md](docs/upstream-readme.md) |

```powershell
cd D:\Project_AI_Assistent\docs-to-ai\repo
copy .env.example .env
docker compose up -d
docker exec docs-to-ai uv run python -m app.scan_all_my_documents
```

MCP в Cursor: `http://127.0.0.1:38777/mcp`
