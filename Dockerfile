# https://lists.openshift.redhat.com/openshift-archives/users/2017-July/msg00026.html

FROM alpine:3.5

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apk add --no-cache openssh && \
    ssh-keygen -A && \
    echo -e "ClientAliveInterval 1\nGatewayPorts yes\nPermitEmptyPasswords yes\nPort 8022\nClientAliveCountMax 10\nPermitRootLogin yes\n" >> /etc/ssh/sshd_config

# Set the permissions necessary to run as a non-root user
RUN chmod -R g+wr /etc/ssh && \
    chmod g+w /etc/passwd && \
    chmod -R g+w /usr/src/app && \
    chmod -R g+w /run/

COPY run.sh /usr/src/app
RUN chmod +x /usr/src/app/run.sh

# Running as root will now fail due with a permissions error, so default to some
# other UID
USER 1000

CMD /usr/src/app/run.sh
