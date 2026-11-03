---
title: Starship
---

# Starship

シェルのプロンプトです。Gitの状態や実行環境の版などを表示します。

## この環境での役割

- `~/.zshrc`が`starship init zsh`を実行します。
- 見た目はStarshipの既定です。このリポジトリは色や記号を上書きしません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`starship`です。
- 確認コマンドは`starship --version`です。
- zshの補完は[sheldon](sheldon.md)が生成します。

## 設定

- ソースは`home/dot_config/starship.toml`です。配置先は`~/.config/starship.toml`です。
- ファイルの記述はコメントだけです。
- モジュールを変えるときは、このファイルへStarshipの設定を書きます。

## 関連

- [zsh](zsh.md)
- [Git](git.md)

## 参考資料

- [Starship](https://starship.rs/)
- [設定項目](https://starship.rs/config/)
