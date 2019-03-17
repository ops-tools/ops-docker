#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

__noop() { :; }

#####

echo -n "Should exit with an error code when no config option passed"

source "${__target}"; set +e

_commands=("__noop")

main &>/dev/null

if [[ "$?" > 0 ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should exit with an error code when no config file found"

source "${__target}"; set +e

_commands=("__noop")

main -c foo/bar &>/dev/null

if [[ "$?" > 0 ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should load config as source"

source "${__target}"; set +e

_exec_remote() { :; }
_commands=("__noop")

main -c test/conf/docker.cfg &>/dev/null

if [[ "${basename}" == "ops-docker-test" ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should set image name to basename when omitted in the config"

source "${__target}"; set +e

_exec_remote() { :; }
_commands=("__noop")

main -c test/conf/docker.cfg &>/dev/null

if [[ "${images[0]}" == "${basename}" ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should exec commands remotely if config has remotes and no -l switch is set"

source "${__target}"

_exec_remote() {
  __ok
}

_exec() {
  __fail
}

_commands=("__noop")

main -c test/conf/docker.cfg

#####

echo -n "Should exec commands locally if no remotes in the config"

source "${__target}"

_exec() {
  __ok
}

_exec_remote() {
  __fail
}

_commands=("__noop")

main -c test/conf/local.cfg

#####

echo -n "Should exec commands locally if -l switch is on"

source "${__target}"

_exec() {
  __ok
}

_exec_remote() {
  __fail
}

_commands=("__noop")

main -c test/conf/docker.cfg -l

#####

echo -n "Should resolve id for the working script"

source "${__target}"

_exec_remote() { :; }
_commands=("__noop")

main -c test/conf/docker.cfg &>/dev/null

if [[ "${_work_script}" =~ ^[a-z0-9]+$ && "${#_work_script}" == 64 ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should resolve id for the working config"

source "${__target}"

_exec_remote() { :; }
_commands=("__noop")

main -c test/conf/docker.cfg &>/dev/null

if [[ "${_work_config}" =~ ^[a-z0-9]+$ &&"${#_work_config}" == 64 ]]; then
  __ok
else
  __fail
fi

######

echo
