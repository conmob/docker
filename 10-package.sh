#!/bin/bash -e

set -e

[[ "${DOCKER_VERSION}" ]] || (echo "ERROR: DOCKER_VERSION variable not set." && exit 1)
[[ "${DOCKER_COMPOSE_VERSION}" ]] || (echo "ERROR: DOCKER_COMPOSE_VERSION variable not set." && exit 1)
[[ "${CONTAINER_REGISTRY_PATH}" ]] || (echo "ERROR: CONTAINER_REGISTRY_PATH variable not set." && exit 1)

[[ "${CONTAINER_REGISTRY_USERNAME}" ]] &&
[[ "${CONTAINER_REGISTRY_PASSWORD}" ]] &&
echo "${CONTAINER_REGISTRY_PASSWORD}" | \
docker login "${CONTAINER_REGISTRY_PATH}" \
--username "${CONTAINER_REGISTRY_USERNAME}" \
--password-stdin

export CONTAINER_TAG="${DOCKER_VERSION}-docker-compose-${DOCKER_COMPOSE_VERSION}"
docker build . \
--build-arg DOCKER_VERSION \
--build-arg DOCKER_COMPOSE_VERSION \
--file Dockerfile \
--tag "${CONTAINER_REGISTRY_PATH}:${CONTAINER_TAG}"

[[ "${CONTAINER_REGISTRY_PUSH}" -eq 1 ]] &&
docker push "${CONTAINER_REGISTRY_PATH}:${CONTAINER_TAG}"
