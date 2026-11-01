# 導入後の更新

初回セットアップ済みの環境を、最新内容に合わせます。

- ローカルでファイルを変更している場合は、先に管理者と変更内容を確認します。
- 個人設定（`chezmoi.toml`）の再作成は不要です。

配布元の変更を自分のフォークへ取り込む場合の例です。初回だけ`upstream`を登録します。

```bash
cd ~/dotfiles
git remote add upstream git@github.com:fr-shinichi-otoshi/dotfiles.git
git fetch upstream
git checkout main
git merge --ff-only upstream/main
git push origin main
```

すでに`upstream`がある場合は、`git remote add`は不要です。取り込めたらローカルへ適用します。

```bash
cd ~/dotfiles
git pull --ff-only
chezmoi apply --source="$PWD"
bash scripts/bootstrap.sh
```

更新後は新しいターミナルを開くか`exec zsh`を実行し、[導入結果を確認する](getting-started.md#導入結果を確認する)を確認します。

失敗したら先へ進まず、[困ったとき](troubleshooting.md)を確認します。
