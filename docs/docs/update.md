# 導入後の更新

初回セットアップ済みの環境を、配布元の最新内容に合わせます。

- 自分のフォークを利用している場合は、配布元の変更をフォークへ取り込んでから実行します。
- ローカルでファイルを変更している場合は、先に管理者と変更内容を確認します。
- 個人設定（`chezmoi.toml`）の再作成は不要です。

```bash
cd ~/dotfiles
git pull --ff-only
chezmoi apply --source="$PWD"
bash scripts/bootstrap.sh
```

更新後は新しいターミナルを開くか`exec zsh`を実行し、[導入結果を確認する](getting-started.md#導入結果を確認する)を確認します。

失敗したら先へ進まず、[困ったとき](troubleshooting.md)を確認します。
