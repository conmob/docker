ARG DOCKER_VERSION="19.03"
ARG DOCKER_COMPOSE_SYSTEM="Linux"
ARG DOCKER_COMPOSE_MACHINE="x86_64"
ARG DOCKER_COMPOSE_VERSION="1.29.2"
FROM docker:${DOCKER_VERSION}
RUN apk add --no-cache git curl py-pip python3-dev libffi-dev openssl-dev gcc libc-dev rust cargo make
RUN curl --location --output /usr/local/bin/docker-compose \
"https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-${DOCKER_COMPOSE_SYSTEM}-${DOCKER_COMPOSE_MACHINE}"
RUN chmod +x /usr/local/bin/docker-compose
