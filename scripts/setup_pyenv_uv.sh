#!/bin/bash

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
cd "${PROJECT_DIR}" || exit 1

function err_exit {
    echo "$1" > /dev/stderr
    exit 1
}

command -v pyenv || err_exit "install pyenv first"

[ -f "${PROJECT_DIR}/.python-version" ] || err_exit "no .python-version file found, define one first"

PYTHON_VERSION=$(cat "${PROJECT_DIR}/.python-version")

pyenv install "${PYTHON_VERSION}"
pyenv local "${PYTHON_VERSION}"
pyenv exec pip install uv
pyenv exec uv sync
pyenv exec uv venv
source .venv/bin/activate