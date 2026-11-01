# Dockerでの検証

整備者向けの検証の正です。変更後は次を実行します。

```bash
bash docker/docker-validate.sh
```

成功時は標準出力に`ALL_CHECKS_PASSED`が出力されます。

Windows（PowerShell）からの例は次のとおりです。

```powershell
wsl -e bash -lc 'cd /mnt/c/Users/<you>/develop/dotfiles && bash docker/docker-validate.sh'
```

## 合格条件

- [ ] `ALL_CHECKS_PASSED`で終了します
- [ ] ログインシェルが`/usr/bin/zsh`になります
- [ ] 主要CLIと`docker`が起動できます
- [ ] `chezmoi diff`に意図しない差分が残りません
- [ ] `scripts/bootstrap.sh`の再実行が致命的に失敗しません
- [ ] `scripts/update.sh`が致命的に失敗しません
- [ ] マウントしたSSH鍵で`ssh -T git@github.com`が成功します

`hello-world`はDinD制限で失敗することがあります。警告のみで続行します。

## コンテナに入る

```bash
docker exec -it -u developer -w /home/developer \
  -e HOME=/home/developer -e USER=developer \
  -e PATH=/usr/local/bin:/home/developer/.local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  dotfiles-check zsh
```

終了時は`docker rm -f dotfiles-check`です。再検証はスクリプトを再実行します（既存コンテナは削除されます）。

## 前提と対象外

- **前提**：Dockerが起動済みで、`docker version`でサーバーへ接続できること。対象はローカルのdotfiles（未コミット変更を含む）。リポジトリをマウントし、ホストの`~/.ssh`をread-onlyで使います。
- **イメージ**：リポジトリ直下の`Dockerfile`（`jrei/systemd-ubuntu:24.04`）。利用者向けはsnapのchezmoi、検証イメージはバイナリ同梱です。
- **対象外**：snapのchezmoi、対話的sudo・WSL2連携、GUI、実アカウント認証、`hello-world`の確実な成功。実機検証は行いません。利用者手順は[セットアップ](getting-started.md)にあります。
