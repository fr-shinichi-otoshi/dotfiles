---
title: jq
---

# jq

JSONを抽出、変換、集計するツールです。

## この環境での役割

- APIの応答や設定ファイルから、必要な項目だけ取り出します。
- 長いJSONを、そのまま読む量を減らします。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`jq`です。
- 確認コマンドは`jq --version`です。

## 使い方

```bash
jq '.dependencies' package.json
echo '{"name":"mise"}' | jq '.name'
```

- フィルタを省略すると、入力を整形して表示します。
- キーが無いときは、`null`を出して終了コード0です。存在確認には`-e`を付けます。

## 関連

- [yq](yq.md)

## 参考資料

- [jq](https://jqlang.org/manual/)
