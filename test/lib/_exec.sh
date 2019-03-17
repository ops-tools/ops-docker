#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

######

echo -n "Should call commands one by one"

source "${__target}"

__tmp=""

__foo() {
  __tmp+="foo"
}

__bar() {
  __tmp+="bar"
}

__baz() {
  __tmp+="baz"
}

_commands=("__foo" "__bar" "__baz")
_exec

if [[ "${__tmp}" == "foobarbaz" ]]; then
  __ok
else
  __fail
fi

######

echo -n "Should return an error code when one of the commands failed"

source "${__target}"; set +e

__foo() { :; }

__bar() {
  command_not_exists
}

_commands=("__foo" "__bar")
_exec &>/dev/null

if [[ "$?" > 0 ]]; then
  __ok
else
  __fail
fi

######

echo -n "Should not call next command if previous failed"

source "${__target}"; set +e

__tmp=""

__foo() {
  __tmp="foo"
  command_not_exists
}

__bar() {
  __tmp="bar"
}

_commands=("__foo" "__bar")
_exec &>/dev/null

if [[ "${__tmp}" == "foo" ]]; then
  __ok
else
  __fail
fi

######

echo -n "Should not call next command after context switch"

source "${__target}"; set +e

__tmp=""

__foo() {
  __tmp="foo"
}

_exec_remote() {
  __tmp="_exec_remote"
}

__bar() {
  __tmp="bar"
}

_commands=("__foo" "_exec_remote" "__bar")
_exec &>/dev/null

if [[ "${__tmp}" == "_exec_remote" ]]; then
  __ok
else
  __fail
fi

######

echo
