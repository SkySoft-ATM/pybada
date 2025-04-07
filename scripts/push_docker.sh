#!/usr/bin/bash

# Gcloud SDK setup for authent: https://cloud.google.com/sdk/docs/install-sdk#linux
# Credentials helper for Docker: gcloud auth configure-docker

set -ex

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"/.. || exit 1

if [ -n "$1" ]; then
  VERSION="$1"
  echo using specified version "$VERSION"
else
  VERSION=$(git describe --dirty)
fi

for tag in "$VERSION" latest; do
  docker tag docker.io/library/sample-python-project:"$VERSION" europe-west6-docker.pkg.dev/r-and-d-sandbox/rnd-docker/sample-python-project:"$tag"
  docker push europe-west6-docker.pkg.dev/r-and-d-sandbox/rnd-docker/sample-python-project:"$tag"
done