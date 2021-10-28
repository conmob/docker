#!/bin/bash -e

set -e

[[ "${CONTAINER_VERSION}" ]] || (echo "ERROR: CONTAINER_VERSION variable not set." && exit 1)
[[ "${CONTAINER_REGISTRY_PATH}" ]] || (echo "ERROR: CONTAINER_REGISTRY_PATH variable not set." && exit 1)

[[ "${CONTAINER_REGISTRY_USERNAME}" ]] &&
[[ "${CONTAINER_REGISTRY_PASSWORD}" ]] &&
echo "${CONTAINER_REGISTRY_PASSWORD}" | \
docker login "${CONTAINER_REGISTRY_PATH}" \
--username "${CONTAINER_REGISTRY_USERNAME}" \
--password-stdin

docker build . \
--file Dockerfile \
--tag "${CONTAINER_REGISTRY_PATH}:${CONTAINER_VERSION}"

[[ "${CONTAINER_REGISTRY_PUSH}" -eq 1 ]] &&
docker push "${CONTAINER_REGISTRY_PATH}:${CONTAINER_VERSION}"
