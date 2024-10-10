#!/bin/bash
set -xeuo pipefail

function source_env() {
  if [ -f .env ]; then
    export $(cat .env | grep -v '#' | xargs)
  fi
}

##
source_env

PORT="${TRAEFIK_WEB_PORT:-80}"
ADMIN_PORT="${TRAEFIK_ADMIN_PORT:-8080}"

##
DOMAIN="perpetis.localhost"
URLS=(
# dashboard
"http://traefik.${DOMAIN}:${ADMIN_PORT}/"
#
"http://whoami.${DOMAIN}:${PORT}/"
"http://redisinsight.${DOMAIN}:${PORT}/"
"http://redis-commander.${DOMAIN}:${PORT}/"
"http://pgadmin4.${DOMAIN}:${PORT}/"
"http://minio.${DOMAIN}:${PORT}/"
)

DATA_DIR="perpetis"

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