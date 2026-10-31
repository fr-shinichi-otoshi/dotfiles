# dotfiles

chezmoiを使い、WSL／Ubuntu向けのAI駆動開発環境を共有・再現するためのリポジトリである。

## 目的と利用の流れ

- **目的**：環境構築の説明や手作業を減らし、チームメンバーが共通の環境で開発を始められるようにする。
- **管理方法**：開発対象のプロジェクトから独立したdotfilesリポジトリに、共通設定と導入処理を集約する。
- **利用の流れ**：Ubuntuの準備 → dotfilesの取得 → 差分確認 → 設定の適用 → 動作確認。
- **整備の流れ**：管理対象の決定 → chezmoiへの登録 → Dockerでの検証 → WSL／Ubuntu実環境での検証。

## 現在の状態

| 項目                           | 状態                   |
| ------------------------------ | ---------------------- |
| 導入・運用・検証手順           | 本READMEに手順案を記載 |
| chezmoiの管理対象・除外設定    | 未整備                 |
| 個人設定用テンプレート         | 未実装                 |
| 開発ツールの導入スクリプト     | 未実装                 |
| Dockerによる動作確認・自動検証 | 未実施・未実装         |
| WSL／Ubuntu実環境での動作確認  | 未実施                 |

- **利用開始の条件**：管理対象と除外設定を整備し、Dockerでの検証を完了すること。
- **現時点の位置付け**：以下は実装・検証を進めるための手順案であり、環境構築の完了を保証するものではない。

## 管理方針

### 対象環境

| 環境                   | 用途                     | 検証方針                               |
| ---------------------- | ------------------------ | -------------------------------------- |
| WSL 2上のUbuntu        | Windows利用者の開発環境  | Ubuntu 24.04 LTSを基準に確認           |
| LinuxのUbuntu          | Linux利用者の開発環境    | Ubuntu 24.04 LTSを基準に確認           |
| UbuntuのDockerコンテナ | 導入処理・設定の検証環境 | `ubuntu:24.04`で初回適用と再適用を確認 |

### 設定の管理場所

| 分類                   | 管理場所           | 例                                                |
| ---------------------- | ------------------ | ------------------------------------------------- |
| 共通の開発設定         | このリポジトリ     | シェル、Git、AI開発ツールの共通設定・指示・スキル |
| ツールの導入処理       | このリポジトリ     | パッケージの導入、バージョン指定                  |
| プロジェクト用のひな形 | このリポジトリ     | 必要に応じて各プロジェクトへコピーする設定        |
| プロジェクト固有の設定 | 各プロジェクト     | 依存関係、ビルド手順、プロジェクト固有のAI指示    |
| 個人設定               | 各自のローカル設定 | Gitの名前・メールアドレス、環境ごとの値           |
| 認証情報               | 各自の認証管理先   | APIキー、アクセストークン、SSH秘密鍵              |

- 個人差のある設定は、chezmoiのテンプレートで共通部分と分離する。
- 認証情報はリポジトリにコミットしない。
- 導入するツールとバージョンは、選定後に一覧を追加する。

### chezmoiとプロジェクトの関係

- chezmoiが`home/`配下のソースから設定ファイルを生成し、ホームディレクトリへ配置する。
- 各プロジェクトは、ホームに配置された共通設定を利用する。
- プロジェクト用のひな形は、必要なプロジェクトへ明示的にコピーする。

```text
~/.local/share/chezmoi/   # このリポジトリの標準配置先
~/.config/chezmoi/        # マシン固有のchezmoi設定
~/.config/               # ツールが利用する設定の配置先の例
~/develop/              # 各プロジェクトの配置先の例
```

### リポジトリ構成案

以下は今後追加するファイルの構成案である。

```text
dotfiles/
├── README.md
├── .chezmoiroot          # 内容をhomeとし、管理対象のルートを指定
├── home/                # ホームディレクトリへ適用するソース
│   ├── .chezmoiignore         # home/内で適用から除外するファイル
│   ├── .chezmoi.toml.tmpl     # 個人設定の入力・生成
│   ├── dot_gitconfig.tmpl    # ~/.gitconfigのテンプレート
│   ├── dot_config/           # ~/.config配下に配置する設定
│   └── run_once_before_*.sh  # 初回の設定適用前に実行する導入処理
├── docs/                 # 詳細な手順
└── templates/            # プロジェクト用のひな形
```

