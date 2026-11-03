---
title: Vim
---

# Vim

共通設定付きのエディタです。Gitの`core.editor`もVimです。

## この環境での役割

- 設定ファイルは`home/dot_vimrc`です。配置先は`~/.vimrc`です。
- 初回起動でvim-plugとプラグインを入れます。
- パッケージ本体に専用の設定はほぼ無く、振る舞いは`.vimrc`が決めます。

## 導入

- パッケージの定義は`mitamae/roles/apt.rb`です。
- 版はUbuntuの提供版です。
- 確認コマンドは`vim --version`です。
- 初回起動時にvim-plugをダウンロードします。続けて未導入プラグインを入れ、`.vimrc`を読み直します。
- curlが無いとvim-plugは入りません。curlは[補助パッケージ](support-packages.md)で入ります。

## 基本の表示

- リーダーキーはスペースです。
- 行番号は絶対番号と相対番号の両方です。
- 検索は大小を無視し、大文字を含むときだけ区別します。
- 分割は下と右へ開きます。

## プラグイン

| プラグイン     | 役割                                       |
| -------------- | ------------------------------------------ |
| vim-fugitive   | Git の status、commit、blame などです。    |
| vim-gitgutter  | 変更行の表示と hunk 操作です。             |
| committia.vim  | コミットメッセージ編集時に差分を出します。 |
| vim-commentary | `gcc`と`gc`でコメントを切り替えます。      |
| vim-surround   | 括弧や引用符を操作します。                 |
| vim-repeat     | プラグイン操作の繰り返しに`.`を使います。  |
| NERDTree       | ファイルツリーです。                       |
| lightline.vim  | ステータスラインです。                     |
| vim-helm       | Helm テンプレートの色分けです。            |

NERDTreeは隠しファイルを表示し、飾りを減らした表示です。

## キー

| キー                                | 動作                                   |
| ----------------------------------- | -------------------------------------- |
| `Space e`                           | ファイルツリーを開閉します。           |
| `Space E`                           | 現在ファイルの場所をツリーで開きます。 |
| `Space w`                           | 保存します。                           |
| `Space g s`                         | Git の status を開きます。             |
| `Space g a`                         | 現在ファイルをステージします。         |
| `Space g c`                         | コミット画面を開きます。               |
| `Space g d`                         | 差分を左右に開きます。                 |
| `Space g b`                         | blame を表示します。                   |
| `Space g g`                         | Git grep を始めます。                  |
| `]h` / `[h`                         | 次または前の変更 hunk へ移動します。   |
| `Space h s`                         | hunk をステージします。                |
| `Space h u`                         | hunk の変更を取り消します。            |
| `Space h p`                         | hunk の差分をプレビューします。        |
| `Ctrl-h` `Ctrl-j` `Ctrl-k` `Ctrl-l` | ウィンドウを移動します。               |
| `[b` / `]b`                         | 前後のバッファへ移動します。           |
| `Esc Esc`                           | 検索ハイライトを消します。             |

## ファイル種別

- YAMLのインデントは2です。行の目安は121桁です。タブと行末空白を表示します。
- コミットメッセージは72桁で折り返します。目安の列は51と73です。英文のスペルチェックを有効にします。

## 関連

- [Git](git.md)
- [補助パッケージ](support-packages.md)

## 参考資料

- [Vim](https://www.vim.org/)
- [vim-plug](https://github.com/junegunn/vim-plug)
