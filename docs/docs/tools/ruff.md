---
title: Ruff
---

# Ruff

Pythonを検査し、整形するツールです。コマンド名は`ruff`です。

## この環境での役割

- 問題の検出、未使用importの整理、書式の統一に使います。
- ルールの中身は各プロジェクトが決めます。dotfilesは`ruff.toml`を配布しません。
- Python環境そのものは[uv](uv.md)です。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`ruff`です。
- 確認コマンドは`ruff --version`です。

## 使い方

検査と、整形差分の確認です。どちらもファイルを書き換えません。

```bash
ruff check .
ruff format --check .
```

書き戻すときは、次です。

```bash
ruff check --fix .
ruff format .
```

## 関連

- [uv](uv.md)

## 参考資料

- [Ruff](https://docs.astral.sh/ruff/)
