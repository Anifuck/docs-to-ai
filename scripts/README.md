# Скрипты (разработка и обслуживание)

Запускайте из **корня repo** или двойным щелчком — в начале каждого `.ps1` задан переход в корень.

| Скрипт | Назначение |
|--------|------------|
| `start-DocsToAI-in-docker.ps1` | Сборка и `docker compose up -d` |
| `docker-stop.ps1` | Остановка контейнера |
| `rebuild-DocsToAI-container.ps1` | Пересборка образа |
| `2.scan-all-my-documents-in-python.ps1` | Scan без Docker (локальный Python) |
| `1.setup-python-env.ps1` | Локальное venv (без Docker) |
| `3.run-mcp-server-in-python.ps1` | MCP локально |

Для обычной работы достаточно команд из `docs/INSTRUKCIYA-RAG.txt`.
