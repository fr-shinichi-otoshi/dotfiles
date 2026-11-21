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
- Serenaの版は`scripts/install-serena.sh`の`SERENA_AGENT_VERSION`です。
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
- [gitui](gitui.md)：Gitの画面操作です。
- [difftastic](difftastic.md)：構文に基づく差分表示です。
- [actionlint](actionlint.md)：GitHub Actionsのworkflowを検査します。
- [gitleaks](gitleaks.md)：秘密情報の混入を検出します。
- [commitlint](commitlint.md)：コミットメッセージの形式を検査します。

## ランタイムと IaC

- [Node.js](node.md)：JavaScriptの実行環境です。
- [uv](uv.md)：Pythonの環境とパッケージを扱います。
- [Rust](rust.md)：tokeiのビルドに使うコンパイラです。
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
- [repomix](repomix.md)：リポジトリをLLM向けの1ファイルにまとめます。
- [Serena](serena.md)：シンボル単位でコードを探索するMCPサーバーです。

## 構造化データと構文

- [jq](jq.md)：JSONを抽出・変換します。
- [yq](yq.md)：YAMLなどの構造化データを扱います。Mike Farah版です。
- [ast-grep](ast-grep.md)：コードを構文の形で検索・置換します。
- [tokei](tokei.md)：言語ごとの行数を集計します。

## 検査と計測

- [ShellCheck](shellcheck.md)：シェルスクリプトを静的に検査します。
- [shfmt](shfmt.md)：シェルスクリプトを整形します。
- [Ruff](ruff.md)：Pythonを検査・整形します。
- [Knip](knip.md)：JavaScriptとTypeScriptの未使用コードを検出します。
- [OSV-Scanner](osv-scanner.md)：依存関係の既知の脆弱性を調べます。
- [hyperfine](hyperfine.md)：コマンドの実行時間を測ります。

## ネットワーク

- [xh](xh.md)：HTTPリクエストを送ります。
- [watchexec](watchexec.md)：ファイル変更でコマンドを再実行します。

## 画像

- [oxipng](oxipng.md)：PNGを可逆圧縮します。
- [cwebp](cwebp.md)：画像をWebPに変換します。
