---
title: yq
---

# yq

YAMLなどの構造化データを、キーを指定して参照・更新するツールです。導入するのはMike Farah版です。

## この環境での役割

- GitHub ActionsやComposeなどの設定を、パスで読み書きします。
- Python製のyqは入れません。コマンド名が同じ別ツールです。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`yq`です。
- 確認コマンドは`yq --version`です。

## 使い方

```bash
yq '.services.web.image' compose.yaml
yq '.jobs' .github/workflows/docs-ci.yml
```

- 式の書き方は[jq](jq.md)に近いです。
- ファイルを書き換えるときは`-i`を付けます。付けないときは標準出力へ出します。

## 関連

- [jq](jq.md)

## 参考資料

- [yq](https://github.com/mikefarah/yq)
