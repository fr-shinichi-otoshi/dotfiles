---
title: ShellCheck
---

# ShellCheck

Bashやshのスクリプトを静的に検査するツールです。コマンド名は`shellcheck`です。

## この環境での役割

- 引用符の不足や、変数展開の問題を見つけます。
- 整形は[shfmt](shfmt.md)です。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`shellcheck`です。
- 確認コマンドは`shellcheck --version`です。

## 使い方

```bash
shellcheck scripts/bootstrap.sh
```

指摘が無ければ、終了コード0で終わります。

## 関連

- [shfmt](shfmt.md)

## 参考資料

- [ShellCheck](https://github.com/koalaman/shellcheck)
