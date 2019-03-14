#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

######

echo "Should parse rsync-style ssh URI"

### Without port

echo -n "  root@localhost:/root"

source "${__target}"

__result="$(_parse_uri "root@localhost:/root")"

if [[ "${__result}" == "root@localhost 22 /root" ]]; then
  __ok
else
  __fail
fi

### With port

echo -n "  root@localhost:2200/root"

source "${__target}"

__result="$(_parse_uri "root@localhost:2200/root")"

if [[ "${__result}" == "root@localhost 2200 /root" ]]; then
  __ok
else
  __fail
fi

echo

######

echo "Should parse URI with ssh scheme"

### Without port

echo -n "  ssh://root@localhost/root"

source "${__target}"

__result="$(_parse_uri "ssh://root@localhost/root")"

if [[ "${__result}" == "root@localhost 22 /root" ]]; then
  __ok
else
  __fail
fi

### With port

echo -n "  ssh://root@localhost:2200/root"

source "${__target}"

__result="$(_parse_uri "ssh://root@localhost:2200/root")"

if [[ "${__result}" == "root@localhost 2200 /root" ]]; then
  __ok
else
  __fail
fi

######

echo
