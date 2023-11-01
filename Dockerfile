FROM ubuntu:22.04

LABEL maintainer="chris.bensch@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
#ENV SUDO_USER root

RUN apt update && apt -y upgrade \ 
  && apt -y install wget bash gnupg2 sudo \ 
  && wget https://github.com/ekristen/cast/releases/download/v0.14.0/cast_v0.14.0_linux_amd64.deb \
  && dpkg -i cast_v0.14.0_linux_amd64.deb \
  #&& cast install teamdfir/sift-saltstack \
  && adduser --quiet --disabled-password --shell /bin/bash --home /home/sift --gecos "SIFT Analyst" sift \ 
  && echo "sift:password" | chpasswd && \
  apt -y autoremove && \
  apt -y autoclean && \
  rm -rf /var/lib/apt/lists/*

RUN cast install --mode=server --user=sift teamdfir/sift-saltstack

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/bin/bash"]
