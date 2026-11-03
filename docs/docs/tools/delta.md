---
title: delta
---

# delta

Gitの差分を色分けし、左右に並べて見せるページャです。

## この環境での役割

- `git diff`や`git show`の表示に使います。
- 対話的な`git add -p`の色付けにも使います。
- 設定はGitの共通設定に含まれます。delta単体の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`delta`です。
- 確認コマンドは`delta --version`です。

## 設定

ソースは`home/dot_gitconfig.tmpl`です。有効にしている項目は次のとおりです。

- `core.pager`は`delta`です。
- `interactive.diffFilter`は`delta --color-only`です。
- `navigate`により、差分内のファイル移動ができます。
- `side-by-side`により、変更前後を左右に並べます。
- `line-numbers`により、行番号を出します。

差分アルゴリズムのhistogramや移動行の色は、Git側の`[diff]`です。説明は[Git](git.md)です。

## 関連

- [Git](git.md)
- [lazygit](lazygit.md)

## 参考資料

- [delta](https://dandavison.github.io/delta/)
