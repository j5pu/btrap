#!/bin/bash
# exit on 'BASH_EXIT'
#   BASH_EXIT                 true if caller has to exit/return with 0 (for instance: --help)

#######################################
# Arrays for bash4 and 'args' function. Called by 'args' to initialize vars with defaults on each run before parsing.
# Globals:
#   _HELP                     help (first line description if no 'NAME' in first line, otherwise second)
#                             message for function
#   BASH_CALLER_KEYS          separate array with keys to be printed always in the same order.
#   BASH_CALLER               caller associated array (keys: file, func, and line)
#   BASH_EXIT                 true if caller has to exit/return with 0 (for instance: --help)
#   BASH_PARAMS               function/scripts parameters array $@ without global arguments/options
#   BASH_RV                   return value array
#   BASH_RVA                  return value associated array
#   GLOBAL_ARGUMENTS          global function/script arguments, parsed by 'args' function (--desc, etc.)
#   GLOBAL_OPTIONS            global options associated array for function/script, could be used by function/script,
#                             zero o more than one (--verbose, etc.). Global options will be parsed by 'args' function
#                             and will update 'GLOBAL_OPTIONS'
# Arguments:
#   None              to avoid recursion with 'args' function
# Global Arguments:
#   --desc            show description and exit
#   --help            show help and exit
# Global Options:
#   None              to avoid recursion with 'args' function
# Outputs:
#   Writes description or help to stdout
# Returns:
#   1   is not running on bash 4 version
#######################################
arrays() {
  BASH_HELP=$(
  cat <<EOF
EOF
  )
  export BASH_CALLER="" BASH_CALLER_KEYS="" BASH_PARAMS="" BASH_RV="" BASH_RVA="" GLOBAL_OPTIONS=""

  if $IS_BASH4; then
    # https://stackoverflow.com/questions/60396504/why-dont-bash-associative-arrays-maintain-index-order
    BASH_CALLER_KEYS=("file" "func" "line")
    declare -A BASH_CALLER=(
      ["${BASH_CALLER_KEYS[0]}"]="${NULL}"
      ["${BASH_CALLER_KEYS[1]}"]="${NULL}"
      ["${BASH_CALLER_KEYS[2]}"]="${NULL}"
    )
    BASH_PARAMS=()
    BASH_RV=()
    declare -A BASH_RVA

    declare -A GLOBAL_OPTIONS=(
      ["--no-newline"]=false
      ["--no-stderr"]=false
      ["--no-stdout"]=false
      ["--separator="]=','
      ["--verbose"]=false
    )
  else
    return 1
  fi
  # Avoid recursion since we are being called by 'args' without global arguments (--desc, --help, ...).
  ( args "${@}" && $BASH_EXIT && return ) || return 1
}

args() {
  local _help
  _help=$(
    cat <<EOF
EOF
  )

  #
  # To avoid recursion, functions called by 'args' should called 'args' at the end:
  #
  if [ "$#" -ge 1 ] || ! $IS_BASH4; then
    return
  fi
  arrays

  local desc=false first help=false no_help=false rv save_option=true
  unset GLOBAL_OPTIONS
  export BASH_EXIT=false
  export BASH_PARAMS=() BASH_NO_NEWLINE=false BASH_NO_STDERR=false BASH_NO_STDOUT=false BASH_OPTIONS=() \
  BASH_SEPARATOR=', ' BASH_VERBOSE=false


  while (("${#}")); do
    if argument="$( echo "${GLOBAL_ARGUMENTS}" | grep "${1}" )"; then
      if $no_help && test -n "${BASH_HELP}"; then
        return
      fi
      if $help || $desc; then
        if test -n "${BASH_HELP}"; then
          rv=1
        else
          BASH_HELP="${_help}"
        fi
        if $desc; then
          first="$(sed -n 1p <<<"${BASH_HELP}")"
          [[ "${first}" != 'NAME' ]] && BASH_HELP="${first}" || BASH_HELP="$(sed -n 2p <<<"${BASH_HELP}")"
          # Trim leading/trailing space or tab characters and also squeeze sequences of tabs and spaces into a single space.
          BASH_HELP="$(awk '{$1=$1};1' <<<"${BASH_HELP}")"
        fi
        cat <<EOF
${BASH_HELP}
EOF
      fi
    else
      case "${1}" in
        --help) help=true ;;
        --desc) desc=true ;;
        --no-help) no_help=true ;;
        --version) version=true ;;  # TODO: Implement
        *)
          if ! $caller_skip; then # Not option/arrays functions.
            option "${1}"         # Sets 'BASH_RVA' to have key and value associated array for param.
            # If option and option in 'GLOBAL_OPTIONS' save the global option value and do not save in 'BASH_PARAMS'
            if [ "${BASH_RVA-}" ] && in "${BASH_RVA['key']}" "${!GLOBAL_OPTIONS[@]}"; then
              GLOBAL_OPTIONS["${BASH_RVA['key']}"]="${BASH_RVA['value']}"
              save_option=false # Do not save option in 'BASH_PARAMS'
            fi
            if $save_option; then
              BASH_PARAMS+=("${1}")
            fi
          fi
          ;;
      esac
      shift
    fi
  done

    unset BASH_HELP
    BASH_EXIT=true
}

