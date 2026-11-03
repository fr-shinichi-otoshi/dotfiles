---
title: eza
---

# eza

ディレクトリの一覧を色分けして出すツールです。対話シェルでは`ls`の実体です。

## この環境での役割

- `~/.zsh_aliases`が`ls`系のエイリアスをezaにします。
- ソースは`home/dot_zsh_aliases`です。
- 非対話シェルではこのエイリアスを読みません。スクリプト内の`ls`は従来の`ls`のままです。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`eza`です。
- 確認コマンドは`eza --version`です。

## エイリアス

共通オプションは`--color=auto`と`--group-directories-first`です。ディレクトリを先に出します。

| エイリアス | 追加オプション | 動作                               |
| ---------- | -------------- | ---------------------------------- |
| `ls`       | なし           | 色付きの一覧です。                 |
| `ll`       | `-l`           | 長い形式です。                     |
| `la`       | `-la`          | 隠しファイルも含めた長い形式です。 |
| `lt`       | `--tree`       | ツリーです。                       |
| `l`        | `-1`           | 1 列です。                         |

## 関連

- [zsh](zsh.md)
- [broot](broot.md)

## 参考資料

- [eza](https://github.com/eza-community/eza)
