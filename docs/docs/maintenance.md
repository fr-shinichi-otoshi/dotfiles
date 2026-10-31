# 管理・保守の方針

## 対象環境

- **開発環境**：WSL2上のUbuntu、またはLinuxのUbuntu。Ubuntu 24.04 LTSを検証基準とする。
- **検証環境**：`ubuntu:24.04`相当のsystemd有効Dockerコンテナで、導入処理と設定の初回適用・再適用を確認する。

## 設定の管理場所

### このリポジトリで共有するもの

- シェル・Git・AI開発ツールの共通設定、指示、スキル。
- パッケージの導入処理とバージョン指定。
- 新規プロジェクトを作る際にコピーする設定のひな形。

### 各プロジェクトで管理するもの

- プロジェクト固有の依存関係とビルド手順。
- プロジェクト固有のAI指示。
- lefthookのフック定義（`lefthook.yml`）。dotfilesはlefthookバイナリのみ入れる。

### 各自で管理するもの

- **個人設定**：Gitの名前・メールアドレス、環境ごとの値。
- **認証情報**：APIキー、アクセストークン、SSH秘密鍵。各自の認証管理先に保持する。

### 共通化のルール

- 個人差のある設定は、chezmoiのテンプレートで共通部分と分離する。
- 利用者は`echo`コマンドで名前・メールアドレスの設定ファイルを作成する。テンプレートの作成・保守は整備者が担当する。
- 認証情報はリポジトリにコミットしない。
- ホーム配下のドットファイルはchezmoiのみが管理する。mitamaeはプロビジョニングに限定する。

## 導入のレイヤ

| 層 | 役割 | 主な対象 |
| --- | --- | --- |
| snap / chezmoi | 設定配布の入口 | chezmoi導入、`init` / `apply` |
| `bootstrap.sh` | プロビジョニング入口 | mitamae取得、レシピ実行、mise再install、sheldon lock |
| mitamae | マシンのプロビジョニング | apt、Docker Engine、mise導入、bashrc PATH、chsh→zsh |
| mise | CLI / ランタイムの版管理 | シェル系、Git系、node / terraform、herdr / hunk など |

### 導入するツール

| ツール | 導入手段 | 版 |
| --- | --- | --- |
| git / git-lfs | apt（mitamae） | ディストリビューション提供 |
| zsh | apt（mitamae） | ディストリビューション提供 |
| poppler-utils / pandoc | apt（mitamae） | ripgrep-all用 |
| chezmoi | snap（`--classic`） | snapチャネルの版 |
| mitamae | GitHub Releases（bootstrap） | 2.0.6 |
| mise | 公式インストーラ（mitamae） | インストーラが入れる版 |
| Docker Engine | 公式aptリポジトリ（mitamae） | stableチャネル |
| CLI一式 | mise | `home/dot_config/mise/config.toml`が正 |

miseで入れる主なCLIは次のとおりである。

- 既存: `gh` / `sops` / `age`
- シェル: `fzf` / `ripgrep` / `fd` / `eza` / `sheldon` / `starship` / `atuin`
- Git: `lazygit` / `lefthook`（`gitui`は入れない）
- ランタイム: `node` / `uv` / `terraform` / `tflint` / `terraform-docs`
- 追加: `broot` / `gping` / `ripgrep-all` / `lazydocker`
- エージェント／レビュー: `herdr` / `hunk`

CLIの版はリポジトリの`home/dot_config/mise/config.toml`が正である。chezmoiとDocker Engineはmiseでは管理しない。

## chezmoiとプロジェクトの関係

