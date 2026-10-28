# Форк docs-to-ai (проект AI Assistant)

Базовый upstream: [dorianmeric/docs-to-ai](https://github.com/dorianmeric/docs-to-ai)

## Отличия форка

| Изменение | Файл |
|-----------|------|
| MCP tools не рекурсируют | `mcp_server.py` → вызов `app.mcp_tools` |
| Модель эмбеддингов из env | `app/config.py` → `EMBEDDING_MODEL`, `EMBEDDING_DIMENSION` |
| HTTP MCP для Docker | `docker-compose.yml` → `--sse`, `MCP_TRANSPORT=websocket` |

Пример смены модели (после смены — очистить `cache/chromadb` и re-scan):

```env
EMBEDDING_MODEL=paraphrase-multilingual-MiniLM-L12-v2
EMBEDDING_DIMENSION=384
```

## Один раз: создать форк на GitHub

1. Откройте https://github.com/dorianmeric/docs-to-ai → **Fork** → ваш аккаунт (или org).
2. В PowerShell:

```powershell
cd D:\Project_AI_Assistent\docs-to-ai\repo
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

Документы проекта монтируйте в `docker-compose.yml` (volume на `knowledge` или `my-docs`).
