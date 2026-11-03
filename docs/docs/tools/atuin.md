---
title: atuin
---

# atuin

シェルのコマンド履歴を保存し、検索するツールです。

## この環境での役割

- Ctrl-Rと上矢印の履歴検索を担当します。
- `atuin init zsh`は[fzf](fzf.md)より後に実行します。
- 同期用のアカウントは設定しません。履歴は各マシンのローカルです。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`atuin`です。
- 確認コマンドは`atuin --version`です。
- zshの補完は[sheldon](sheldon.md)が生成します。

## 設定

- ソースは`home/dot_config/atuin/config.toml`です。配置先は`~/.config/atuin/config.toml`です。
- 変えている項目は`enter_accept = false`だけです。

## 操作

- `Ctrl-R`で検索画面を開きます。上矢印でも、入力中のコマンドを条件に検索します。
- 検索画面のEnterは、コマンドを実行しません。
- 選んだコマンドはプロンプトへ入ります。
- 実行するときは、シェルでEnterを押します。

## 関連

- [zsh](zsh.md)
- [fzf](fzf.md)

## 参考資料

- [atuin](https://docs.atuin.sh/)
- [設定項目](https://docs.atuin.sh/configuration/config/)
