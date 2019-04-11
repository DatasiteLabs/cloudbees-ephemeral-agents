FROM openjdk:10-jdk-slim

USER root

# install build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    netbase \
    wget \
    vim \
    git \
    gnupg \
    dirmngr \
    && rm -rf /var/lib/apt/lists/*

# install jFrog CLI
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod +x /usr/local/bin/jfrog

# install CF CLI
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - \
    && echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list \
    && apt-get update && apt-get install cf-cli

# install the pivnet CLI to pull down content from Pivotal Network (the plugins we need)
# RUN wget -q -O - https://github.com/pivotal-cf/pivnet-cli/releases/download/v0.0.57/pivnet-linux-amd64-0.0.57 \
#     && PATH = /

# install the plugins for Autoscaler & B/G Deployer