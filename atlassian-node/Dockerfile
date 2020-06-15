FROM atlassianlabs/docker-node-jdk-chrome-firefox:2020-03-16

# Installing the Jfrog CLI
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod 776 /usr/local/bin/jfrog