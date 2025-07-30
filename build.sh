#!/bin/bash
# shellcheck disable=SC2164  disable=SC1090
SHELL_FOLDER=$(cd "$(dirname "$0")" && pwd)
cd "$SHELL_FOLDER"
source <(curl -sSL "https://gitlab.com/iprt/shell-basic/-/raw/main/build-project/basic.sh")

source <(curl -sSL "$ROOT_URI/func/log.sh")
source <(curl -sSL "$ROOT_URI/func/ostype.sh")

if is_windows; then
  export MSYS_NO_PATHCONV=1
fi

versions=()
mapfile -t files < <(ls build_files)
# 获取所有 frp 版本号
for file in "${files[@]}"; do
  if [[ $file =~ frp_([0-9]+\.[0-9]+\.[0-9]+)_linux_amd64\.tar\.gz ]]; then
    versions+=("${BASH_REMATCH[1]}")
  fi
done

LAST_VERSION="${versions[-1]}"

for version in "${versions[@]}"; do
  log_info "build" "version is $version"
  FRP_VERSION="$version"
  bash <(curl -sSL "$ROOT_URI/docker/build.sh") \
    -i "registry.cn-shanghai.aliyuncs.com/iproute/frp" \
    -a "FRP_VERSION=$FRP_VERSION" \
    -v "$FRP_VERSION" \
    -r "false" \
    -p "true"

  if [[ "$FRP_VERSION" == "$LAST_VERSION" ]]; then
    log_info "build" "last version is $FRP_VERSION, push to registry"
    bash <(curl -sSL "$ROOT_URI/docker/build.sh") \
      -i "registry.cn-shanghai.aliyuncs.com/iproute/frp" \
      -a "FRP_VERSION=$FRP_VERSION" \
      -v "latest" \
      -r "false" \
      -p "true"
  fi
done
