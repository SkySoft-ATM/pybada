#!/bin/bash

# help message
usage="Run tests and linters on the project.

Usage: $(basename "$0") [OPTIONS]

Options:
    --fix       Run ruff's linter with the --fix option. For unsafe fixes or preview mode, run the ruff command manually with the desired options.
    --format    Run ruff's formatter. For preview mode, run the ruff command manually with the desired options.
    -h, --help  Display this help."


PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"
cd "${PROJECT_DIR}" || exit 1

ruff_check="uv tool run ruff check src tests docs"
ruff_format=false

# parsing options
while [ $# -gt 0 ]; do
    case $1 in
        --fix)
            ruff_check="$ruff_check --fix --show-fixes"
            ;;

        --format)
            ruff_format=true
            ;;

        -h | --help)
            echo "$usage"
            exit
            ;;

        *)
            echo -e "ERROR: Unknown option $1. Displaying help.\n-----"
            echo "$usage"
            exit 1
            ;;
    esac
    shift
done

if $ruff_format; then
    echo -e "\n----------\nFormatting\n----------"
    uv run ruff format src tests docs
fi

echo -e "\n------------------\nI - Running pytest\n------------------"
uv run pytest -v --cov --cov-report term
echo -e "\n-----------------\nII - Running ruff\n-----------------"
eval "$ruff_check"
echo -e "\n------------------\nIII - Running mypy\n------------------"
uv tool run mypy src tests docs
