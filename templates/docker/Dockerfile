FROM dockerhub.limitlessgames.cloud/infra/jenkins-slave-jnlp:1.0.0
USER 0
ARG VERSION=3.9


COPY jenkins-slave.sh /usr/bin/jenkins-slave
COPY agent.jar /usr/share/jenkins/agent.jar

ADD https://releases.hashicorp.com/vault/1.2.3/vault_1.2.3_linux_amd64.zip /tmp
RUN unzip -f /tmp/vault_1.2.3_linux_amd64.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/vault && \
    rm -rf /tmp/vault_1.2.3_linux_amd64.zip


ENTRYPOINT ["jenkins-slave"]


