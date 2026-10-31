# 検証用イメージ（systemd 付き Ubuntu 24.04）
# 利用手順は docs/docs/docker-validation.md を参照する。
FROM jrei/systemd-ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

ARG CHEZMOI_VERSION=2.73.3

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    openssh-client \
    sudo \
    dbus \
  && rm -rf /var/lib/apt/lists/* \
  && useradd --create-home --shell /bin/bash developer \
  && echo 'developer ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/developer \
  && chmod 440 /etc/sudoers.d/developer \
  && arch="$(dpkg --print-architecture)" \
  && case "${arch}" in \
       amd64) carch=amd64 ;; \
       arm64) carch=arm64 ;; \
       *) echo "unsupported arch: ${arch}" >&2; exit 1 ;; \
     esac \
  && curl -fsSL "https://github.com/twpayne/chezmoi/releases/download/v${CHEZMOI_VERSION}/chezmoi_${CHEZMOI_VERSION}_linux_${carch}.tar.gz" \
    | tar -xz -C /usr/local/bin chezmoi \
  && chmod 755 /usr/local/bin/chezmoi \
  && chezmoi --version

CMD ["/lib/systemd/systemd"]
