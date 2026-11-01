#!/usr/bin/env bash
set -euo pipefail

export PATH="/usr/local/bin:${HOME}/.local/bin:${PATH}"

mkdir -p "${HOME}/.config/chezmoi"
cat >"${HOME}/.config/chezmoi/chezmoi.toml" <<'EOF'
[data]
name = "Docker Validator"
email = "docker-validator@example.com"
EOF

# 検証イメージは Dockerfile で chezmoi バイナリを入れている（snap 実行制約回避）。
chezmoi --version

cd "${HOME}/dotfiles-work"
chezmoi init --source="${PWD}"
chezmoi apply --source="${PWD}"
test -f "${HOME}/.config/mise/config.toml"
test -f "${HOME}/.zshrc"
test -f "${HOME}/.vimrc"
test -f "${HOME}/.gitconfig"
test -f "${HOME}/.gitignore_global"
test "$(git config --global --get user.name)" = "Docker Validator"
test "$(git config --global --get user.email)" = "docker-validator@example.com"
echo mise_config_ok

bash scripts/bootstrap.sh
echo bootstrap_first_ok

# shellcheck disable=SC1090
source "${HOME}/.bashrc" || true
eval "$("${HOME}/.local/bin/mise" activate bash)"

getent passwd "${USER}" | cut -d: -f7 | grep -qx /usr/bin/zsh

git --version
git-lfs --version
git config --global --get user.name
git config --global --get user.email
delta --version
mise --version
chezmoi --version
gh --version
sops --version
age --version
fzf --version
rg --version
fd --version
eza --version
sheldon --version
starship --version
atuin --version
lazygit --version
lefthook version
node --version
uv --version
terraform version
tflint --version
terraform-docs --version
broot --version
gping --version
rga --version
lazydocker --version
herdr --version
hunk --version
docker --version
vim --version | head -n 1
sudo docker version
# 検証コンテナ内の Docker-in-Docker では overlay マウントに失敗することがある。
# 実機では getting-started の hello-world 確認を行う。ここでは失敗しても続行する。
if ! sudo docker run --rm hello-world; then
  echo "warn: hello-world failed inside nested Docker; continuing validation"
fi
chezmoi diff --source="${HOME}/dotfiles-work"
echo tools_ok

bash scripts/bootstrap.sh
echo bootstrap_second_ok

set +e
ssh_out="$(ssh -o StrictHostKeyChecking=accept-new -T git@github.com 2>&1)"
ssh_rc=$?
set -e
printf '%s\n' "${ssh_out}"
if printf '%s' "${ssh_out}" | grep -qi 'successfully authenticated'; then
  echo ssh_ok
else
  echo "ssh authentication failed (rc=${ssh_rc})" >&2
  exit 1
fi

echo ALL_CHECKS_PASSED
