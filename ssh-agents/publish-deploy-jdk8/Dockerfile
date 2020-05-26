FROM openjdk:8-jdk

ARG token
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}
ENV JENKINS_SLAVE_SSH_PUBKEY ${JENKINS_SLAVE_SSH_PUBKEY}

RUN groupadd -g ${gid} ${group} && \
    useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

# setup SSH server
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    openssh-server \
    apt-transport-https \
    ca-certificates \
    curl \
    netbase \
    wget \
    vim \
    git \
    sudo \
    jq \
    tar \
    gzip \
    unzip \
    gnupg \
    dirmngr \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i /etc/ssh/sshd_config \
        -e 's/#PermitRootLogin.*/PermitRootLogin no/' \
        -e 's/#RSAAuthentication.*/RSAAuthentication yes/'  \
        -e 's/#PasswordAuthentication.*/PasswordAuthentication no/' \
        -e 's/#SyslogFacility.*/SyslogFacility AUTH/' \
        -e 's/#LogLevel.*/LogLevel INFO/' && \
    mkdir /var/run/ssh

VOLUME "/tmp" "/run" "/var/run"
WORKDIR "${JENKINS_AGENT_HOME}"

COPY setup-sshd /usr/local/bin/setup-sshd
RUN chmod 755 /usr/local/bin/setup-sshd

# install jFrog CLI
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod +x /usr/local/bin/jfrog

# install CF CLI
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - && \
    echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
    apt-get update && sudo apt-get install cf-cli && apt-get install cf7-cli && \
    curl -O -fL -X GET https://network.pivotal.io/api/v2/products/pcf-app-autoscaler/releases/280907/product_files/292914/download -H "Authorization: Bearer $token" && \
    su - jenkins -c 'cf install-plugin -f download && cf install-plugin -f app-autoscaler-plugin'

VOLUME "${JENKINS_AGENT_HOME}"

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/setup-sshd"]