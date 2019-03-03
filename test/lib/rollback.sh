#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

######

echo -n "Should test rollback function"
__fail

######

echo
