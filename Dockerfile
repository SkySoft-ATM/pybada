FROM python:3.12-slim-bookworm

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN apt-get update && apt-get install -y git ssh-client && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --shell /bin/bash appuser

ENV HOME=/home/appuser
ENV APP_HOME=$HOME/app

WORKDIR ${APP_HOME}

COPY ./src ./src
COPY pyproject.toml uv.lock ./
COPY CODEOWNERS .

RUN mkdir -p ${HOME}/.ssh ${HOME}/.cache ${HOME}/.config ${HOME}/.local ${APP_HOME} \
    && chown -R appuser:appuser ${HOME} \
    && ssh-keyscan -H github.com > ${HOME}/.ssh/known_hosts

USER appuser

ENV UV_CACHE_DIR=${HOME}/.cache
ENV UV_CONFIG_DIR=${HOME}/.config

CMD ["uv", "run", "--no-group", "dev", "--no-group", "docs", "hello"]
