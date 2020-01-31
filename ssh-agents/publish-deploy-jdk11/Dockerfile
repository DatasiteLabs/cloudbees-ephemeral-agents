FROM jenkinsci/ssh-slave

ARG token
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
RUN chmod +x /usr/local/bin/setup-sshd

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
# NOTE: If the build errors out, you may need to update the URL to a more recent version of the Autoscaler plugin!
RUN curl -O -fL -X GET https://network.pivotal.io/api/v2/products/p-spring-cloud-services/releases/558725/product_files/590427/download -H "Authorization: Bearer $token" \
    && cf install-plugin -r CF-Community "spring-cloud-services" -f

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/setup-sshd"]
