#!/usr/bin/env bash
# 検証用イメージを build し、コンテナ起動 → ソース/SSH 同期 → 検証実行まで行う。
set -euo pipefail

ROOT_DIR="$(
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
  pwd
)"
IMAGE_NAME="${DOTFILES_VALIDATE_IMAGE:-dotfiles-validate:local}"
CONTAINER_NAME="${DOTFILES_VALIDATE_CONTAINER:-dotfiles-check}"
SSH_DIR="${DOTFILES_VALIDATE_SSH_DIR:-${HOME}/.ssh}"

if [[ ! -d "${SSH_DIR}" ]]; then
  echo "error: SSH directory not found: ${SSH_DIR}" >&2
  exit 1
fi

echo "building ${IMAGE_NAME}"
docker build -t "${IMAGE_NAME}" "${ROOT_DIR}"

docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true

echo "starting ${CONTAINER_NAME}"
docker run -d --name "${CONTAINER_NAME}" \
  --privileged \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -v "${ROOT_DIR}:/mnt/dotfiles:ro" \
  -v "${SSH_DIR}:/mnt/host-ssh:ro" \
  "${IMAGE_NAME}"

for _ in $(seq 1 30); do
  if docker exec "${CONTAINER_NAME}" systemctl is-system-running >/dev/null 2>&1; then
    break
  fi
  sleep 1
done
docker exec "${CONTAINER_NAME}" systemctl is-system-running

echo "syncing repository and SSH into developer home"
docker exec -u root "${CONTAINER_NAME}" bash /mnt/dotfiles/scripts/docker-validate-setup.sh

echo "running validation"
docker exec -u developer -w /home/developer \
  -e HOME=/home/developer -e USER=developer \
  -e PATH=/usr/local/bin:/home/developer/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  "${CONTAINER_NAME}" bash /home/developer/dotfiles-work/scripts/docker-validate-run.sh
