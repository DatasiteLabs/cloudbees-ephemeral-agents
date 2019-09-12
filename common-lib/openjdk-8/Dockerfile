FROM openjdk:8-jdk-slim
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
    mongodb \
    && rm -rf /var/lib/apt/lists/*
RUN groupadd --system --gid 1000 gradle && \
    useradd --system --create-home --uid 1000 --gid gradle --groups audio,video --shell /bin/bash gradle && \
    mkdir --parents /home/gradle/reports && \
    chown --recursive gradle:gradle /home/gradle

# Create data directory
RUN mkdir -p /data/db