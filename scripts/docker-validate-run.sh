#!/usr/bin/env bash
set -euo pipefail

export PATH="/usr/local/bin:/snap/bin:${HOME}/.local/bin:${PATH}"

mkdir -p "${HOME}/.config/chezmoi"
cat >"${HOME}/.config/chezmoi/chezmoi.toml" <<'EOF'
[data]
name = "Docker Validator"
email = "docker-validator@example.com"
EOF

# snap で導入する。Docker では一般ユーザーが snap 実行できない場合があるため、
# 導入後に snap 内バイナリを /usr/local/bin へコピーする。
if ! command -v chezmoi >/dev/null 2>&1; then
  sudo snap install chezmoi --classic
fi
if ! command -v chezmoi >/dev/null 2>&1 || ! chezmoi --version >/dev/null 2>&1; then
  sudo cp -a /snap/chezmoi/current/chezmoi /usr/local/bin/chezmoi
  sudo chmod 755 /usr/local/bin/chezmoi
fi

chezmoi --version

cd "${HOME}/dotfiles-work"
chezmoi init --source="${PWD}"
chezmoi apply --source="${PWD}"
test -f "${HOME}/.config/mise/config.toml"
test -f "${HOME}/.zshrc"
echo mise_config_ok

bash bootstrap.sh
echo bootstrap_first_ok

# shellcheck disable=SC1090
source "${HOME}/.bashrc" || true
eval "$("${HOME}/.local/bin/mise" activate bash)"

getent passwd "${USER}" | cut -d: -f7 | grep -qx /usr/bin/zsh

git --version
git-lfs --version
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
sudo docker version
sudo docker run --rm hello-world
chezmoi diff --source="${HOME}/dotfiles-work"
echo tools_ok

bash bootstrap.sh
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