- **読み込み先**：リポジトリ直下の`.chezmoiroot`に`home`を記載し、`home/`を管理対象のルートにする。
- **配置の対応**：`home/dot_gitconfig.tmpl`は`~/.gitconfig`、`home/dot_config/`は`~/.config/`に対応する。
- **開発用ファイル**：README、`docs/`、`templates/`は`home/`の外に置き、ホームへの配置対象から分離する。
- **除外設定**：`home/`内に配置しないファイルがある場合は、`home/.chezmoiignore`に記載する。
- **既存ファイルの扱い**：`.agent/`、`.cursor/`、`CLAUDE.md`は、リポジトリ開発用ならルートに残し、配布する設定のみchezmoiの命名規則に従って`home/`配下へ追加する。

## 利用者向け：Ubuntuへの導入

### 前提条件

- 「現在の状態」に記載した利用開始の条件を満たしていること。
- sudoを実行できる一般ユーザーで作業すること。
- パッケージ配布先とGitHubへネットワーク接続できること。
- 既存の設定がある場合は、適用前に対象ファイルをバックアップすること。
- 非公開リポジトリを利用する場合は、Gitの認証を設定しておくこと。

### Ubuntuを準備する

**Windowsの場合**

1. 管理者権限のPowerShellでUbuntuを導入する。

   ```powershell
   wsl --install -d Ubuntu-24.04
   ```

2. 必要に応じてWindowsを再起動する。
3. Ubuntuを起動し、Linuxのユーザー名とパスワードを設定する。
4. `wsl --list --verbose`で、対象のUbuntuがWSL 2で動作していることを確認する。

**LinuxのUbuntuの場合**

- Ubuntuにログインし、ターミナルを開く。

以降は、いずれの場合もUbuntuのターミナルで実行する。

### chezmoiを導入する

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl git

sh -c "$(curl -fsLS https://get.chezmoi.io)" -- -b "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

chezmoi --version
```

- **確認結果**：chezmoiのバージョンが表示されること。
- **PATHの扱い**：この`export`は現在のシェルにのみ有効である。新しいシェルでも利用できるよう、配布するシェル設定に`~/.local/bin`のPATH設定を含める。

### dotfilesを取得する

| 利用方法               | 指定するリポジトリ                       |
| ---------------------- | ---------------------------------------- |
| 自分用の変更を管理する | 自分のアカウントへフォークしたリポジトリ |
| 配布元の設定を利用する | 配布元のリポジトリ                       |

- `YOUR_GITHUB_USERNAME`を、取得対象のリポジトリの所有者名に置き換える。
- `chezmoi init`がクローンするため、事前の`git clone`は不要である。

```bash
chezmoi init https://github.com/YOUR_GITHUB_USERNAME/dotfiles.git
```

### 内容を確認して適用する

1. 設定ファイルの差分と、実行予定の処理を確認する。

   ```bash
   chezmoi diff
   chezmoi apply --dry-run --verbose
   ```

2. 導入スクリプトのソースも確認し、意図した処理であることを確かめる。
3. 設定を適用する。ツール導入時にsudoのパスワードを求める場合がある。

   ```bash
   chezmoi apply --verbose
   ```

4. 新しいターミナルで、ツールの起動と設定を確認する。

   ```bash
   chezmoi --version
   git --version
   chezmoi diff
   ```

- **完了条件**：必要なツールが起動し、個人設定が反映され、意図しない差分が残らないこと。
- **追加する確認**：導入ツールの選定後、ツールごとの確認コマンドを追記する。

## 整備者向け：Dockerでの検証

### 検証の対象と前提

- **目的**：ホストのホーム設定を変更せず、初回構築と再適用を確認する。
- **対象**：ローカルのdotfilesリポジトリ。未コミット・未プッシュの変更も含む。
- **前提**：Dockerが起動済みであり、`docker version`でサーバーへ接続できること。
- **適用前の準備**：管理対象、除外設定、必要な個人設定を整えること。
- **手順の位置付け**：以下の手動検証手順は未実行である。Dockerfileと自動検証は今後追加する。

### 検証用コンテナにローカルのソースを渡す

ホスト側でdotfilesリポジトリのルートに移動し、以下を実行する。PowerShellでも実行できる。

```bash
docker run --rm -dit --name dotfiles-check ubuntu:24.04 bash
docker cp . dotfiles-check:/tmp/dotfiles
docker exec -it dotfiles-check bash
```

- **コピー対象**：現在のディレクトリ全体。コピー前に認証情報などを置いていないことを確認する。
- **検証対象の更新**：コピー後のホスト側の変更は自動反映されない。再検証時は新しいコンテナへコピーする。
- **ホストとの接続**：ホームディレクトリとDockerソケットはマウントしない。

### 一般ユーザーの検証環境を作る

コンテナ内のrootとして実行する。

```bash
apt-get update
apt-get install -y ca-certificates curl git sudo
useradd --create-home --shell /bin/bash --groups sudo developer
passwd developer

