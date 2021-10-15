#!/usr/bin/env bash
# bashsupport disable=BP5001


#######################################
# Export variables.
# Globals:
#   APPLICATIONS_USER
#   GLOBAL_ARGUMENTS  global function/script arguments, parsed by 'args' function (--desc, etc.)
# PYPREFIX        Python prefix for CPython installation
# Arguments:
#   names             show exported variables names
#   print             show exported variables names and values
# Global Arguments:
#   --desc            show description and exit
#   --help            show help and exit
#   --version         show version and exit
# Outputs:
#   Writes description or help to stdout
#######################################
# shellcheck disable=SC2120
# bashsupport disable=BP2001
vars() {
  set-help() {
    _HELP=$(
      cat <<EOF
EOF
    )
  }

  vars-github() {
    export GITHUB="j5pux"
    export GITHUB_ID="4379404"
    export GITHUB_ORG="lumenbiomics"
    export GITHUB_EMAIL="63794670+${GITHUB}@users.noreply.github.com"
  }

  vars-names() {
    awk 'BEGIN { for ( v in ENVIRON ) { print v } }' | grep -Ev "${1}^_|^AWK|^XPC_|COMMAND_MODE|COMP_WORDBREAKS|\
  ITERM_ORIG_PS1|ITERM_PREV_PS1|SETENV|SHLVL|SSH_AUTH_SOCK|TERM_SESSION_ID|\
  TERMINAL_EMULATOR|%%$" | sort -u
  }

  vars-unset() {
    # shellcheck disable=SC2046
    unset $(vars-names "^HOME$|^LANG$|^LC_|OLD_PWD|^PATH|^PWD$|^USER$|")
    export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
  }

  vars-os() {
    unset var value
    if [ "$(uname -s)" = "Darwin" ]; then
      # shellcheck disable=SC2164
      APPLICATIONS_USER="$(
        cd "$(dscl . -read "/Users/${GITHUB}" \
          | awk '$1 ~ /NFSHomeDirectory/ { print $2 }')"/Applications
        pwd
      )"
    fi
    export APPLICATIONS_USER
  }

  set-help
  vars-unset
  vars-github
  vars-os

  while (("${#}")); do
    case "${1}" in
      names)
        vars-print
        return
        ;;
      print)
        vars-names | xargs -I{} echo "{}: $(env {})"
        return
        ;;
    esac
  done

  if [ "${1-}" ]; then
    # Avoid recursion since we are being called by 'args' without global arguments (--desc, --help, ...).
    (args "${@}" && $BASH_EXIT && return) || return 1
  fi

}

main() {
  _HELP=$(
    cat <<EOF
EOF
  )
  vars

  (args "${@}" && $BASH_EXIT && return) || return 1

  if $IS_INTERACTIVE; then
    if $IS_BASH; then
      echo "bash: interactive"
    else
      if $IS_ROOT; then
        PS1='sh # '
      else
        PS1='sh $ '
      fi
    fi
  else
    if $IS_BASH; then
      echo "bash: not interactive"
    else
      echo "shell: not interactive"
    fi
  fi
}

main "${@}"
