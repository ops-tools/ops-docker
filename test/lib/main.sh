#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

#####

echo -n "Should exit with error code when no config option passed"

source "${__target}"; set +e
__=$(main build)

if [[ "$?" > 0 ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should exit with error code when no config file found"

source "${__target}"; set +e
__=$(main -c foo/bar build)

if [[ "$?" > 0 ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should test main function"
__fail

######

echo