- chezmoiが`home/`配下のソースから設定ファイルを生成し、ホームディレクトリへ配置する。
- 各プロジェクトは、ホームに配置された共通設定を利用する。
- プロジェクト用のひな形は、必要なプロジェクトへ明示的にコピーする。

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
├── bootstrap.sh              # プロビジョニングの入口
├── .chezmoiroot              # 内容をhomeとし、管理対象のルートを指定
├── mitamae/                  # プロビジョニング用レシピ
│   ├── recipes/default.rb
│   └── roles/
├── home/                     # ホームディレクトリへ適用するソース
│   ├── dot_zshenv / dot_zshrc / dot_zsh_aliases
│   └── dot_config/{mise,sheldon,starship,atuin}/
├── docs/
└── templates/                # プロジェクト用のひな形（今後）
```

- **読み込み先**：リポジトリ直下の`.chezmoiroot`に`home`を記載し、`home/`を管理対象のルートにする。
- **配置の対応**：`home/dot_config/`は`~/.config/`に対応する。
- **開発用ファイル**：README、`docs/`、`mitamae/`、`bootstrap.sh`は`home/`の外に置き、ホームへの配置対象から分離する。
- **既存ファイルの扱い**：`.agent/`、`.cursor/`、`CLAUDE.md`は、リポジトリ開発用ならルートに残し、配布する設定のみchezmoiの命名規則に従って`home/`配下へ追加する。

## bootstrap.shの設計

- **実行ユーザー**：sudoを実行できる一般ユーザー。
- **前提**：snapでchezmoiを導入し、このリポジトリをsourceにして`chezmoi apply`済みであること。
- **入口**：リポジトリ直下で`bash bootstrap.sh`を実行する。
- **担当する処理**：mitamaeの取得、レシピ実行、miseの再install、sheldon lock。
- **担当しない処理**：chezmoiのinstall / init / apply。日常更新用の`update.sh`は別途（未実装）。
- **再実行**：導入済みのツールを考慮して処理する。
- **SSH認証**：鍵の生成・GitHubへの登録は利用者が初回導入時に行い、bootstrap.shでは扱わない。

## 運用：設定の変更と更新

### 管理対象を追加する

1. 対象ファイルをchezmoiに登録する。以下はGit設定の例である。

   ```bash
   chezmoi add ~/.gitconfig
   ```

2. ソース側の差分を確認する。

   ```bash
   chezmoi cd
   git diff
   ```

3. 個人情報・認証情報を除き、個人差はテンプレートに切り出す。
4. Dockerで検証した後、変更をコミット・プッシュする。

### CLIを追加する

1. `home/dot_config/mise/config.toml`の`[tools]`へ版を追加する。
2. `chezmoi apply`のあと`bash bootstrap.sh`を再実行する。または`mise install`を実行する。

### aptパッケージを追加する

1. `mitamae/roles/apt.rb`へパッケージ名を追加する。
2. `bash bootstrap.sh`を再実行する。

### リモートの更新を適用する

- **直接利用の場合**：取得元のリポジトリを更新する。
- **フォークの場合**：配布元の変更を自分のフォークへ取り込んでから更新する。
- **ローカル変更がある場合**：コミットや競合解消など、Git側の整理を先に行う。

```bash
cd ~/dotfiles
git pull --ff-only
chezmoi apply --source="$PWD"
bash bootstrap.sh
```

- 更新後は新しいターミナルを開き、[導入結果を確認する](getting-started.md#導入結果を確認する)を確認する。

## 実装・検証状況

| 項目                   | 状態                                              |
| ---------------------- | ------------------------------------------------- |
| 導入手順               | 記載済み・未検証                                  |
| chezmoi（snap）        | 手順化済み（bootstrap外）                         |
| bootstrap.sh           | 実装済み（プロビジョニング専用）                  |
| mitamaeレシピ          | 実装済み（apt / Docker / mise / PATH / zsh）      |
| miseツール定義         | 実装済み（シェル・Git・ランタイム・herdr / hunk） |
| chezmoiシェル設定      | 実装済み（zsh / sheldon / starship / atuin）      |
| 共通アプリ設定         | 一部未実装（gitconfig、鍵運用など）               |
| update.sh              | 未実装（範囲外）                                  |
| Docker検証・自動化     | 手順更新済み。今回変更の再検証は未実施            |
| WSL／Ubuntu実機検証    | 未実施                                            |

## 今後の整備順序

1. **実環境・Dockerでの検証**：snap → apply → bootstrap の初回・再実行を確認する。
2. **共通設定の追加**：Git設定テンプレートなど、ホームに配布する設定を追加する。
3. **秘密情報の扱い**：age / sops の鍵配置と運用を定める。
4. **日常更新**：必要なら`update.sh`を追加する。

[セットアップ手順へ](getting-started.md)
