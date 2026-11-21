---
title: Serena
---

# Serena

LSPでシンボル単位の探索をするMCPサーバーです。コマンド名は`serena`です。

## この環境での役割

- 定義、参照、ファイルをまたぐ依存を、エージェントから調べます。
- このリポジトリは`~/.cursor/mcp.json`を配布しません。接続設定は各利用者のファイルへ足します。

## 導入

- 導入手段は`scripts/install-serena.sh`です。miseの[uv](uv.md)で`serena-agent`を入れます。
- 版は`scripts/install-serena.sh`の`SERENA_AGENT_VERSION`です。現在の指定は`2.1.0`です。
- `scripts/bootstrap.sh`と`scripts/update.sh`が、このスクリプトを呼びます。
- 確認コマンドは`serena --version`です。
- 初回だけ、`~/.serena/serena_config.yml`が無いときに`serena init -b LSP`を実行します。既存の設定は上書きしません。

## 使い方

`~/.cursor/mcp.json`の`mcpServers`に、次を足します。

```json
{
  "serena": {
    "command": "${userHome}/.local/bin/serena",
    "args": [
      "start-mcp-server",
      "--context",
      "ide",
      "--open-web-dashboard",
      "false"
    ]
  }
}
```

追加したあとはCursorを再起動します。

## 関連

- [uv](uv.md)
- [mise](mise.md)

## 参考資料

- [Serena](https://oraios.github.io/serena/)
- [Serenaのインストール](https://oraios.github.io/serena/02-usage/010_installation.html)
