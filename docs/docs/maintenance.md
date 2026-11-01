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

- **直接利用の場合**：取得元のリポジトリを更新します。
- **フォークの場合**：配布元の変更を自分のフォークへ取り込んでから更新します。
- **ローカル変更がある場合**：コミットや競合解消など、Git側の整理を先に行います。

```bash
cd ~/dotfiles
git pull --ff-only
chezmoi apply --source="$PWD"
bash scripts/bootstrap.sh
```

更新後は新しいターミナルを開き、[導入結果を確認する](getting-started.md#導入結果を確認する)を確認します。利用者向けの更新手順は[導入後の更新](update.md)です。
