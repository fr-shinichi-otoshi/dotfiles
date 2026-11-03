---
title: lefthook
---

# lefthook

Gitフックを定義ファイルから実行するツールです。

## この環境での役割

- 配布するのはlefthookのバイナリだけです。
- `lefthook.yml`は各プロジェクトが持ちます。dotfilesリポジトリには置いていません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`lefthook`です。
- 確認コマンドは`lefthook version`です。`--version`ではありません。

## 使い方

フックを有効にするプロジェクトで、一度実行します。

```bash
lefthook install
```

定義を変えたあとは、同じコマンドでフックを更新します。

## 関連

- [Git](git.md)
- [構成と方針](../architecture.md#各プロジェクトで管理するもの)

## 参考資料

- [Lefthook](https://lefthook.dev/)
