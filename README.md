# dotfiles

WSL／Ubuntu向けのAI駆動開発環境を、chezmoi・mitamae・miseで管理・共有するリポジトリである。

- **対象**：開発メンバー
- **環境**：WSL 2上のUbuntu、またはLinuxのUbuntu。
- **共有するもの**：開発ツールの導入処理、シェル・Git・AI開発ツールの共通設定。

## 導入の流れ

1. Ubuntuを準備する。
2. SSH鍵を作成し、公開鍵をGitHubに登録する。
3. SSH接続を確認し、リポジトリをクローンする。
4. `echo`で個人設定を作成する。
5. snapでchezmoiを導入し、設定を適用する。
6. `bash bootstrap.sh`を実行する。

前提条件とコマンドは、[セットアップ手順](docs/docs/getting-started.md)を参照する。

## 役割分担

| 層 | 担当 |
| --- | --- |
| snap / chezmoi | chezmoi本体の導入とホーム設定の配布 |
| `bootstrap.sh` | mitamaeの取得とレシピ実行（プロビジョニング） |
| mitamae | aptパッケージ、mise導入、`mise install`、PATH配線 |
| mise | CLIの版管理（gh / sops / age） |

## ドキュメント

- [セットアップ手順](docs/docs/getting-started.md)：前提条件、初回導入、更新、困ったときの対処。
- [Dockerでの検証](docs/docs/docker-validation.md)：検証環境と確認項目。
- [管理・保守の方針](docs/docs/maintenance.md)：設定の構成、スクリプトの設計、整備計画。

ドキュメントサイトは`docs/`に集約し、本文は`docs/docs/`で管理する。GitHub Pagesで公開するためのワークフローを用意している。

## サイトのローカル表示

Node.js 24 LTSとpnpm 11.25.0を用意して実行する。

```bash
cd docs
pnpm install --frozen-lockfile
pnpm start
```

サイトの開発・公開方法は[ドキュメントサイトの開発・公開](docs/docs/site-development.md)を参照する。

## 現在の状態

- snapのchezmoi適用後にbootstrapでプロビジョニングする流れまで実装済みである。
- Git設定やage鍵などのアプリ設定の中身は未整備である。
- Docker・実環境での導入検証は未実施である。
- 詳細は[実装・検証状況](docs/docs/maintenance.md#実装検証状況)を参照する。
