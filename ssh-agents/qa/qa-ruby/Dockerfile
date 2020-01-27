FROM openjdk:11-jdk

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}
ENV JENKINS_SLAVE_SSH_PUBKEY ${JENKINS_SLAVE_SSH_PUBKEY}

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

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
    jq \
    tar \
    gzip \
    unzip \
    gnupg \
    dirmngr \
    build-essential \
    zlib1g-dev \
    ruby-full \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i /etc/ssh/sshd_config \
        -e 's/#PermitRootLogin.*/PermitRootLogin no/' \
        -e 's/#RSAAuthentication.*/RSAAuthentication yes/'  \
        -e 's/#PasswordAuthentication.*/PasswordAuthentication no/' \
        -e 's/#SyslogFacility.*/SyslogFacility AUTH/' \
        -e 's/#LogLevel.*/LogLevel INFO/' && \
    mkdir /var/run/sshd

VOLUME "${JENKINS_AGENT_HOME}" "/tmp" "/run" "/var/run"
WORKDIR "${JENKINS_AGENT_HOME}"

COPY setup-sshd /usr/local/bin/setup-sshd

RUN chmod 775 /usr/local/bin/setup-sshd
RUN export PATH=/usr/local/bin/setup-sshd:$PATH

# Install ruby bundler
RUN gem update --system
RUN gem install bundler
RUN mkdir "${JENKINS_AGENT_HOME}"/.ruby
RUN echo "export GEM_HOME=/home/jenkins/.ruby" >> "${JENKINS_AGENT_HOME}"/.bashrc
RUN echo "export PATH=$PATH:/home/jenkins/.ruby/bin" >> "${JENKINS_AGENT_HOME}"/.bashrc
RUN chmod -R 775 /var/lib/gems/2.3.0/
RUN chown -R jenkins:jenkins /var/lib/gems/2.3.0/
RUN chown -R jenkins:jenkins /usr/local/bin/

# install jFrog CLI
RUN curl -fL https://getcli.jfrog.io | sh \
    && mv ./jfrog /usr/local/bin/jfrog \
    && chmod +x /usr/local/bin/jfrog

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/setup-sshd"]
