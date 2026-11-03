---
title: fzf
---

# fzf

あいまい検索で、ファイルやディレクトリの候補を絞るツールです。

## この環境での役割

- コマンドラインへのパス入力を補います。
- ファイル列挙は[fd](fd.md)です。
- 履歴検索のCtrl-Rは[atuin](atuin.md)が担当します。atuinをfzfより後に読むためです。
- 補完メニューの見た目は、sheldonのfzf-tabです。説明は[sheldon](sheldon.md)です。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`fzf`です。
- 確認コマンドは`fzf --version`です。

## 設定

`~/.zshrc`が`fzf --zsh`を読み、次を決めます。

- ファイル列挙は`fd --type f --hidden --follow --exclude .git`です。
- ディレクトリ列挙は`fd --type d`に、同じ隠しファイル指定と`.git`除外を付けたものです。
- 高さは画面の40% です。一覧は下から上へ並び、枠を表示します。
- Ctrl-Tのプレビューは`bat`を試し、失敗したら`cat`です。
- この環境の導入対象に`bat`は含みません。プレビューは`cat`になります。

## 操作

- `Ctrl-T`：カーソル位置へファイルパスを挿入します。
- `Alt-C`：選んだディレクトリへ移動します。

単体の`fd`は、既定では隠しファイルを出しません。fzfから呼ぶときだけ隠しファイルを含めます。

## 関連

- [fd](fd.md)
- [atuin](atuin.md)
- [zsh](zsh.md)

## 参考資料

- [fzf](https://github.com/junegunn/fzf)
