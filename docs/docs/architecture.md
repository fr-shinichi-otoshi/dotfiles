# 構成と方針

整備者が、何をどこで管理しているかを把握するためのページです。変更作業は[設定の変更手順](maintenance.md)、検証は[Dockerでの検証](docker-validation.md)を使います。

## 対象環境

- **開発環境**：WSL2上のUbuntu、またはLinuxのUbuntu。Ubuntu 24.04 LTSを検証基準とします。
- **検証環境**：整備者向けの検証はDockerのみとします。実機検証は行いません。
- **検証の正**：`bash docker/docker-validate.sh`（`ubuntu:24.04`相当のsystemd有効コンテナ）。

## 設定の管理場所

### このリポジトリで共有するもの

- シェル・Git・AI開発ツールの共通設定、指示、スキル。
- パッケージの導入処理とバージョン指定。
- 新規プロジェクトを作る際にコピーする設定のひな形。

### 各プロジェクトで管理するもの

- プロジェクト固有の依存関係とビルド手順。
- プロジェクト固有のAI指示。
- lefthookのフック定義（`lefthook.yml`）。dotfilesはlefthookバイナリのみ入れます。

### 各自で管理するもの

- **個人設定**：Gitの名前・メールアドレス、環境ごとの値。
- **認証情報**：APIキー、アクセストークン、SSH秘密鍵。各自の認証管理先に保持します。

### 共通化のルール

- 個人差のある設定は、chezmoiのテンプレートで共通部分と分離します。
- 利用者は名前・メールアドレスの設定ファイルを自分で作成します。テンプレートの作成・保守は整備者が担当します。
- 認証情報はリポジトリにコミットしません。
- ホーム配下のドットファイルはchezmoiのみが管理します。mitamaeはプロビジョニングに限定します。

## 導入のレイヤ

| 層                     | 役割                     | 主な対象                                             |
| ---------------------- | ------------------------ | ---------------------------------------------------- |
| snap / chezmoi         | 設定配布の入口           | chezmoi導入、`init` / `apply`                        |
| `scripts/bootstrap.sh` | プロビジョニング入口     | mitamae取得、レシピ実行、mise再install、sheldon lock |
| mitamae                | マシンのプロビジョニング | apt、Docker Engine、mise導入、bashrc PATH、chsh→zsh  |
| mise                   | CLI / ランタイムの版管理 | シェル系、Git系、node / terraform、herdr / hunk など |

### 導入するツール

| ツール                 | 導入手段                     | 版                                                  |
| ---------------------- | ---------------------------- | --------------------------------------------------- |
| git / git-lfs          | apt（mitamae）               | ディストリビューション提供                          |
| zsh                    | apt（mitamae）               | ディストリビューション提供                          |
| vim                    | apt（mitamae）               | ディストリビューション提供。設定はchezmoiの`.vimrc` |
| poppler-utils / pandoc | apt（mitamae）               | ripgrep-all用                                       |
| chezmoi                | snap（`--classic`）          | snapチャネルの版                                    |
| mitamae                | GitHub Releases（bootstrap） | 2.0.6                                               |
| mise                   | 公式インストーラ（mitamae）  | インストーラが入れる版                              |
| Docker Engine          | 公式aptリポジトリ（mitamae） | stableチャネル                                      |
| CLI一式                | mise                         | `home/dot_config/mise/config.toml`が正              |

miseで入れる主なCLIは次のとおりです。

- 既存: `gh`/`sops`/`age`
- シェル: `fzf`/`ripgrep`/`fd`/`eza`/`sheldon`/`starship`/`atuin`
- Git: `lazygit`/`lefthook`/`delta`（`gitui`は入れません）
- ランタイム: `node`/`uv`/`terraform`/`tflint`/`terraform-docs`
- 追加: `broot`/`gping`/`ripgrep-all`/`lazydocker`
- エージェント／レビュー: `herdr`/`hunk`

CLIの版はリポジトリの`home/dot_config/mise/config.toml`が正です。chezmoiとDocker Engineはmiseでは管理しません。

## chezmoiとプロジェクトの関係

- chezmoiが`home/`配下のソースから設定ファイルを生成し、ホームディレクトリへ配置します。
- 各プロジェクトは、ホームに配置された共通設定を利用します。
- プロジェクト用のひな形は、必要なプロジェクトへ明示的にコピーします。

