#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"
__config="${__basepath}/../conf/docker.cfg"

######

echo -n "Should call pre_build hook"

source "${__target}"
source "${__config}"

__hook=""

pre_build() {
  __hook="pre"
}

build &>/dev/null

if [[ "${__hook}" == "pre" ]]; then
  __ok
else
  __fail
fi

######

echo -n "Should call post_build hook"

source "${__target}"
source "${__config}"

__hook=""

post_build() {
  __hook="post"
}

build &>/dev/null

if [[ "${__hook}" == "post" ]]; then
  __ok
else
  __fail
fi

#####

echo -n "Should test build function"
__fail

######

echo
