#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

#####

echo -n "Should exit with error code when no config option passed"

source "${__target}"; set +e
__="$(main build &>/dev/null)"

if [[ "$?" > 0 ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should exit with error code when no config file found"

source "${__target}"; set +e
__="$(main -c foo/bar build &>/dev/null)"

if [[ "$?" > 0 ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should load config as source"

source "${__target}"
__="$(main -c test/conf/noop.cfg build 2>/dev/null)"

if [[ "${__}" == "noop" ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should test main function"
__fail

######

echo
