# nodejs
# version: v14 -> v20

ARG VER=14

FROM debian:latest

RUN apt-get update && apt-get install -y \
  wget \
  git \
  xz-utils

RUN mkdir -p /usr/local/nodejs

ARG VER

RUN if [ "$VER" = "14" ]; then \
      wget -O node.tar.xz https://nodejs.org/dist/v14.21.3/node-v14.21.3-linux-arm64.tar.xz; \
    elif [ "$VER" = "16" ]; then \
      wget -O node.tar.xz https://nodejs.org/dist/v16.20.2/node-v16.20.2-linux-arm64.tar.xz; \
    elif [ "$VER" = "18" ]; then \
      wget -O node.tar.xz https://nodejs.org/dist/v18.18.2/node-v18.18.2-linux-arm64.tar.xz; \
    elif [ "$VER" = "20" ]; then \
      wget -O node.tar.xz https://nodejs.org/dist/v20.12.0/node-v20.12.0-linux-arm64.tar.xz; \
    else \
      echo "Unsupported nodejs version: $VER"; exit 1; \
    fi

RUN tar -xJf node.tar.xz -C /usr/local/nodejs --strip-components=1 \
&& rm node.tar.xz

ENV PATH=/usr/local/nodejs/bin:$PATH

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app
