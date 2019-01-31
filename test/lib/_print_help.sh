#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

source "${__basepath}/__util.sh"

# Should print help message
echo -n "Should print help message"

source "${__target}"

if [[ "$(_print_help)" = *"Usage:"* ]]; then
  __ok
else
  __fail
fi

echo
