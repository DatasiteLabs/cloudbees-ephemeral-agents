FROM node:current-alpine3.10
LABEL maintainer "Amit Kirdatt <amit.kirdatt@merrillcorp.com>"

# install cURL, git, and certificates
RUN apk update && apk add \
    ca-certificates \
    curl \
    git \
    python \
    make \
    bash


# Installing the Jfrog CLI
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod 776 /usr/local/bin/jfrog

