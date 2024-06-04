#!/bin/bash
# shellcheck disable=SC2164
SHELL_FOLDER=$(cd "$(dirname "$0")" && pwd)
cd "$SHELL_FOLDER"

image_name="registry.cn-shanghai.aliyuncs.com/iproute/frp"

bash <(curl https://code.kubectl.net/devops/build-project/raw/branch/main/docker/build.sh) \
  -i "$image_name" \
  -v "0.58.1" \
  -r "false" \
  -p "true"
