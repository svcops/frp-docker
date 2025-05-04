#!/bin/bash
# shellcheck disable=SC2164  disable=SC1090
SHELL_FOLDER=$(cd "$(dirname "$0")" && pwd)
cd "$SHELL_FOLDER"

source <(curl -sSL "https://dev.kubectl.net/func/ostype.sh")
if is_windows; then
  export MSYS_NO_PATHCONV=1
fi

FRP_VERSION="0.62.1"
bash <(curl -sSL https://dev.kubectl.net/docker/build.sh) \
  -i "registry.cn-shanghai.aliyuncs.com/iproute/frp" \
  -a "FRP_VERSION=$FRP_VERSION" \
  -v "$FRP_VERSION" \
  -r "false" \
  -p "true"
