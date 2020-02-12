FROM jenkinsci/ssh-slave
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
    unzip \
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
# Need to handhold jenkins user to be able to access the plugin being installed
RUN mkdir /opt/cf; chown jenkins:jenkins /opt/cf
USER jenkins
ENV CF_HOME /opt/cf
# install the plugins for config-server
RUN cf install-plugin -r CF-Community "spring-cloud-services" -f
EXPOSE 22
ENTRYPOINT ["setup-sshd"]