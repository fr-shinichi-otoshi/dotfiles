---
title: ast-grep
---

# ast-grep

コードを、文字列ではなく構文の形で検索・置換するツールです。コマンド名は`ast-grep`です。

## この環境での役割

- 改行や空白が違っても、同じ関数呼び出しなどを探せます。
- 一致した箇所の一括置換にも使えます。
- テキスト検索は[ripgrep](ripgrep.md)です。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`ast-grep`です。
- 確認コマンドは`ast-grep --version`です。
- 古い別名`sg`は非推奨です。実行には`ast-grep`を使います。

## 使い方

検索だけなら、ファイルは変わりません。

```bash
ast-grep run --pattern 'console.log($A)' --lang ts
```

置換するときは`--rewrite`を付けます。

```bash
ast-grep run --pattern 'console.log($A)' --rewrite 'logger.info($A)' --lang ts
```

- `--lang`は、対象ファイルの言語です。
- `$A`のようなメタ変数が、構文上の一部分にマッチします。

## 関連

- [ripgrep](ripgrep.md)

## 参考資料

- [ast-grep](https://ast-grep.github.io/guide/introduction)
