---
title: Git
---

# Git

ソースコードのバージョン管理です。共通の振る舞いとエイリアスも配ります。

## この環境での役割

- `git`と`git-lfs`をaptで入れます。
- 名前とメールアドレスは`~/.config/chezmoi/chezmoi.toml`から`~/.gitconfig`へ展開します。
- 差分表示は[delta](delta.md)、編集は[Vim](vim.md)です。
- 署名と鍵の運用は未整備です。

## 導入

- 定義は`mitamae/roles/apt.rb`です。
- 版はUbuntuの提供版です。
- 確認コマンドは`git --version`と`git-lfs --version`です。
- クローンに使う`openssh-client`は、[セットアップ](../getting-started.md#gitとsshを入れる)で入れます。bootstrapの対象ではありません。

## 設定ファイル

- ソースは`home/dot_gitconfig.tmpl`です。配置先は`~/.gitconfig`です。
- グローバル除外は`home/dot_gitignore_global`です。配置先は`~/.gitignore_global`です。
- 除外対象は、OSのごみファイル、エディタの個人設定、`.env.local`、`.env.*.local`です。

## 共通の振る舞い

- 新規リポジトリの既定ブランチは`main`です。
- リポジトリ内の改行はLFです。チェックアウト時にCRLFへは変換しません。
- `pull`はマージです。
- 追跡先の無いブランチへの初回pushでは、upstreamを作ります。
- `fetch`は、消えたリモート追跡ブランチとタグを削除します。
- ブランチ一覧は、コミット日時の新しい順です。
- タグ一覧はバージョン順です。
- 新しいブランチは、upstreamのマージ先を自動で持ちます。
- rebaseではautoStash、autoSquash、updateRefsを有効にしています。
- コンフリクト表示はzdiff3です。
- 同じコンフリクト解消を再利用するrerereを有効にしています。
- 資格情報はメモリへ8時間キャッシュします。
- サブコマンドの打ち間違いでは、確認してから実行します。
- 非ASCIIのパスは、引用符で囲まず表示します。
- 行末空白と、タブ直前の空白を差分で知らせます。
- status用のキャッシュを有効にしています。
- 未追跡ファイルは個別に表示します。
- サブモジュールの要約も出します。

## エイリアス

| エイリアス  | 動作                                                             |
| ----------- | ---------------------------------------------------------------- |
| `st`        | `status`です。                                                   |
| `co`        | `checkout`です。                                                 |
| `br`        | `branch`です。                                                   |
| `ci`        | `commit`です。                                                   |
| `sw`        | `switch`です。                                                   |
| `rs`        | `restore`です。                                                  |
| `lg`        | 全ブランチを含む簡易グラフです。                                 |
| `ll`        | 現在の履歴の簡易グラフです。                                     |
| `last`      | 直前コミットの概要と変更統計です。                               |
| `diffc`     | ステージ済みの差分です。                                         |
| `unstage`   | ステージを取り消します。                                         |
| `amend`     | メッセージを変えずに、直前コミットへ足します。                   |
| `wip`       | 追跡済みの変更だけを、メッセージ`WIP`でコミットします。          |
| `fix`       | 短いstatusを表示します。                                         |
| `root`      | リポジトリのルートパスを表示します。                             |
| `aliases`   | 定義済みエイリアスを表示します。                                 |
| `stash-all` | 未追跡ファイルも含めて退避します。                               |
| `undo`      | 直前コミットを消し、変更はステージに残します。                   |
| `please`    | `--force-with-lease`でpushします。遠隔が進んでいると拒否します。 |
| `cleanup`   | マージ済みのローカルブランチを削除します。                       |

`cleanup`はカレントブランチと`main`、`master`、`develop`を残します。

## Git LFS

パッケージは入ります。フック登録は利用者が行います。

```bash
git lfs install
```

## 関連

- [delta](delta.md)
- [lazygit](lazygit.md)
- [lefthook](lefthook.md)
- [chezmoi](chezmoi.md)

## 参考資料

- [Git](https://git-scm.com/doc)
- [Git LFS](https://git-lfs.com/)
