---
title: hunk
---

# hunk

変更差分を読んでレビューする、ターミナルの画面です。

## この環境での役割

- 作業ツリー、コミット、プルリクエストの差分を見るときに使います。
- ページャとしてのGit差分は[delta](delta.md)、操作画面は[lazygit](lazygit.md)です。hunkはレビュー用です。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`hunk`です。
- 確認コマンドは`hunk --version`です。

## 使い方

Gitリポジトリの中で実行します。

```bash
hunk diff
hunk show
hunk log
hunk gh pr
```

- `hunk diff`は、未コミットの変更を開きます。未追跡ファイルも含みます。
- `hunk show`は、直前のコミットを開きます。
- `hunk log`は、履歴をたどります。
- `hunk gh pr`は、現在のブランチに対応するプルリクエストを開きます。`hunk gh`はhunkに含まれるGitHub連携です。
- 非公開リポジトリでは`GH_TOKEN`か`GITHUB_TOKEN`を設定します。

## 関連

- [Git](git.md)
- [GitHub CLI](gh.md)
- [delta](delta.md)
- [lazygit](lazygit.md)

## 参考資料

- [hunk](https://hunk.dev/)
