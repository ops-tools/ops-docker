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

assemble &>/dev/null

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

assemble &>/dev/null

if [[ "${__hook}" == "post" ]]; then
  __ok
else
  __fail
fi

######

echo -n "Should set all image tags"

source "${__target}"
source "${__config}"

images=(
  "ops-docker-test-first"
  "ops-docker-test-next"
  "ops-docker-test-rest"
)

assemble &>/dev/null

__images=($(docker images -f 'reference=ops-docker-test-*' --format '{{.Repository}}'))

if [[ "${__images[@]}" =~ "ops-docker-test-first" &&
      "${__images[@]}" =~ "ops-docker-test-next" &&
      "${__images[@]}" =~ "ops-docker-test-rest" ]]; then
  __ok
else
  __fail
fi

docker rmi -f ${__images[@]} &>/dev/null

######

echo