die() {
  # f1() { die "*** an error occurred ***"; }
  # f2() { f1; }
  # f3() { f2; }
  #
  # f3
  BASH_HELP=$(
  cat <<EOF
EOF
  )
  ( args "${@}" && $BASH_EXIT && return ) || return 1

  local frame=0
  while caller $frame; do
    ((frame++))
  done
  echo "$*"
  return 1
}

in() {
  BASH_HELP=$(
  cat <<EOF
EOF
  )
  while (("${#}")); do
    # Avoid recursion since we are being called by 'args' without global arguments (--desc, --help, ...).
    case "${1}" in
      --help|--desc|--version) ( args "${@}" && $BASH_EXIT && return ) || return 1 ;;
    esac
    shift
  done

  if [ "${#}" -eq 2 ]; then
    pattern="^${1}$"
    shift
    if printf '%s\n' "${@}" | grep -q "${pattern}"; then
      unset pattern
      return
    else
      unset pattern
      return 1
    fi
  fi
  # Avoid recursion since we are being called by 'args' without global arguments (--desc, --help, ...).
  ( args "${@}" && $BASH_EXIT && return ) || return 1

}

#######################################
# Arrays for bash4 and 'args' function. Called by 'args' to initialize vars with defaults on each run before parsing.
# Globals:
#   BASH_HELP        help (first line description if no 'NAME' in first line, otherwise second) message for function
#   BASH_EXIT        true if caller has to exit/return with 0 (for instance: --help)
#   BASH_RVA         return value associated array
#   IS_BASH4         skip if not BASH 4 version or greater
# Arguments:
#   None              to avoid recursion with 'args' function
# Global Arguments:
#   --desc            show description and exit
#   --help            show help and exit
# Global Options:
#   None              to avoid recursion with 'args' function
# Outputs:
#   Writes description or help to stdout
#######################################
# bashsupport disable=BP2001
option() {
  # Can not have GLOBAL_OPTIONS TO AVOID RECURSION IN 'args'
  # option separator; echo "${RV[key]}"; echo ${RV[value]}; echo "${RV[value]}"; if ${RV[value]}; then echo 0; fi
  #
  #
  #
  # 0
  # option -s; echo "${RV[key]}"; if ${RV[value]}; then echo 0; fi
  # -s
  # 0
  # option --separator; echo "${RV[key]}"; echo ${RV[value]}; echo "${RV[value]}"; if ${RV[value]}; then echo 0; fi
  # --separator
  # true
  # true
  # 0
  # option --separator=; echo "${RV[key]}"; echo "${RV[value]}"
  # --separator=
  #
  # option --separator=''; echo "${RV[key]}"; echo "${RV[value]}"
  # --separator=
  #
  # option --separator=""; echo "${RV[key]}"; echo "${RV[value]}"
  # --separator=
  #
  # option --separator=1; echo "${RV[key]}"; echo "${RV[value]}"
  # --separator=
  # 1
  # option --separator='1'; echo "${RV[key]}"; echo "${RV[value]}"
  # --separator=
  # 1
  # option --separator="1"; echo "${RV[key]}"; echo "${RV[value]}"
  # --separator=
  # 1
  # option --separator="1 2"; echo "${RV[key]}"; echo "${RV[value]}"
  # --separator=
  # 1 2
  # option --separator="1 2"; echo "${RV[key]}"; echo "${RV[value]}"
  # --separator=
  # 1 2
  BASH_HELP=$(
  cat <<EOF
EOF
  )
  unset RV
  # TODO: !!!!!!!!!!!!!!! DEBO COMPROBAR que no es --help, --desc llamar a in pero tengo que cambiar la
  #  GLOBAL_OPTIONS para que pueda hacer un grep !!
  #### Para el in necesito la puta key oderrrrrr me cagooooooooo
  if $IS_BASH4 && [ "${1:0:1}" == "-" ] && ! in ; then
    declare -Axg RV
    if BASH_RVA['key']="$(grep -o "^.*=" <<<"${1}")"; then # from ^ to '=' (including '=')
      # shellcheck disable=SC2001
      BASH_RVA['value']="$(sed "s/['\"]//g" <<<"${1##*=}")" # value from '=' to end removing '"
    else
      BASH_RVA['key']="${1}" # if does not have '='
      BASH_RVA['value']=true
    fi
  fi

  # Avoid recursion since we are being called by 'args' without global arguments (--desc, --help, ...).
  ( args "${@}" && $BASH_EXIT && return ) || return 1
}

print-desc() {
  _help=""
  if [ "${1-}" ] && echo "${@}" | grep -q "--desc"; then
    rc=1
    if [ ! "${_HELP-}" ]; then
      _HELP="${_help}"
      rc=0
    fi
    echo "${_HELP}" | awk '!/NAME/ && !/^$/ && NR >= 1 && NR <= 3 { sub(/^[ \t]+/, ""); print }'
    return $rc
  fi
  unset _HELP
}

print-help() {
  _help=""
  if [ "${1-}" ] && echo "${@}" | grep -q "--help"; then
    rc=1
    if [ ! "${_HELP-}" ]; then
      _HELP="${_help}"
      rc=0
    fi
    echo "${_HELP}"
    return $rc
  fi
  unset _HELP
}
