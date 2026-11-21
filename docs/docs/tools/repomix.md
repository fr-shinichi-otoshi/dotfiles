---
title: repomix
---

# repomix

リポジトリを、LLMへ渡す1ファイルにまとめるツールです。

## この環境での役割

- 外部のモデルや別のチャットへ、要約用のコンテキストを渡します。
- 秘密情報を出力に含めないでください。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。Node.jsのパッケージとして入れます。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`npm:repomix`です。
- 確認コマンドは`repomix --version`です。
- 実行には、同じ設定の[Node.js](node.md)を使います。

## 使い方

```bash
repomix --compress -o repomix-output.xml
```

範囲を絞るときは`--include`を付けます。

## 関連

- [Node.js](node.md)
- [Serena](serena.md)

## 参考資料

- [repomix](https://repomix.com/)
