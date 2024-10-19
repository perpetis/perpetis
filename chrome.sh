#!/bin/bash
set -xeuo pipefail

function source_env() {
  if [ -f .env ]; then
    export $(cat .env | grep -v '#' | xargs)
  fi
}

##
source_env

export WEB_PORT="${WEB_PORT:-80}"

##
DOMAIN="openaide.localhost"
URLS=(
#
"http://redisinsight.${DOMAIN}:${WEB_PORT}/"
"http://redis-commander.${DOMAIN}:${WEB_PORT}/"
"http://pgadmin4.${DOMAIN}:${WEB_PORT}/"
"http://minio.${DOMAIN}:${WEB_PORT}/"
)

DATA_DIR="openaide"

##
function chrome() {
  case "$OSTYPE" in
    linux*)
      google-chrome "$@" --user-data-dir=/tmp/"$DATA_DIR" "${URLS[@]}"
      ;;
    darwin*)
      open -n -a "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --args "$@" --user-data-dir=/tmp/"$DATA_DIR" "${URLS[@]}"
      ;;
    msys*)
      "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "$@" --disable-gpu --user-data-dir=~/temp/"$DATA_DIR" "${URLS[@]}"
      ;;
    *)
      echo "$OSTYPE not supported"
      ;;
  esac
}

chrome "$@"
##