---
title: zsh
---

# zsh

ログインシェルです。プロンプト、補完、履歴検索は別ツールが担当します。

## この環境での役割

- 対話の入口をbashからzshへ切り替えます。
- 共通の履歴、補完、エイリアスを配ります。
- [sheldon](sheldon.md)、[fzf](fzf.md)、[Starship](starship.md)、[broot](broot.md)、[atuin](atuin.md)を起動します。

## 導入

- パッケージの定義は`mitamae/roles/apt.rb`です。
- ログインシェルの変更は`mitamae/roles/zsh.rb`です。
- 切り替え先は`/usr/bin/zsh`です。`/etc/shells`へ登録してから`chsh`します。
- 版はUbuntuの提供版です。
- 確認コマンドは`zsh --version`です。ログインシェルは`getent passwd "$USER" | cut -d: -f7`で見ます。

反映には、新しいターミナルか`exec zsh`が要ります。

## 設定ファイル

| ソース                 | 配置先           | 役割                                         |
| ---------------------- | ---------------- | -------------------------------------------- |
| `home/dot_zshenv`      | `~/.zshenv`      | PATH と mise。非対話シェルでも読みます。     |
| `home/dot_zshrc`       | `~/.zshrc`       | 対話シェルの履歴、補完、各ツールの起動です。 |
| `home/dot_zsh_aliases` | `~/.zsh_aliases` | 一覧表示などのエイリアスです。               |

`~/.local/bin`をPATHの先頭へ置きます。miseとmitamaeの実行ファイルがここにあります。

## 対話シェルの起動順

1. `~/.zsh_aliases`を読みます。
2. sheldonでプラグインを読みます。
3. `fzf --zsh`を読みます。
4. Starshipを初期化します。
5. brootの`br`を定義します。
6. atuinを初期化します。最後なので、履歴検索のCtrl-Rはatuinです。

## 履歴と移動

- 履歴ファイルは`~/.zsh_history`です。
- 保存件数は50000です。セッション間で共有します。
- 重複する履歴は残しません。先頭が空白のコマンドも残しません。
- ディレクトリ名だけで`cd`できます。
- `d`でディレクトリスタックを表示します。`1`から`9`でそこへ戻ります。
- 細かいsetoptは`home/dot_zshrc`に書いてあります。

## 関連

- [mise](mise.md)
- [eza](eza.md)
- [sheldon](sheldon.md)

## 参考資料

- [zsh](https://www.zsh.org/)
