FROM registry.cn-shanghai.aliyuncs.com/iproute/ubuntu:22.04

ARG FRP_VERSION=0.61.1

LABEL org.opencontainers.image.authors="tech@intellij.io"

LABEL email="tech@intellij.io" \
      author="zhenjie zhu"

# random_file
RUN dd if=/dev/urandom of=/random_file bs=1K count=1

RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list && \
  sed -i 's@//security.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list && \
  sed -i 's@//ports.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list && \
  apt-get update && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get install -y iputils-ping ca-certificates vim curl && \
  update-ca-certificates && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

ADD build_files/frp_${FRP_VERSION}_linux_amd64.tar.gz /opt/

RUN mv /opt/frp_${FRP_VERSION}_linux_amd64 /opt/frp

EXPOSE 7000

CMD while true; do echo $(date +"%Y-%m-%d %H:%M:%S"); sleep 5; done
