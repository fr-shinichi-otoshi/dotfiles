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
2. `chezmoi apply`のあと`bash scripts/bootstrap.sh`を再実行します。または`mise install`を実行します。

## aptパッケージを追加する

1. `mitamae/roles/apt.rb`へパッケージ名を追加します。
2. `bash scripts/bootstrap.sh`を再実行します。

## リモートの更新を適用する

利用者向けの更新手順は[導入後の更新](update.md)です。フォークへ配布元を取り込み、`git pull`のあと`chezmoi apply`と`bootstrap.sh`を実行します。ローカル変更がある場合は、コミットや競合解消を先に行います。更新後は[導入結果を確認する](getting-started.md#導入結果を確認する)を確認します。
