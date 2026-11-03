# dotfiles

WSL／Ubuntu向けのローカル開発環境を、chezmoi・mitamae・miseで管理・共有するリポジトリです。

- **対象**：開発メンバー
- **環境**：WSL 2上のUbuntu、またはLinuxのUbuntu。
- **共有するもの**：開発ツールの導入処理、シェル・Git・AI開発ツールの共通設定。

## やること

1. [セットアップ](docs/docs/getting-started.md)を上から実行します。
2. 導入後は[更新](docs/docs/update.md)です。
3. 止まったら[困ったとき](docs/docs/troubleshooting.md)を見ます。

入っているツールの役割は[導入するツール](docs/docs/tools/index.md)です。

導入の流れの概要は次のとおりです。

1. Ubuntuを準備します。
2. SSH鍵を作成し、公開鍵をGitHubに登録します。
3. SSH接続を確認し、配布元を自分のアカウントへフォークします。
4. 自分のフォークをクローンします。
5. 個人設定を作成します。
6. snapでchezmoiを導入し、設定を適用します。
7. `bash scripts/bootstrap.sh`を実行します。

## ドキュメント

- [はじめに](docs/docs/intro.md)
- [セットアップ](docs/docs/getting-started.md)
- [更新](docs/docs/update.md)
- [困ったとき](docs/docs/troubleshooting.md)
- [導入するツール](docs/docs/tools/index.md)
- [構成と方針](docs/docs/architecture.md)（整備者）
- [設定の変更手順](docs/docs/maintenance.md)（整備者）
- [Dockerでの検証](docs/docs/docker-validation.md)（整備者）
- [ドキュメントサイトの開発・公開](docs/docs/site-development.md)（整備者）

ドキュメントサイトは`docs/`に集約しています。レイヤ分担や実装状況は[構成と方針](docs/docs/architecture.md)を参照してください。

## サイトのローカル表示

```bash
cd docs
pnpm install --frozen-lockfile
pnpm start
```
