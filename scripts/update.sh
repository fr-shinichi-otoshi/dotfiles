#!/usr/bin/env bash
#
# 日常更新入口。
# 前提: getting-started / bootstrap 済みであること。
# apt を更新し、mise ツールを版バンプし、sheldon を更新する。
# chezmoi / mitamae / bootstrap は扱わない。
#

set -Eeuo pipefail

readonly ROOT_DIR="$(
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
  pwd
)"
readonly MISE_BIN="${HOME}/.local/bin/mise"
readonly MISE_CONFIG="${HOME}/.config/mise/config.toml"

export PATH="${HOME}/.local/bin:${PATH}"

log() {
  printf 'update: %s\n' "$*"
}

error() {
  printf 'update: error: %s\n' "$*" >&2
  exit 1
}

require_prerequisites() {
  [[ -x "${MISE_BIN}" ]] || error "mise が見つからない (${MISE_BIN})。getting-started の手順で bootstrap を先に実行する"
  if [[ ! -f "${MISE_CONFIG}" ]]; then
    error "${MISE_CONFIG} がない。getting-started の手順で chezmoi apply を先に実行する"
  fi
}

upgrade_apt() {
  log "apt を更新する"
  sudo -v
  sudo DEBIAN_FRONTEND=noninteractive apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
}

activate_mise() {
  eval "$("${MISE_BIN}" activate bash)"
}

upgrade_mise() {
  log "mise ツールを版バンプする"
  "${MISE_BIN}" upgrade --bump
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
  [[ "$(id -u)" -ne 0 ]] || error "root では実行しない。一般ユーザーで bash scripts/update.sh を実行する"
  [[ -f "${ROOT_DIR}/.chezmoiroot" ]] || error "${ROOT_DIR} は dotfiles リポジトリではない"

  require_prerequisites
  upgrade_apt
  activate_mise
  upgrade_mise
  refresh_sheldon

  log "完了。新しいターミナルを開くか exec zsh する"
  log "${MISE_CONFIG} が書き換わっている場合がある"
  log "共有するときは: chezmoi add ~/.config/mise/config.toml → 差分確認 → コミット"
}

main "$@"
