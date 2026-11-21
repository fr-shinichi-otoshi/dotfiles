---
title: commitlint
---

# commitlint

コミットメッセージがConventional Commitsに沿っているか検査するツールです。

## この環境での役割

- コミットメッセージの形式を、コミット前に確認します。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。Node.jsのパッケージとして入れます。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`npm:@commitlint/cli`です。
- 確認コマンドは`commitlint --version`です。
- 実行には、同じ設定の[Node.js](node.md)を使います。Node.js 22.12以降が必要です。このリポジトリのNode.js 24で満たします。

## 使い方

プロジェクトに設定が無いときは、同梱の設定を使います。

```bash
echo 'feat: add login' | commitlint --default-config
```

lefthookなど、プロジェクト側のフックがあるときは、その設定に従います。

## 関連

- [Node.js](node.md)
- [lefthook](lefthook.md)

## 参考資料

- [commitlint](https://commitlint.js.org/)
