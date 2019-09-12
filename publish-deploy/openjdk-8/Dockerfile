FROM openjdk:8-jdk-slim

ARG token

USER root

# install build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    netbase \
    wget \
    vim \
    git \
    jq \
    tar \
    gzip \
    gnupg \
    dirmngr \
    && rm -rf /var/lib/apt/lists/*

# install jFrog CLI
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod +x /usr/local/bin/jfrog

# install CF CLI
# RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - \
#     && echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list \
#     && apt-get update && apt-get install cf-cli
RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx \
    && mv cf /usr/local/bin

# install the plugins for Autoscaler & B/G Deployer
RUN curl -O -fL -X GET https://network.pivotal.io/api/v2/products/pcf-app-autoscaler/releases/280907/product_files/292914/download -H "Authorization: Bearer $token" \
    && cf install-plugin -f download
