FROM ubuntu:18.04

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update && \
    apt-get install -y git openssh-client netbase locales && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8

RUN git config --global user.email "el-patron@example.com"
RUN git config --global user.name "el-patron"

ARG EL_PATRON_BINARY
COPY $EL_PATRON_BINARY /usr/local/bin/el-patron