```text
~/dotfiles/              # Gitで取得するこのリポジトリ
~/.config/chezmoi/        # マシン固有のchezmoi設定
~/.config/               # ツールが利用する設定の配置先の例
~/develop/              # 各プロジェクトの配置先の例
```

## リポジトリ構成

```text
dotfiles/
├── README.md
├── scripts/                  # 利用者向け入口
│   ├── bootstrap.sh          # プロビジョニングの入口
│   └── update.sh             # 日常更新（今後）
├── docker/                   # 整備者向け Docker 検証
│   └── docker-validate*.sh
├── .chezmoiroot              # 内容をhomeとし、管理対象のルートを指定
├── mitamae/                  # プロビジョニング用レシピ
│   ├── recipes/default.rb
│   └── roles/
├── home/                     # ホームディレクトリへ適用するソース
│   ├── dot_zshenv / dot_zshrc / dot_zsh_aliases
│   ├── dot_vimrc
│   ├── dot_gitconfig.tmpl / dot_gitignore_global
│   └── dot_config/{mise,sheldon,starship,atuin}/
├── docs/
└── templates/                # プロジェクト用のひな形（今後）
```

- **読み込み先**：リポジトリ直下の`.chezmoiroot`に`home`を記載し、`home/`を管理対象のルートにします。
- **配置の対応**：`home/dot_config/`は`~/.config/`に対応します。
- **開発用ファイル**：README、`docs/`、`mitamae/`、`scripts/`、`docker/`は`home/`の外に置き、ホームへの配置対象から分離します。
- **既存ファイルの扱い**：`.agent/`、`.cursor/`、`CLAUDE.md`は、リポジトリ開発用ならルートに残し、配布する設定のみchezmoiの命名規則に従って`home/`配下へ追加します。

## bootstrap.shの設計

- **実行ユーザー**：sudoを実行できる一般ユーザー。
- **前提**：snapでchezmoiを導入し、このリポジトリをsourceにして`chezmoi apply`済みであること。
- **入口**：リポジトリ直下で`bash scripts/bootstrap.sh`を実行します。
- **担当する処理**：mitamaeの取得、レシピ実行、miseの再install、sheldon lock。
- **担当しない処理**：chezmoiのinstall/init/apply。日常更新用の`scripts/update.sh`は別途（未実装）。
- **再実行**：導入済みのツールを考慮して処理します。
- **SSH認証**：鍵の生成・GitHubへの登録は利用者が初回導入時に行い、`scripts/bootstrap.sh`では扱いません。

## 実装・検証状況

| 項目                 | 状態                                                        |
| -------------------- | ----------------------------------------------------------- |
| 導入手順             | 記載済み。整備者検証はDockerのみ                            |
| chezmoi（snap）      | 手順化済み（bootstrap外）。Docker検証ではバイナリ同梱で代替 |
| scripts/bootstrap.sh | 実装済み（プロビジョニング専用）                            |
| mitamaeレシピ        | 実装済み（apt / Docker / mise / PATH / zsh）                |
| miseツール定義       | 実装済み（シェル・Git・delta・ランタイム・herdr / hunk）    |
| chezmoiシェル設定    | 実装済み（zsh / sheldon / starship / atuin）                |
| chezmoi Vim設定      | 実装済み（`.vimrc` + vim-plug 自動導入）                    |
| 共通アプリ設定       | Git設定テンプレート実装済み（署名・鍵運用は未整備）         |
| scripts/update.sh    | 未実装（範囲外）                                            |
| Docker検証・自動化   | 検証の正。手順あり（変更後は再実行して確認）                |
| WSL／Ubuntu実機検証  | 対象外（余力のある実機がない）                              |

## 今後の整備順序

1. **Dockerでの検証**：変更後は`bash docker/docker-validate.sh`で初回・再実行を確認します。
2. **秘密情報の扱い**：age/sopsの鍵配置と運用を定めます。
3. **日常更新**：必要なら`scripts/update.sh`を追加します。

snapのchezmoi・対話的sudo・WSL連携・GUI・実アカウント認証はDockerでは再現しません。利用者向け手順は[セットアップ](getting-started.md)に残し、整備者の検証対象外とします。
