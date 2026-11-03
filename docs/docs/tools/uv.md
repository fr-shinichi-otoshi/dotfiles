---
title: uv
---

# uv

Pythonの処理系、仮想環境、パッケージを扱うツールです。

## この環境での役割

- 配布しているのはuvコマンドです。
- Python本体を入れるときはuvを使います。miseの`[tools]`にPythonはありません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`uv`です。
- 確認コマンドは`uv --version`です。

## 設定

このリポジトリはuvの設定ファイルを配布しません。Pythonの版はプロジェクトごとに選びます。

## 使い方

```bash
uv python install 3.13
uv init
uv add requests
uv run pytest
```

- `uv python install`は、指定したPythonをユーザー領域へ入れます。
- `uv init`は、プロジェクトを作ります。
- `uv add`は、依存パッケージを追加します。
- `uv run`は、プロジェクトの環境でコマンドを実行します。

## 関連

- [mise](mise.md)
- [Node.js](node.md)

## 参考資料

- [uv](https://docs.astral.sh/uv/)
