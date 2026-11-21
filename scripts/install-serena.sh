#!/usr/bin/env bash
#
# Serena MCP を uv tool で導入・更新する。
# 前提: mise 経由の uv が PATH にあること（bootstrap / update から呼ぶ）。
# 公式: https://oraios.github.io/serena/02-usage/010_installation.html
# 旧 uvx --from git+... や MCP マーケット経由は非推奨のため使わない。
#

set -Eeuo pipefail

# mise / update.sh の対象外。上げるときはここを更新する。
readonly SERENA_AGENT_VERSION="2.1.0"

export PATH="${HOME}/.local/share/mise/shims:${HOME}/.local/bin:${PATH}"

if ! command -v uv >/dev/null 2>&1; then
  echo "error: uv が見つかりません。先に mise で uv を導入してください。" >&2
  exit 1
fi

mkdir -p "${HOME}/.local/bin"

uv tool install -p 3.13 --force "serena-agent==${SERENA_AGENT_VERSION}"

if [[ ! -x "${HOME}/.local/bin/serena" ]]; then
  echo "error: ${HOME}/.local/bin/serena がありません（uv tool install 後）" >&2
  exit 1
fi

# 初回のみグローバル設定を作る（既存設定は上書きしない）
if [[ ! -f "${HOME}/.serena/serena_config.yml" ]]; then
  serena init -b LSP
fi

echo "serena: $(serena --version 2>/dev/null || true) (serena-agent==${SERENA_AGENT_VERSION})"
