FROM python:3.6.9-slim-stretch

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

# install stuff so preview-generator installs happily
RUN apt-get update && apt-get install -y zlib1g-dev libjpeg-dev python3-pythonmagick inkscape xvfb poppler-utils libfile-mimeinfo-perl qpdf libimage-exiftool-perl ufraw-batch ffmpeg

# Install cf v7 cli 
RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&version=7.0.0-beta.27&source=github" | tar -zx \
    && mv cf7 /usr/local/bin

# Install Jfrog
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod 776 /usr/local/bin/jfrog

ARG token

# install the plugins for Autoscaler & B/G Deployer
RUN curl -O -fL -X GET https://network.pivotal.io/api/v2/products/pcf-app-autoscaler/releases/280907/product_files/292914/download -H "Authorization: Bearer $token" \
    && cf install-plugin -f download
