FROM amazonlinux:latest

RUN yum update -y \
    && curl -sL https://rpm.nodesource.com/setup_8.x | bash - \
    && yum install -y gcc-c++ \
    make \
    jq \
    awscli \
    nodejs-8.10.0 \ 
    gzip
