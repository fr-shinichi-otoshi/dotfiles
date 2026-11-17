---
title: Knip
---

# Knip

JavaScriptとTypeScriptで、未使用のファイル、export、依存関係を検出するツールです。コマンド名は`knip`です。

## この環境での役割

- リファクタリングのあと、不要になったコードや依存の候補を出します。
- 検出結果は候補です。削除の判断は各プロジェクトで行います。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。Node.jsのパッケージとして入れます。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`npm:knip`です。
- 確認コマンドは`knip --version`です。
- 実行には、同じ設定の[Node.js](node.md)を使います。

## 使い方

`package.json`があるディレクトリで実行します。

```bash
knip
```

設定ファイルがあるプロジェクトでは、その設定に従います。

## 関連

- [Node.js](node.md)

## 参考資料

- [Knip](https://knip.dev/)
