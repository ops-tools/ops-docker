#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

######

echo "Should set config defaults"

source "${__target}"

### Should set basename to empty string
echo -n "  basename=\"project\""

if [[ "${basename}" = "project" ]]; then
  __ok
else
  __fail
fi

### Should set networks to empty array
echo -n "  networks=(\"bridge\")"

if [[ "${networks[@]}" = "bridge" ]]; then
  __ok
else
  __fail
fi

### Should set images to empty array
echo -n "  images=()"

if [[ "${images[@]}" = "" ]]; then
  __ok
else
  __fail
fi

### Should set instances to 1
echo -n "  instances=1"

if [[ "${instances}" = 1 ]]; then
  __ok
else
  __fail
fi

### Should set remotes to empty array
echo -n "  remotes=()"

if [[ "${remotes[@]}" = "" ]]; then
  __ok
else
  __fail
fi

### Should set network_create_options to empty array
echo -n "  network_create_options=()"

if [[ "${network_create_options[@]}" = "" ]]; then
  __ok
else
  __fail
fi

### Should set network_connect_options to empty array
echo -n "  network_connect_options=()"

if [[ "${network_connect_options[@]}" = "" ]]; then
  __ok
else
  __fail
fi

### Should set build_options to empty array
echo -n "  build_options=()"

if [[ "${build_options[@]}" = "" ]]; then
  __ok
else
  __fail
fi

### Should set build_args to empty array
echo -n "  build_args=()"

if [[ "${build_args[@]}" = "" ]]; then
  __ok
else
  __fail
fi

### Should set create_options to empty array
echo -n "  create_options=()"

if [[ "${create_options[@]}" = "" ]]; then
  __ok
else
  __fail
fi

### Should set create_args to empty array
echo -n "  create_args=()"

if [[ "${create_args[@]}" = "" ]]; then
  __ok
else
  __fail
fi

### Should set start_options to empty array
echo -n "  start_options=()"

if [[ "${start_options[@]}" = "" ]]; then
  __ok
else
  __fail
fi

### Should set start_sleep to 0
echo -n "  start_sleep=0"

if [[ "${start_sleep}" = 0 ]]; then
  __ok
else
  __fail
fi

echo

######

echo "Should define hooks"

source "${__target}"

### Should define pre_build hook
echo -n "  pre_build"

if [[ "$(type -t pre_build)" = "function" ]]; then
  __ok
else
  __fail
fi

### Should define post_build hook
echo -n "  post_build"

if [[ "$(type -t post_build)" = "function" ]]; then
  __ok
else
  __fail
fi

### Should define pre_create hook
echo -n "  pre_create"

if [[ "$(type -t pre_create)" = "function" ]]; then
  __ok
else
  __fail
fi

### Should define post_create hook
echo -n "  post_create"

if [[ "$(type -t post_create)" = "function" ]]; then
  __ok
else
  __fail
fi

### Should define pre_start hook
echo -n "  pre_start"

if [[ "$(type -t pre_start)" = "function" ]]; then
  __ok
else
  __fail
fi

### Should define post_start hook
echo -n "  post_start"

if [[ "$(type -t post_start)" = "function" ]]; then
  __ok
else
  __fail
fi

######

echo
