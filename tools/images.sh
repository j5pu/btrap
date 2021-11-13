#!/usr/bin/env bash

#######################################
# Input function with base images names (IMAGE_NAME -> DOCKER_REPO:DOCKER_TAG)
# Arguments:
#   None
# Outputs:
#   Base images names
#######################################
input() {
  echo "# alpine:edge (20210804)
# alpine:latest (3, 3.14)
alpine:latest
# alpine:3.13
# alpine:3.12

# archlinux:base-devel
archlinux:latest

# bash:devel
bash:latest
# bash:5.1
# bash:5.0
# bash:4.4

bats/bats:latest

busybox:latest

# centos:latest (8)
centos:latest
# centos:7

# debian:bookworm
# debian:bookworm-backports
# debian:bookworm-slim
# debian:latest (bullseye)
debian:latest
# debian:bullseye-backports
# debian:bullseye-slim
# debian:buster
# debian:buster-backports
# debian:buster-slim


# fedora:36
# fedora:latest (35)
fedora:latest
# fedora:34

# jrei/systemd-ubuntu:latest (20.04 - focal)
jrei/systemd-ubuntu:latest
# jrei/systemd-ubuntu:focal
# jrei/systemd-ubuntu:bionic

# kalilinux/kali-rolling:latest (armhf, arm64, amd64)
# apt -y install <package|kali-linux-headless|kali-linux-large>
kalilinux/kali-rolling:latest
kalilinux/kali-bleeding-edge:latest

nixos/nix:latest

python:3.9-alpine
python:3.9-bullseye
python:3.9-slim
python:3.10-alpine
python:3.10-bullseye
python:3.10-slim

richxsl/rhel7:latest

# 22.04, jammy, devel
# ubuntu:22.04
# 21.10, impish, rolling
# ubuntu:21.10
# 21.04, hirsute
# ubuntu:21.04
# ubuntu:latest (20.04, focal)
ubuntu:latest
# 16.04, xenial
# ubuntu:16.04
# 18.04, bionic
# ubuntu:18.04

zshusers/zsh:latest"
}

#######################################
# Helper to compare new generated file with existing and update if changed
# Globals:
#   file      Destination file.
#   tmp       Temp file generated.
# Arguments:
#   None
#######################################
cmp() {
  command cmp -s "${tmp}" "${file}" || { cp "${tmp}" "${file}"; echo "changed: ${file}"; }
}

#######################################
# Updates hooks with variable containing the output from output function
# Globals:
#   file      Destination file.
#   header    Header to search and add in files created or modified.
#   script    Script filename.
#   tmp       Temp file generated.
# Arguments:
#   None
#######################################
hooks() {
  local append filename
  append=$(cat << EOF
${header} ${script}
input=\$(cat <<eot
$(output)
eot
)

main
EOF
)
  for file in "${top}"/hooks/*; do
    [ -x "${file}" ] || chmod +x "${file}"
    filename="$(basename "${file}")"
    tmp="/tmp/${filename}"
    [ -w "${file}" ] && {
      sed -n "/^${header}/q;p" "${file}"
      echo "${append}"
    } > "${tmp}"
    cmp
  done
}

#######################################
# Docker hub user images names (IMAGE_NAME)
# Arguments:
#   None
# Outputs:
#   image name.
#######################################
images() {
  output | awk '{ print $2 }'
}

#######################################
# Creates profile.d/images.sh with docker hub user images names (IMAGE_NAME)
# Globals:
#   tmp       Temp file generated.
#   file      Destination file.
# Arguments:
#   None
# Returns:
#   1 if updated file when sourced does not have the value expected in 'IMAGES' variable.
#######################################
images-sh() {
  local filename
  filename="images.sh"
  file="${top}/profile.d/${filename}"
  tmp="/tmp/${filename}"
  cat > "${tmp}" <<EOF
${header} ${script}
# IMAGES:   Images Names (IMAGE_NAME -> DOCKER_REPO:DOCKER_TAG)
export IMAGES
IMAGES=\$(cat <<eot
$(images)
eot
)
EOF
  cmp && source "${tmp}" && { [ "$(images)" == "${IMAGES}" ] || \
    { echo -e "images:\n$(images)\IMAGES:\n${IMAGES}"; exit 1; }; }
}

#######################################
# Output images helper function
# Globals:
#   GIT       Docker Hub user name.
# Arguments:
#   None
# Outputs:
#   column 1: base image name (DOCKER_REPO:DOCKER_TAG), column 2: new image name for user repo (DOCKER_REPO:DOCKER_TAG).
#             -latest and -alpine stripped at the end of the line.
# ######################################
output() {
  local image name tag
  while read -r image tag; do
    name="$(basename "${image}")"
    echo "${image}:${tag} ${GIT}/${repo}:${name}-${tag}" | sed 's/-latest$//g; s/python-/python/g; s/-alpine$//g'
  done < <(awk -F ':' '!/^#/ && NF {print $1, $2}' "${directory}/images.text")
}

#######################################
# Base images and Local image names for testing
# Globals:
#   GIT       Docker Hub user name.
# Outputs:
#   column 1: base image name (DOCKER_REPO:DOCKER_TAG),
#   column 2: test image name (base image name with "test-" as prefix.
#######################################
tests() {
  hooks
  images-sh
  output | sed "s|${GIT}/|test-|g"
}

tests-images() {
  tests | awk '{ print $2 }'
}

#######################################
# Main function
# Globals:
#   GIT             Docker Hub user name.
#   header          Header to search and add in files created or modified.
#   script          Script filename.
#   top             Git repository path.
# Arguments:
#   hooks           Update Docker Hub hooks.
#   images          Show image names.
#   images-sh       Create profile.d/images.sh
#   output          Show output with base images and target images.
#   tests           Show Base images and local image names for testing.
#   tests-images    Show local image names for testing.
# Outputs:
#   Base image name with "test-" as prefix.
#######################################
main() {
  : "${GIT:=j5pu}"
  directory="$(dirname "${0}")"
  header="####################################### Autogenerated by:"
  script="$(basename "${0}")"
  top="$(git top)"
  repo="$(basename "${top}")"

  [ -x "${0}" ] || chmod +x "${0}"
  case "${1}" in hooks|images|images-sh|output|tests|tests-images) ${1} ;; esac
}

main "${@}"
