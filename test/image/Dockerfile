FROM docker:dind

LABEL name="ops-docker-test"
LABEL maintainer="Andrey Kravtsov <raidendev@gmail.com>"

RUN apk add --no-cache bash openssh openssl rsync && \
    ssh-keygen -A

WORKDIR /root/

COPY keys/id_rsa.pub .ssh/id_rsa.pub

RUN cat .ssh/id_rsa.pub >> .ssh/authorized_keys && \
    chmod 700 .ssh && chmod 600 .ssh/authorized_keys

RUN sed -i 's/exec "$@"/\/usr\/sbin\/sshd\nexec "$@"/' /usr/local/bin/dockerd-entrypoint.sh

EXPOSE 22
