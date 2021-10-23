#!/usr/bin/env bash
echo $0

#######################################
# System bootstrap install
# Globals:
#   _URL  githubusercontent url
main() {
  local sudo
  sudo="$( command -v sudo )"
  [ ! "${_URL-}" ] || return 1
  if ${sudo} tee /usr/bin/btrap >/dev/null <<EOT
script="\$( curl -sL "${_URL}/btrap" )"
if [ "\${script-}" ]; then
  if ((\${BASH_LINENO[1]:-0} != 0)); then
    source <<< "\${script}"
  else
    bash -c "\${script}"
  fi
fi
EOT
  then
    ${sudo} chmod +x /usr/bin/btrap
  else
    false
  fi
}
main
