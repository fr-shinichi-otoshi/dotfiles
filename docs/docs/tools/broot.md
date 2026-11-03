---
title: broot
---

# broot

ディレクトリツリーを眺めて移動するツールです。

## この環境での役割

- 深い階層の確認と、移動先の選択に使います。
- `~/.zshrc`が`broot --print-shell-function zsh`を実行し、`br`関数を定義します。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`broot`です。
- 確認コマンドは`broot --version`です。

## 設定

このリポジトリはbrootの設定ファイルを配布しません。初回起動時に、設定ファイル作成の案内が出る場合もあります。

## 使い方

```bash
br
```

- 普段は`br`を使います。終了時に選んだディレクトリへシェルが移動します。
- ディレクトリを選んで移動するキーはAlt-Enterです。
- `broot`コマンド自体も入っています。こちらは移動用のシェル関数を通しません。

一覧だけなら[eza](eza.md)の`lt`です。

## 関連

- [eza](eza.md)
- [zsh](zsh.md)

## 参考資料

- [broot](https://dystroy.org/broot/)
