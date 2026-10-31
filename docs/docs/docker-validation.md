# Dockerでの検証

## 検証の対象と前提

- **目的**：ホストのホーム設定を変更せず、初回構築・再適用・GitHub SSH認証を確認する。
- **対象**：ローカルのdotfilesリポジトリ。未コミット・未プッシュの変更も含む。
- **流れ**：検証用イメージを build → コンテナ起動 → `chezmoi apply` → `bootstrap.sh` → `ssh -T git@github.com`。
- **ソース**：リポジトリはバインドマウントする。GitHubからのクローンは行わない。
- **SSH**：ホストの`~/.ssh`をread-onlyでマウントし、認証だけ確認する。
- **前提**：Dockerが起動済みであり、`docker version`でサーバーへ接続できること。
- **イメージ**：リポジトリ直下の`Dockerfile`（ベースは`jrei/systemd-ubuntu:24.04`）。
- **実環境との差**：利用者向けはsnapのchezmoi。検証イメージはコンテナ制約回避のためchezmoiバイナリを同梱する。

## 一発で検証する

ホスト側でdotfilesリポジトリのルートに移動して実行する。

```bash
bash scripts/docker-validate.sh
```

このスクリプトが次を行う。

1. `Dockerfile`から`dotfiles-validate:local`を build する。
2. `dotfiles-check`コンテナを privileged + cgroup 付きで起動し、リポジトリと`~/.ssh`をマウントする。
3. リポジトリとSSH鍵を`developer`ホームへ同期する。
4. `docker-validate-run.sh`で apply / bootstrap / CLI確認 / GitHub SSH を実行する。

成功時は標準出力に`ALL_CHECKS_PASSED`が出力される。

Windows（PowerShell）から同じことをする場合の例:

```powershell
wsl -e bash -lc 'cd /mnt/c/Users/<you>/develop/dotfiles && bash scripts/docker-validate.sh'
```

または Git Bash など bash が使える環境でリポジトリルートから実行する。

## コンテナに入って確認する

検証後に手動で見る場合:

```bash
docker exec -it -u developer -w /home/developer \
  -e HOME=/home/developer -e USER=developer \
  -e PATH=/usr/local/bin:/home/developer/.local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  dotfiles-check zsh
```

## 合格条件

- [ ] `bash scripts/docker-validate.sh`が`ALL_CHECKS_PASSED`で終了する。
- [ ] ログインシェルが`/usr/bin/zsh`になる。
- [ ] 主要CLIと`docker`が起動できる。
- [ ] `chezmoi diff`に意図しない差分が残らない。
- [ ] `bootstrap.sh`の再実行が致命的に失敗しない。
- [ ] マウントしたSSH鍵で`ssh -T git@github.com`が成功する。

`hello-world`は検証コンテナ内のDocker-in-Docker制限で失敗しうる。実機では[セットアップ手順](getting-started.md)の確認を行う。

## 終了・再検証

```bash
docker rm -f dotfiles-check
```

再検証は`bash scripts/docker-validate.sh`を再実行する（既存コンテナはスクリプトが削除する）。

## 実環境で別途確認する項目

- **WSL2上のUbuntu**：Windowsとの連携、利用者向けの対話的sudo、snapのchezmoi。
- **GUIやデスクトップ連携**：このDocker検証の対象外。
- **各自のアカウント**：AI開発ツールの認証と実際の利用。

[セットアップ手順へ](getting-started.md)
