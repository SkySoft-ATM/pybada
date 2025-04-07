#!/bin/bash

# Function to build documentation using sphinx
build_docs() {
    if [ -d "source/apidoc" ]; then
        rm -rf "source/apidoc"
    fi
    mkdir -p "source/apidoc"
    sphinx-apidoc -e -T -f -o source/apidoc/ -t source/_templates/ ../src/hello
    make clean
    pip-licenses --with-description --with-authors --with-urls -f rst --output-file=source/licenses.rst
    {
      echo "Licenses"
      echo "========"
      cat source/licenses.rst
    } > temp.rst && mv temp.rst source/licenses.rst
    make html
}

# Ensure current working directory
DOCS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../docs" >/dev/null 2>&1 && pwd )"
cd "${DOCS_DIR}" || exit 1

# Execute the function
build_docs