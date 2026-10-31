# frozen_string_literal: true

# Docker Engine（公式 apt リポジトリ手順）
# https://docs.docker.com/engine/install/ubuntu/

user = node['user']

raise 'node["user"] is required' if user.nil? || user.empty?

helper = '/tmp/dotfiles-install-docker.sh'

file helper do
  mode '755'
  content <<~'SH'
    #!/bin/bash
    set -euo pipefail

    USER_NAME="$1"

    ensure_docker_group_and_service() {
      groupadd -f docker
      usermod -aG docker "${USER_NAME}"
      systemctl enable --now docker
    }

    if command -v docker >/dev/null 2>&1 && dpkg-query -W -f='${Status}' docker-ce 2>/dev/null | grep -q 'install ok installed'; then
      echo "docker: already installed"
      ensure_docker_group_and_service
      exit 0
    fi

    # 公式が案内する衝突パッケージを除去する（初回導入前）
    CONFLICTING=(
      docker.io
      docker-compose
      docker-compose-v2
      docker-doc
      docker-buildx
      podman-docker
      containerd
      runc
    )
    remove_list=()
    for pkg in "${CONFLICTING[@]}"; do
      if dpkg-query -W -f='${Status}' "${pkg}" 2>/dev/null | grep -q 'install ok installed'; then
        remove_list+=("${pkg}")
      fi
    done
    if ((${#remove_list[@]} > 0)); then
      DEBIAN_FRONTEND=noninteractive apt-get remove -y "${remove_list[@]}"
    fi

    . /etc/os-release
    distro_id="${ID}"
    distro_codename="${UBUNTU_CODENAME:-${VERSION_CODENAME}}"
    arch="$(dpkg --print-architecture)"

    case "${distro_id}" in
      ubuntu) docker_distro=ubuntu ;;
      debian) docker_distro=debian ;;
      *)
        echo "error: unsupported distro for Docker Engine: ${distro_id}" >&2
        exit 1
        ;;
    esac

    case "${arch}" in
      amd64 | arm64) ;;
      *)
        echo "error: unsupported architecture for Docker Engine: ${arch}" >&2
        exit 1
        ;;
    esac

    install -m 0755 -d /etc/apt/keyrings
    if [[ ! -f /etc/apt/keyrings/docker.asc ]]; then
      curl -fsSL "https://download.docker.com/linux/${docker_distro}/gpg" \
        -o /etc/apt/keyrings/docker.asc
      chmod a+r /etc/apt/keyrings/docker.asc
    fi

    printf '%s\n' \
      'Types: deb' \
      "URIs: https://download.docker.com/linux/${docker_distro}" \
      "Suites: ${distro_codename}" \
      'Components: stable' \
      "Architectures: ${arch}" \
      'Signed-By: /etc/apt/keyrings/docker.asc' \
      >/etc/apt/sources.list.d/docker.sources

    DEBIAN_FRONTEND=noninteractive apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      docker-ce \
      docker-ce-cli \
      containerd.io \
      docker-buildx-plugin \
      docker-compose-plugin

    ensure_docker_group_and_service
  SH
end

execute 'install Docker Engine from official apt repository' do
  command "#{helper} #{user}"
end
