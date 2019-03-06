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

echo -n "Should exec commands remotely if config has remotes and no -l switch set"

source "${__target}"

_exec_remote() {
  __ok
}

_exec() {
  __fail
}

main -c test/conf/docker.cfg build

#####

echo -n "Should exec commands locally if no remotes in config"

source "${__target}"

_exec() {
  __ok
}

_exec_remote() {
  __fail
}

main -c test/conf/local.cfg build

#####

echo -n "Should exec commands locally if -l switch is on"

source "${__target}"

_exec() {
  __ok
}

_exec_remote() {
  __fail
}

main -c test/conf/docker.cfg -l build

#####

echo -n "Should test main function"
__fail

######

echo
