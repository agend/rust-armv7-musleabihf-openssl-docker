FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    cmake \
    build-essential \
    libc6-dev \
    make \
    pkg-config \
    git \
    wget \
    libssl-dev

COPY xargo.sh /
RUN bash /xargo.sh

COPY build_musl.sh /

RUN bash build_musl.sh
ENV PATH="/usr/local/musl/bin:${PATH}"

COPY openssl.sh /
RUN bash /openssl.sh linux-armv4 arm-linux-musleabihf- -static

ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_MUSLEABIHF_LINKER=arm-linux-musleabihf-gcc \
    CC_armv7_unknown_linux_musleabihf=arm-linux-musleabihf-gcc \
    RUST_TEST_THREADS=1 \
    ARMV7_UNKNOWN_LINUX_MUSLEABIHF_OPENSSL_DIR=/openssl \
    ARMV7_UNKNOWN_LINUX_MUSLEABIHF_OPENSSL_INCLUDE_DIR=/openssl/include \
    ARMV7_UNKNOWN_LINUX_MUSLEABIHF_OPENSSL_LIB_DIR=/openssl/lib
