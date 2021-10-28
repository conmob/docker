ARG DOCKER_VERSION="19.03"
FROM docker:${DOCKER_VERSION}
RUN apk add --no-cache git curl py-pip python3-dev libffi-dev openssl-dev gcc libc-dev rust cargo make
ARG DOCKER_COMPOSE_VERSION="1.29.2"
ENV DOCKER_COMPOSE_VERSION ${DOCKER_COMPOSE_VERSION}
RUN pip install docker-compose==${DOCKER_COMPOSE_VERSION}
