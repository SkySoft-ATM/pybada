#!/usr/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"/.. || exit 1

GIT_DESCRIBE=$(git describe --dirty)

# ssh-agent must be set up and running with the private key added
[ -f "${SSH_AUTH_SOCK}" ] || eval $(ssh-agent) && ssh-add
docker buildx build --ssh default --tag sample-python-project:"$GIT_DESCRIBE" --tag sample-python-project:latest --build-arg GIT_DESCRIBE="$GIT_DESCRIBE" .
