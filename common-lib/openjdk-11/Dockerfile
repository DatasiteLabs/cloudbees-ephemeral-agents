FROM openjdk:11-jdk-slim
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
    zip \
    unzip \
    gzip \
    gnupg \
    dirmngr

# hacks to install Mongodb 4
RUN apt update && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
    echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | tee /etc/apt/sources.list.d/mongodb-org.list && \
    echo "deb http://deb.debian.org/debian/ stretch main" | tee /etc/apt/sources.list.d/debian-stretch.list && \
    apt-get update && apt-get install -y \
    libcurl3 \
    mongodb-org=4.0.2 \
    mongodb-org-server=4.0.2 \
    && rm -rf /var/lib/apt/lists/*

# set up Gradle
RUN groupadd --system --gid 1000 gradle && \
    useradd --system --create-home --uid 1000 --gid gradle --groups audio,video --shell /bin/bash gradle && \
    mkdir --parents /home/gradle/reports && \
    chown --recursive gradle:gradle /home/gradle

# Create data directory
RUN mkdir -p /data/db