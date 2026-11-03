# 設定の変更手順

設定やツールを足したあとは、必ず[Dockerでの検証](docker-validation.md)を実行します。構成の説明は[構成と方針](architecture.md)を参照してください。

## 管理対象を追加する

1. 対象ファイルをchezmoiに登録します。以下はGit設定の例です。

   ```bash
   chezmoi add ~/.gitconfig
   ```

2. ソース側の差分を確認します。

   ```bash
   chezmoi cd
   git diff
   ```

3. 個人情報・認証情報を除き、個人差はテンプレートに切り出します。
4. Dockerで検証した後、変更をコミット・プッシュします。

## CLIを追加する

1. `home/dot_config/mise/config.toml`の`[tools]`へ版を追加します。
2. `docs/docs/tools/`に説明ページを追加します。
3. `docs/sidebars.ts`と[導入するツール](tools/index.md)へ項目を追加します。
4. `chezmoi apply`のあと`bash scripts/bootstrap.sh`を再実行します。または`mise install`を実行します。

## CLIの版を上げて共有する

1. `bash scripts/update.sh`でローカルの`~/.config/mise/config.toml`を版バンプします。
2. 共有する版をソースへ戻します。

   ```bash
   chezmoi add ~/.config/mise/config.toml
   ```

3. 差分を確認し、[Dockerでの検証](docker-validation.md)のあとコミット・プッシュします。

## aptパッケージを追加する

1. `mitamae/roles/apt.rb`へパッケージ名を追加します。
2. 利用者が直接使うツールなら、説明ページも追加します。手順は[CLIを追加する](#cliを追加する)の2と3です。
3. `bash scripts/bootstrap.sh`を再実行します。

## リモートの更新を適用する

利用者向けの更新手順は[導入後の更新](update.md)です。日常のapt/mise/sheldon更新は`scripts/update.sh`、配布元の取り込みは`git pull`のあと`chezmoi apply`と`bootstrap.sh`です。ローカル変更がある場合は、コミットや競合解消を先に行います。更新後は[導入結果を確認する](getting-started.md#導入結果を確認する)を確認します。
