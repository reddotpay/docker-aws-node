FROM amazonlinux:latest

RUN yum update -y \
    && curl -sL https://rpm.nodesource.com/setup_10.x | bash - \
    && yum install -y gcc-c++ \
    make \
    jq \
    awscli \
    nodejs \ 
    zip
