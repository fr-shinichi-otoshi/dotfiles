---
title: GitHub CLI
---

# GitHub CLI

GitHubのプルリクエストやIssueを操作するコマンドです。コマンド名は`gh`です。

## この環境での役割

- ブラウザなしで、GitHubを操作します。
- 認証情報はこのリポジトリへ入れません。
- SSHの公開鍵登録とは別に、`gh auth login`が要ります。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`gh`です。
- 確認コマンドは`gh --version`です。

## 設定

このリポジトリは`gh`の設定ファイルを配布しません。

## 使い方

```bash
gh auth login
gh pr status
gh pr create
```

非公開リポジトリのAPI操作には、ログイン済みのアカウントが必要です。

## 関連

- [Git](git.md)
- [hunk](hunk.md)

## 参考資料

- [GitHub CLI](https://cli.github.com/)
