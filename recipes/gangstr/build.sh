#!/bin/bash

#  Created on Tuesday, 30 March  2021

# For debugging
set -o verbose

# Die on unset variables
set -o nounset
# Die on errors
set -o errexit
# Die if any part of a pipe fails
set -o pipefail

mkdir -p build
cd build
cmake ..
make
cmake --install . --prefix "${PREFIX}"
