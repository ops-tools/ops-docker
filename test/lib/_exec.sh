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

echo -n "Should test _exec function"
__fail

######

echo
