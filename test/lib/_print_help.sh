#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

######

echo -n "Should print usage message"

source "${__target}"

if [[ "$(_print_help)" = *"Usage:"* ]]; then
  __ok
else
  __fail
fi

######

echo
