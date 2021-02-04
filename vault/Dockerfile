# base image
FROM registry.access.redhat.com/ubi8

# set vault version
ENV VAULT_VERSION 1.6.0

# create a new directory
RUN cd /usr/bin

# download dependencies
RUN yum install wget unzip  -y

# download and set up vault
RUN wget --quiet --output-document=/tmp/vault.zip https://releases.hashicorp.com/vault/1.6.0/vault_1.6.0_linux_amd64.zip && \
    unzip /tmp/vault.zip -d /usr/bin/ && \
    rm -f /tmp/vault.zip && \
    chmod +x /usr/bin/vault

# update PATH
ENV PATH="PATH=$PATH:$PWD/usr/bin/vault"

ENV VAULT_ADDR='http://127.0.0.1:8200'
ENV VAULT_API_ADDR='http://127.0.0.18200'
ENV VAULT_SKIP_VERIFY=true
ENV api_addr='http://127.0.0.1:8200'

# add the config file
COPY ./vault-config.json /etc/vault/vault-config.json

# expose port 8200
EXPOSE 8200

#Copy Script
COPY ./vault-secert.sh /usr/bin/vault-secert.sh
RUN chmod +x /usr/bin/vault-secert.sh

ENTRYPOINT ["vault-secert.sh"]
