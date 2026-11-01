#!/usr/bin/env bash
#
# プロビジョニング入口。
# 前提: snap の chezmoi で home/ を適用済みであること。
# mitamae で apt / Docker Engine / mise / CLI / ログインシェルを導入し、sheldon を更新する。
#

set -Eeuo pipefail

readonly ROOT_DIR="$(
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
  pwd
)"
readonly MITAMAE_VERSION="2.0.6"
readonly MITAMAE_BIN="${HOME}/.local/bin/mitamae"
readonly MISE_BIN="${HOME}/.local/bin/mise"
readonly MISE_CONFIG="${HOME}/.config/mise/config.toml"

export PATH="${HOME}/.local/bin:${PATH}"

log() {
  printf 'bootstrap: %s\n' "$*"
}

error() {
  printf 'bootstrap: error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || error "'$1' が見つからない"
}

mitamae_asset_name() {
  local arch
  arch="$(uname -m)"
  case "${arch}" in
    x86_64 | amd64)
      printf 'mitamae-x86_64-linux'
      ;;
    aarch64 | arm64)
      printf 'mitamae-aarch64-linux'
      ;;
    *)
      error "未対応のアーキテクチャ: ${arch}"
      ;;
  esac
}

ensure_curl() {
  if command -v curl >/dev/null 2>&1; then
    return 0
  fi
  log "curl を apt で導入する"
  sudo -v
  sudo DEBIAN_FRONTEND=noninteractive apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y curl ca-certificates
}

ensure_mitamae() {
  local asset url tmp
  mkdir -p "${HOME}/.local/bin"

  if [[ -x "${MITAMAE_BIN}" ]] && "${MITAMAE_BIN}" version 2>/dev/null | grep -Fq "${MITAMAE_VERSION}"; then
    log "mitamae ${MITAMAE_VERSION} は導入済み"
    return 0
  fi

  ensure_curl
  asset="$(mitamae_asset_name)"
  url="https://github.com/itamae-kitchen/mitamae/releases/download/v${MITAMAE_VERSION}/${asset}"
  tmp="$(mktemp)"
  log "mitamae ${MITAMAE_VERSION} を取得する (${asset})"
  curl -fsSL "${url}" -o "${tmp}"
  chmod +x "${tmp}"
  mv "${tmp}" "${MITAMAE_BIN}"
}

write_node_json() {
  local path="$1"
  cat >"${path}" <<EOF
{
  "user": "${USER}",
  "home": "${HOME}",
  "dotfiles_root": "${ROOT_DIR}"
}
EOF
}

run_mitamae() {
  local node_json
  node_json="$(mktemp)"
  write_node_json "${node_json}"

  log "mitamae でプロビジョニングする"
  sudo -v
  sudo "${MITAMAE_BIN}" local --node-json="${node_json}" "${ROOT_DIR}/mitamae/recipes/default.rb"
  rm -f "${node_json}"
}

require_prerequisites() {
  require_command chezmoi
  if [[ ! -f "${MISE_CONFIG}" ]]; then
    error "${MISE_CONFIG} がない。getting-started の手順で chezmoi apply を先に実行する"
  fi
}

activate_mise() {
  [[ -x "${MISE_BIN}" ]] || error "mise が見つからない (${MISE_BIN})"
  eval "$("${MISE_BIN}" activate bash)"
}

refresh_mise() {
  log "mise ツールを揃える"
  "${MISE_BIN}" install
}

refresh_sheldon() {
  if ! command -v sheldon >/dev/null 2>&1; then
    log "sheldon が無いためプラグイン更新をスキップする"
    return 0
  fi
  log "sheldon プラグインを更新する"
  sheldon lock --update
  rm -f "${XDG_CACHE_HOME:-${HOME}/.cache}/sheldon/sheldon.zsh"{,.zwc}
}

main() {
  [[ "$(id -u)" -ne 0 ]] || error "root では実行しない。一般ユーザーで bash bin/bootstrap.sh を実行する"
  [[ -f "${ROOT_DIR}/.chezmoiroot" ]] || error "${ROOT_DIR} は dotfiles リポジトリではない"

  require_prerequisites
  ensure_mitamae
  run_mitamae
  activate_mise
  refresh_mise
  refresh_sheldon

  log "完了。新しいターミナルを開くか exec zsh し、導入結果を確認する"
}

main "$@"
