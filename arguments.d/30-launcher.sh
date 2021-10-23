#!/usr/bin/env bash
echo $0

main() {
  local sudo
  sudo="$( command -v sudo )"

  if ${sudo} tee /usr/bin/btrap >/dev/null <<EOT
script="\$( curl -sL https://raw.githubusercontent.com/j5pux/btrap/main/btrap )"
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
