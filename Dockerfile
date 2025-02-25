FROM registry.cn-shanghai.aliyuncs.com/iproute/ubuntu:22.04

MAINTAINER "devops@kubectl.net"

LABEL email="devops@kubectl.net" \
      author="zhenjie zhu"

# random_file
RUN dd if=/dev/urandom of=/random_file bs=1K count=1

RUN apt-get update \
     && apt-get install -y iputils-ping \
     && apt-get install -y ca-certificates vim curl && update-ca-certificates

ADD build_files/frp_0.61.1_linux_amd64.tar.gz /opt/

RUN mv /opt/frp_0.61.1_linux_amd64 /opt/frp

EXPOSE 7000

CMD while true; do echo $(date +"%Y-%m-%d %H:%M:%S"); sleep 5; done
