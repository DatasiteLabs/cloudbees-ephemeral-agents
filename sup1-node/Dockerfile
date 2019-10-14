FROM node:10.16.3-jessie

# Installing the Jfrog CLI
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod 776 /usr/local/bin/jfrog