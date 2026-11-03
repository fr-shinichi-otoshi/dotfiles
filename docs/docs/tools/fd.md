---
title: fd
---

# fd

ファイルやディレクトリを名前で探すツールです。`find`の代わりに使います。

## この環境での役割

- 単体の検索コマンドとして使います。
- [fzf](fzf.md)のファイル列挙もfdです。fzf経由のときだけ、隠しファイルを含め`.git`を除外します。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`fd`です。
- 確認コマンドは`fd --version`です。

## 設定

このリポジトリは専用の設定ファイルを配布しません。

## 使い方

```bash
fd '\.md$' docs
fd --type d tools
fd --hidden --exclude .git
```

- 既定では隠しファイルを出さず、`.gitignore`に合うパスも除外します。
- `--type f`はファイル、`--type d`はディレクトリです。

## 関連

- [fzf](fzf.md)
- [ripgrep](ripgrep.md)

## 参考資料

- [fd](https://github.com/sharkdp/fd)
