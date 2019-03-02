FROM nginx:latest
MAINTAINER Juan Manuel Carrillo Moreno <inetshell@gmail.com>

ENV CONFIG_SOURCE LOCAL

RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    git \
    curl \
    gnupg \
    python2.7

COPY entrypoint.sh /

ENTRYPOINT ["bash","/entrypoint.sh"]