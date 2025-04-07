update:
  uv sync

ci:
  ./scripts/local_ci.sh

setup:
  ./scripts/setup_pyenv_uv.sh

build_docker:
  ./scripts/build_docker.sh

push_docker:
  ./scripts/push_docker.sh

upgrade:
  uv run ./scripts/upgrade.py