---
title: chezmoi
---

# chezmoi

ホームディレクトリへ設定ファイルを配るツールです。

## この環境での役割

- シェル、Git、エディタ、miseなどの共通設定を配ります。
- 個人の名前とメールアドレスは、マシン上の`~/.config/chezmoi/chezmoi.toml`から展開します。
- 認証情報はリポジトリへ入れません。

## 導入

- 導入手段はsnapです。コマンドは`sudo snap install chezmoi --classic`です。
- 版はsnapのチャネルに従います。
- 確認コマンドは`chezmoi --version`です。
- `scripts/bootstrap.sh`はchezmoiの導入とapplyを行いません。先に[セットアップ](../getting-started.md#chezmoiを導入し設定を適用する)を終えます。

## 設定の対応

- ソースのルートはリポジトリ直下の`.chezmoiroot`で、中身は`home`です。
- `home/dot_zshrc`は`~/.zshrc`に対応します。
- `home/dot_config/`は`~/.config/`に対応します。
- 末尾が`.tmpl`のファイルはテンプレートです。適用時に展開します。
- 名前かメールアドレスが空だと、`~/.gitconfig`の生成は失敗します。

## 使い方

リポジトリ直下で実行します。

```bash
chezmoi diff --source="$PWD"
chezmoi apply --source="$PWD"
```

- `chezmoi diff`は、適用すると変わる内容を表示します。
- `chezmoi apply`は、ホームへ反映します。
- 既存のホーム上のファイルをソースへ取り込むときは`chezmoi add`です。手順は[設定の変更手順](../maintenance.md#管理対象を追加する)です。

## 関連

- [mise](mise.md)
- [Git](git.md)
- [zsh](zsh.md)

## 参考資料

- [chezmoi](https://www.chezmoi.io/)
