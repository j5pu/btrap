#!/bin/sh

# Generate color.lib, colorf.lib and color.sh (bashpro).
#
set -eu

top="$(git top || exit)"
bin="${top}/bin"

libc="${bin}/color.lib"
libf="${bin}/colorf.lib"
pro="${top}/share/bashpro/color.sh"

script="$(basename "${0}")"

color() {
#  local co f
  co=${1}${4:-}; COLORS="${COLORS:-}${5:-}${co}"
  f="$(echo "${co}" | tr '[:upper:]' '[:lower:]')"

tee -a "${libc}" > /dev/null <<EOF
export ${co}='\033[${2}${3}'
EOF

tee -a "${libf}" > /dev/null <<EOF
# <html><h2>${f} - Show arguments in ${co}</h2>
# <h3>Examples</h3>
# <dl>
# <dt>Show arguments in ${co}:</dt>
# <dd>
# <pre><code class="language-bash">${f} Show Text
# </code></pre>
# </dd>
# </dl>
# </html>
${f}() { test "\$#" -eq 0 || { printf '%b' "\${${co}}"; printf '%s' "\$@"; printf '%b' "\${Reset}"; }; }

EOF

tee -a "${pro}" > /dev/null <<EOF
# <html><h2>${1} ${4:-}</h2>
# <p><strong><code>\$${co}</code></strong> Color ${1} ${4:-}.</p>
# </html>
export ${co}

EOF
}

tee "${libc}" > /dev/null <<EOF
# shellcheck shell=sh

# Color library (auto generated by: tools/${script})
#

if [ ! "\${Red-}" ]; then
EOF
chmod +x "${libc}"

tee "${libf}" > /dev/null <<EOF
# shellcheck shell=sh

# Color functions library (auto generated by: tools/${script})
#
if ! command -v red >/dev/null; then
  . color.lib

EOF
chmod +x "${libf}"

tee "${pro}" > /dev/null <<EOF
# shellcheck shell=sh disable=SC2034

# (auto generated by: tools/${script})

EOF


i=0; COLORS=""
color 'Reset' "${i}" 'm' '' ''
for c in Black Red Green Yellow Blue Magenta Cyan Grey; do
  color "${c}" "3${i}" 'm'    ''        ' '
  color "${c}" "3${i}" ';1m'  'Bold'    ' '
  color "${c}" "3${i}" ';2m'  'Dim'     ' '
  color "${c}" "3${i}" ';4m'  'Under'   ' '
  color "${c}" "3${i}" ';7m'  'Invert'  ' '
  color "${c}" "4${i}" 'm'    'Bg'      ' '
  i="$((i+1))"
done

echo "fi" >> "${libc}"
echo "fi" >> "${libf}"
