#!/bin/bash

__basepath="$(dirname "${BASH_SOURCE[0]}")"
__target="${__basepath}/../../ops-docker"

######

echo "Should parse config options"

### Should parse -c option

echo -n "  -c conf/local.cfg"

source "${__target}"
_parse_args "-c" "conf/local.cfg"

if [[ "${_config}" = "conf/local.cfg" ]]; then
  __ok
else
  __fail
fi

### Should parse --config option

echo -n "  --config conf/local.cfg"

source "${__target}"
_parse_args "--config" "conf/local.cfg"

if [[ "${_config}" = "conf/local.cfg" ]]; then
  __ok
else
  __fail
fi

echo

######

echo "Should parse local options"

### Should parse -l option

echo -n "  -l"

source "${__target}"
_parse_args "-l"

if [[ "${_force_local}" = true ]]; then
  __ok
else
  __fail
fi

### Should parse --local option

echo -n "  --local"

source "${__target}"
_parse_args "--local"

if [[ "${_force_local}" = true ]]; then
  __ok
else
  __fail
fi

echo

######

echo "Should parse help options"

### Should parse -h option

echo -n "  -h"

source "${__target}"
_parse_args "-h"

if [[ "${_help}" = true ]]; then
  __ok
else
  __fail
fi

### Should parse --help option

echo -n "  --help"

source "${__target}"
_parse_args "--help"

if [[ "${_help}" = true ]]; then
  __ok
else
  __fail
fi

echo

######

echo "Should parse commands"

### Should parse supported commands

echo -n "  transport prepare launch"

source "${__target}"
_parse_args "transport" "prepare" "launch"

if [[ "${_commands[@]}" = "transport prepare launch" ]]; then
  __ok
else
  __fail
fi

### Should parse commands preceded with options

echo -n "  -c conf/local.cfg transport prepare launch"

source "${__target}"
_parse_args "-c" "conf/local.cfg" "transport" "prepare" "launch"

if [[ "${_commands[@]}" = "transport prepare launch" ]]; then
  __ok
else
  __fail
fi

### Should parse commands mixed with options

echo -n "  transport prepare -c conf/local.cfg launch"

source "${__target}"
_parse_args "transport" "prepare" "-c" "conf/local.cfg" "launch"

if [[ "${_commands[@]}" = "transport prepare launch" ]]; then
  __ok
else
  __fail
fi

### Should parse commands followed with options

echo -n "  transport prepare launch -c conf/local.cfg"

source "${__target}"
_parse_args "transport" "prepare" "launch" "-c" "conf/local.cfg"

if [[ "${_commands[@]}" = "transport prepare launch" ]]; then
  __ok
else
  __fail
fi

### Should parse only supported commands

echo -n "  foo transport xx bar prepare launchME launch"

source "${__target}"
_parse_args "foo" "transport" "xx" "bar" "prepare" "launchME" "launch"

if [[ "${_commands[@]}" = "transport prepare launch" ]]; then
  __ok
else
  __fail
fi

echo

######

echo "Should correctly parse some mess"

### Should parse mixed supported and unsupported options and commands

echo -n "  -x foo -c bar prepare baz 123 -z"

source "${__target}"
_parse_args "-x" "foo" "-c" "bar" "prepare" "baz" "123" "-z"

if [[ "${_config}" = "bar" && "${_commands[@]}" = "prepare" ]]; then
  __ok
else
  __fail
fi

######

echo
