FROM python:3.6.9-slim-stretch

ARG token

USER root

RUN mkdir -p /usr/share/man/man1

# install build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    netbase \
    wget \
    vim \
    git \
    gnupg \
    dirmngr \
    openjdk-8-jre \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# install CF CLI
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - \
    && echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list \
    && apt-get update && apt-get install cf-cli

# install the plugins for Autoscaler & B/G Deployer
RUN curl -O -fL -X GET https://network.pivotal.io/api/v2/products/pcf-app-autoscaler/releases/280907/product_files/292914/download -H "Authorization: Bearer $token" \
    && cf install-plugin -f download