mkdir -p /home/developer/.local/share/chezmoi
cp -a /tmp/dotfiles/. /home/developer/.local/share/chezmoi/
chown -R developer:developer /home/developer
su - developer
```

- `passwd`で検証用パスワードを設定する。以降のsudoでも同じパスワードを使う。
- `su - developer`以降は一般ユーザーとして作業する。

### ローカルのソースを初期化・適用する

1. 「chezmoiを導入する」をコンテナ内で実行する。
2. コピー済みの標準ソースディレクトリを初期化する。リモートのURLは指定しない。

   ```bash
   chezmoi init
   ```

3. 「内容を確認して適用する」を実行する。
4. 初回適用後、再適用と新しいシェルでの起動を確認する。

   ```bash
   chezmoi apply --verbose
   chezmoi diff
   bash -lic 'command -v chezmoi; git --version'
   ```

### 合格条件

- [ ] 初回の導入・設定適用が一般ユーザーで完了する。
- [ ] 管理対象だけが意図した場所に配置される。
- [ ] 入力した個人設定が反映される。
- [ ] 新しいシェルからツールを起動できる。
- [ ] 再適用で設定の重複・破損・不要な再インストールが発生しない。
- [ ] 適用後の`chezmoi diff`に意図しない差分が残らない。
- [ ] 新しいコンテナでも同じ手順で初回構築を再現できる。

### 終了・再検証

1. `exit`で一般ユーザーのシェルを抜け、もう一度`exit`で`docker exec`を終了する。
2. ホスト側でコンテナを停止する。`--rm`によりコンテナ内の設定も削除される。

   ```bash
   docker stop dotfiles-check
   ```

3. 初回構築を再検証する場合は、「検証用コンテナにローカルのソースを渡す」から新しいコンテナでやり直す。

### 実環境で別途確認する項目

| 項目                             | 確認先                           |
| -------------------------------- | -------------------------------- |
| WSLの導入・起動、Windowsとの連携 | WSL 2上のUbuntu                  |
| GUIツール、デスクトップとの連携  | 利用対象の実環境                 |
| systemdを前提とするサービス      | 利用対象の実環境                 |
| AI開発ツールの認証・実際の利用   | 各自のアカウントを設定した実環境 |

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

### リモートの更新を適用する

- **直接利用の場合**：取得元のリポジトリを更新する。
- **フォークの場合**：配布元の変更を自分のフォークへ取り込んでから更新する。
- **ローカル変更がある場合**：コミットや競合解消など、Git側の整理を先に行う。

```bash
chezmoi git pull --ff-only
chezmoi diff
chezmoi apply --dry-run --verbose
```

差分と実行予定の処理を確認してから適用する。

```bash
chezmoi apply --verbose
```

## 今後の整備順序

1. **管理対象の確定**：ツール・バージョン・共通設定・個人設定を一覧化する。
2. **配置対象の整理**：`.chezmoiroot`に`home`を指定し、配布用ファイルを`home/`へ集約する。必要に応じて`home/.chezmoiignore`を追加する。
3. **設定の実装**：個人設定のテンプレートと、シェル・Git・AI開発ツールの共通設定を追加する。
4. **導入処理の実装**：Ubuntu向けスクリプトを追加し、再実行時の動作を整える。
5. **Dockerでの検証**：本READMEの手順を実行し、確認できた手順をDockerfile・自動検証へ移す。
6. **実環境での確認**：WSL／Ubuntuで残りの項目を検証し、利用者向け手順を確定する。

## 参考資料

- [chezmoiのインストール](https://www.chezmoi.io/install/)
- [chezmoiのセットアップ](https://www.chezmoi.io/user-guide/setup/)
- [chezmoiの除外設定](https://www.chezmoi.io/reference/special-files/chezmoiignore/)
- [chezmoiの管理対象ルートの指定](https://www.chezmoi.io/reference/special-files/chezmoiroot/)
- [MicrosoftのWSL導入手順](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Dockerのコンテナ実行](https://docs.docker.com/engine/containers/run/)
