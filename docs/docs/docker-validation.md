# Dockerでの検証

## 検証の対象と前提

- **目的**：ホストのホーム設定を変更せず、初回構築・再適用・GitHub SSH認証を確認する。
- **対象**：ローカルのdotfilesリポジトリ。未コミット・未プッシュの変更も含む。
- **流れ**：systemd有効コンテナで、snapのchezmoi適用 → `bootstrap.sh` → `ssh -T git@github.com`。
- **ソース**：リポジトリはバインドマウントする。GitHubからのクローンは行わない。
- **SSH**：ホストの`~/.ssh`をread-onlyでマウントし、認証だけ確認する。
- **前提**：Dockerが起動済みであり、`docker version`でサーバーへ接続できること。
- **イメージ**：素の`ubuntu:24.04`には`/sbin/init`が無いため、検証では`jrei/systemd-ubuntu:24.04`を使う。
- **Dockerと実環境の差**：コンテナ起動オプションと、後述のsnapバイナリコピーは検証専用である。

## 検証用コンテナを起動する

ホスト側でdotfilesリポジトリのルートに移動して実行する。以下はbash（WSL）向けの例である。

```bash
REPO_DIR="$(pwd)"
SSH_DIR="${HOME}/.ssh"

docker rm -f dotfiles-check >/dev/null 2>&1 || true

docker run -d --name dotfiles-check \
  --privileged \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -v "${REPO_DIR}:/mnt/dotfiles:ro" \
  -v "${SSH_DIR}:/mnt/host-ssh:ro" \
  jrei/systemd-ubuntu:24.04

sleep 5
docker exec dotfiles-check systemctl is-system-running
```

- **systemd**：イメージのPID 1がsystemdである。`--privileged`とcgroupマウントでsnapdを動かす。
- **リポジトリ**：`/mnt/dotfiles`へread-onlyマウント。作業はホーム配下のコピーで行う。
- **SSH**：`/mnt/host-ssh`へread-onlyマウント。ユーザー作成後に`~/.ssh`へコピーする。

## 一般ユーザーの検証環境を作る

コンテナ内のrootとして、セットアップスクリプトを実行する。

```bash
docker exec -u root dotfiles-check bash /mnt/dotfiles/scripts/docker-validate-setup.sh
```

手動で同等の処理を行う場合の要点は次のとおりである。

```bash
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  ca-certificates curl git openssh-client sudo snapd dbus

id developer >/dev/null 2>&1 || useradd --create-home --shell /bin/bash developer
echo 'developer ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/developer
chmod 440 /etc/sudoers.d/developer

rm -rf /home/developer/dotfiles-work
mkdir -p /home/developer/dotfiles-work /home/developer/.ssh
cp -a /mnt/dotfiles/. /home/developer/dotfiles-work/
cp -a /mnt/host-ssh/. /home/developer/.ssh/
chmod 700 /home/developer/.ssh
chmod 600 /home/developer/.ssh/id_* 2>/dev/null || true
chmod 644 /home/developer/.ssh/*.pub /home/developer/.ssh/known_hosts /home/developer/.ssh/config 2>/dev/null || true
chown -R developer:developer /home/developer

systemctl enable --now snapd.socket snapd.service
ln -sfn /var/lib/snapd/snap /snap
```

## chezmoi適用とbootstrap

developerユーザーで検証スクリプトを実行する。

```bash
docker exec -u developer -w /home/developer \
  -e HOME=/home/developer -e USER=developer \
  -e PATH=/usr/local/bin:/snap/bin:/home/developer/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  dotfiles-check bash /home/developer/dotfiles-work/scripts/docker-validate-run.sh
```

スクリプトが行う内容は次のとおりである。

1. 検証用の`~/.config/chezmoi/chezmoi.toml`を作成する。
2. `sudo snap install chezmoi --classic`でchezmoiを導入する。
3. Dockerでは一般ユーザーがsnap実行できない場合があるため、`/snap/chezmoi/current/chezmoi`を`/usr/local/bin/chezmoi`へコピーする。
4. `chezmoi init` / `chezmoi apply`で`~/.config/mise/config.toml`を配置する。
5. `bash bootstrap.sh`を初回実行する。
6. 各ツールのバージョンと`chezmoi diff`を確認する。
7. `bash bootstrap.sh`を再実行する。
8. `ssh -T git@github.com`で認証する（`successfully authenticated`があれば合格。終了コードは1になりうる）。

成功時は標準出力に`ALL_CHECKS_PASSED`が出力される。

## 合格条件

- [x] snapでchezmoiを導入し、`chezmoi apply`で`~/.config/mise/config.toml`が配置される。
- [x] 初回の`bootstrap.sh`が一般ユーザーで完了する。
- [x] 新しいシェルから`git` / `git-lfs` / `mise` / `chezmoi` / `gh` / `sops` / `age`を起動できる。
- [x] `chezmoi diff`に意図しない差分が残らない。
- [x] `bootstrap.sh`の再実行が致命的に失敗しない。
- [x] マウントしたSSH鍵で`ssh -T git@github.com`が成功する。
- [ ] 新しいコンテナでも同じ手順で初回構築を再現できる（必要なら再実行して確認する）。

## 終了・再検証

```bash
docker rm -f dotfiles-check
```

再検証する場合は、「検証用コンテナを起動する」からやり直す。

## 実環境で別途確認する項目

- **WSL2上のUbuntu**：Windowsとの連携、利用者向けの対話的sudo、snapをそのまま使う場合の動作。
- **GUIやデスクトップ連携**：このDocker検証の対象外。
- **各自のアカウント**：AI開発ツールの認証と実際の利用。

[セットアップ手順へ](getting-started.md)
