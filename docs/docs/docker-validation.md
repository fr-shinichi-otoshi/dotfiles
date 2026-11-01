# Dockerでの検証

## 検証の対象と前提

- **位置づけ**：整備者向けの検証の正です。余力のある実機がないため、WSL／Ubuntu実機での検証は行いません。
- **目的**：ホストのホーム設定を変更せず、初回構築・再適用・GitHub SSH認証を確認します。
- **対象**：ローカルのdotfilesリポジトリ。未コミット・未プッシュの変更も含みます。
- **流れ**：検証用イメージをbuild → コンテナ起動 → `chezmoi apply` → `scripts/bootstrap.sh` → `ssh -T git@github.com`。
- **ソース**：リポジトリはバインドマウントします。GitHubからのクローンは行いません。
- **SSH**：ホストの`~/.ssh`をread-onlyでマウントし、認証だけ確認します。
- **前提**：Dockerが起動済みであり、`docker version`でサーバーへ接続できる必要があります。
- **イメージ**：リポジトリ直下の`Dockerfile`（ベースは`jrei/systemd-ubuntu:24.04`）。
- **利用者向け手順との差**：利用者向けはsnapのchezmoi。検証イメージはコンテナ制約回避のためchezmoiバイナリを同梱します。

## 一発で検証する

ホスト側でdotfilesリポジトリのルートに移動して実行します。

```bash
bash docker/docker-validate.sh
```

このスクリプトが次を行います。

1. `Dockerfile`から`dotfiles-validate:local`をbuildします。
2. `dotfiles-check`コンテナをprivileged + cgroup付きで起動し、リポジトリと`~/.ssh`をマウントします。
3. リポジトリとSSH鍵を`developer`ホームへ同期します。
4. `docker-validate-run.sh`でapply/bootstrap/CLI確認/GitHub SSHを実行します。

成功時は標準出力に`ALL_CHECKS_PASSED`が出力されます。

Windows（PowerShell）から同じことをする場合の例は次のとおりです。

```powershell
wsl -e bash -lc 'cd /mnt/c/Users/<you>/develop/dotfiles && bash docker/docker-validate.sh'
```

またはGit Bashなどbashが使える環境でリポジトリルートから実行します。

## コンテナに入って確認する

検証後に手動で見る場合は、次のコマンドを実行します。

```bash
docker exec -it -u developer -w /home/developer \
  -e HOME=/home/developer -e USER=developer \
  -e PATH=/usr/local/bin:/home/developer/.local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
  dotfiles-check zsh
```

## 合格条件

- [ ] `bash docker/docker-validate.sh`が`ALL_CHECKS_PASSED`で終了します。
- [ ] ログインシェルが`/usr/bin/zsh`になります。
- [ ] 主要CLIと`docker`が起動できます。
- [ ] `chezmoi diff`に意図しない差分が残りません。
- [ ] `scripts/bootstrap.sh`の再実行が致命的に失敗しません。
- [ ] マウントしたSSH鍵で`ssh -T git@github.com`が成功します。

`hello-world`は検証コンテナ内のDocker-in-Docker制限で失敗することがあります。失敗しても検証スクリプトは続行し、警告のみ出します。

## 終了・再検証

```bash
docker rm -f dotfiles-check
```

再検証は`bash docker/docker-validate.sh`を再実行する（既存コンテナはスクリプトが削除する）。

## Docker検証の対象外

整備者は実機では検証しません。次の項目はDockerでは再現せず、検証対象外とします。利用者向けの手順は[セットアップ手順](getting-started.md)に残します。

- **snapのchezmoi**：検証イメージはバイナリ同梱で代替します。
- **対話的sudo・WSL2連携**：Windowsとの連携を含みます。
- **GUIやデスクトップ連携**。
- **各自のアカウント**：AI開発ツールの認証と実際の利用。
- **`hello-world`の確実な成功**：DinD制限で失敗することがあります。

[セットアップ手順へ](getting-started.md)
