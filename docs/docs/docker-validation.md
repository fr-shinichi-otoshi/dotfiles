# Dockerでの検証

## 検証の対象と前提

- **位置づけ**：整備者向けの検証の正である。余力のある実機がないため、WSL／Ubuntu実機での検証は行わない。
- **目的**：ホストのホーム設定を変更せず、初回構築・再適用・GitHub SSH認証を確認する。
- **対象**：ローカルのdotfilesリポジトリ。未コミット・未プッシュの変更も含む。
- **流れ**：検証用イメージを build → コンテナ起動 → `chezmoi apply` → `scripts/bootstrap.sh` → `ssh -T git@github.com`。
- **ソース**：リポジトリはバインドマウントする。GitHubからのクローンは行わない。
- **SSH**：ホストの`~/.ssh`をread-onlyでマウントし、認証だけ確認する。
- **前提**：Dockerが起動済みであり、`docker version`でサーバーへ接続できること。
- **イメージ**：リポジトリ直下の`Dockerfile`（ベースは`jrei/systemd-ubuntu:24.04`）。
- **利用者向け手順との差**：利用者向けはsnapのchezmoi。検証イメージはコンテナ制約回避のためchezmoiバイナリを同梱する。

## 一発で検証する

ホスト側でdotfilesリポジトリのルートに移動して実行する。

```bash
bash docker/docker-validate.sh
```

このスクリプトが次を行う。

1. `Dockerfile`から`dotfiles-validate:local`を build する。
2. `dotfiles-check`コンテナを privileged + cgroup 付きで起動し、リポジトリと`~/.ssh`をマウントする。
3. リポジトリとSSH鍵を`developer`ホームへ同期する。
4. `docker-validate-run.sh`で apply / bootstrap / CLI確認 / GitHub SSH を実行する。

成功時は標準出力に`ALL_CHECKS_PASSED`が出力される。

Windows（PowerShell）から同じことをする場合の例:

```powershell
wsl -e bash -lc 'cd /mnt/c/Users/<you>/develop/dotfiles && bash docker/docker-validate.sh'
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

- [ ] `bash docker/docker-validate.sh`が`ALL_CHECKS_PASSED`で終了する。
- [ ] ログインシェルが`/usr/bin/zsh`になる。
- [ ] 主要CLIと`docker`が起動できる。
- [ ] `chezmoi diff`に意図しない差分が残らない。
- [ ] `scripts/bootstrap.sh`の再実行が致命的に失敗しない。
- [ ] マウントしたSSH鍵で`ssh -T git@github.com`が成功する。

`hello-world`は検証コンテナ内のDocker-in-Docker制限で失敗しうる。失敗しても検証スクリプトは続行し、警告のみ出す。

## 終了・再検証

```bash
docker rm -f dotfiles-check
```

再検証は`bash docker/docker-validate.sh`を再実行する（既存コンテナはスクリプトが削除する）。

## Docker検証の対象外

整備者は実機検証を行わない。次の項目はDockerでは再現せず、検証対象外とする。利用者向けの手順は[セットアップ手順](getting-started.md)に残す。

- **snapのchezmoi**：検証イメージはバイナリ同梱で代替する。
- **対話的sudo・WSL2連携**：Windowsとの連携を含む。
- **GUIやデスクトップ連携**。
- **各自のアカウント**：AI開発ツールの認証と実際の利用。
- **`hello-world`の確実な成功**：DinD制限で失敗しうる。

[セットアップ手順へ](getting-started.md)
