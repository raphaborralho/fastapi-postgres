FROM python:3.11-slim

WORKDIR /app

ENV PYTHONPATH=/app

RUN pip install poetry

COPY pyproject.toml ./

# Gerar o poetry.lock se não existir
RUN poetry lock

RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi --no-root

COPY ./app ./app

CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]