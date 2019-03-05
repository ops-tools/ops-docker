#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

#####

echo -n "Should exit with error code when no config option passed"

source "${__target}"; set +e
main build &>/dev/null

if [[ "$?" > 0 ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should exit with error code when no config file found"

source "${__target}"; set +e
main -c foo/bar build &>/dev/null

if [[ "$?" > 0 ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should load config as source"

source "${__target}"; set +e
main -c test/conf/docker.cfg build &>/dev/null

if [[ "${basename}" == "ops-docker-test" ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should set image name to basename when omitted in config"

source "${__target}"; set +e
main -c test/conf/docker.cfg build &>/dev/null

if [[ "${images[0]}" == "${basename}" ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should test main function"
__fail

######

echo
