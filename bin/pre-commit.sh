#!/usr/bin/env bash
#
# Pre-commit hook to update info dir

#######################################
# Set INTERNET global variable
main() {
  local base branch compat file name root user
  cd "${1}" || return 1
  root="$(pwd)"
  name="${root##*/}"
  compat="${name}.d"
  file="${name}.text"
  user="$( git user )"
  branch="$( git remote-branch-default )"
  printf "" > "${file}"
  for i in "${compat}"/*; do
    base="$( basename "${i}" .sh )"
    echo "--${base} ${base} ${i} https://raw.githubusercontent.com/${user}/${name}/${branch}/${i}" >> "${file}"
  done
  git add "${file}"
}

main "${@}"
