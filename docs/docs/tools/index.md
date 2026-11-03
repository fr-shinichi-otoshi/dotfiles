---
title: 導入するツール
---

# 導入するツール

導入済みツールの役割と、設定ファイルの場所です。

## 関連する手順

- 初回導入は[セットアップ](../getting-started.md)です。
- 日常の更新は[導入後の更新](../update.md)です。
- 管理方針は[構成と方針](../architecture.md)です。
- 変更手順は[設定の変更手順](../maintenance.md)です。

## 読み方

- `home/`で始まるパスは、リポジトリ内のソースです。
- `~/`で始まるパスは、chezmoi適用後の配置先です。
- zshプラグインの説明は[sheldon](sheldon.md)です。
- Vimプラグインの説明は[Vim](vim.md)です。

## 版の置き場所

- aptパッケージはUbuntuの提供版です。
- chezmoiはsnapのチャネルに従います。
- mitamaeの版は`scripts/bootstrap.sh`に書いた`MITAMAE_VERSION`です。現在の指定は`2.0.6`です。
- mise本体は公式インストーラが入れる版です。
- mise管理CLIの版は`home/dot_config/mise/config.toml`が正です。
- Docker Engineは公式aptのstableです。

多くのCLIは`--version`で確認します。例外は各ページに書いてあります。

## 基盤

- [chezmoi](chezmoi.md)：設定ファイルをホームへ配ります。
- [mitamae](mitamae.md)：aptやDockerなどを導入します。
- [mise](mise.md)：CLIとランタイムの版を管理します。
- [Git](git.md)：バージョン管理と、共通のGit設定です。
- [zsh](zsh.md)：ログインシェルです。
- [Vim](vim.md)：共通のエディタ設定です。
- [Docker Engine](docker.md)：コンテナ実行環境です。
- [補助パッケージ](support-packages.md)：他ツールが依存するaptパッケージです。

## シェル

- [fzf](fzf.md)：あいまい検索で入力を補います。
- [ripgrep](ripgrep.md)：テキストを高速に検索します。
- [fd](fd.md)：ファイルやディレクトリを検索します。
- [eza](eza.md)：対話シェルの一覧表示です。
- [sheldon](sheldon.md)：zshプラグインを読みます。
- [Starship](starship.md)：プロンプトです。
- [atuin](atuin.md)：コマンド履歴を検索します。
- [broot](broot.md)：ディレクトリツリーを操作します。
- [gping](gping.md)：応答時間をグラフで見ます。

## Git

- [delta](delta.md)：差分の表示です。
- [lazygit](lazygit.md)：Gitの画面操作です。
- [lefthook](lefthook.md)：Gitフックの実行です。
- [GitHub CLI](gh.md)：GitHubをコマンドで操作します。

## ランタイムと IaC

- [Node.js](node.md)：JavaScriptの実行環境です。
- [uv](uv.md)：Pythonの環境とパッケージを扱います。
- [Terraform](terraform.md)：インフラ定義の実行です。
- [tflint](tflint.md)：Terraformの静的検査です。
- [terraform-docs](terraform-docs.md)：Terraformモジュールの文書生成です。

## 検索とコンテナ

- [ripgrep-all](ripgrep-all.md)：PDFやOffice文書の中も検索します。
- [lazydocker](lazydocker.md)：Dockerの画面操作です。

## 秘密情報

鍵の配置と運用は未整備です。方針は[今後の整備順序](../architecture.md#今後の整備順序)にあります。

- [age](age.md)：ファイルを暗号化します。
- [SOPS](sops.md)：秘密情報ファイルを暗号化したまま扱います。

## エージェントとレビュー

- [herdr](herdr.md)：エージェント向けのターミナル作業空間です。
- [hunk](hunk.md)：差分レビューの画面です。
