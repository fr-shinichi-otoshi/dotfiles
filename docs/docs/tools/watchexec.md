---
title: watchexec
---

# watchexec

ファイルの変更を監視し、コマンドを再実行するツールです。

## この環境での役割

- 保存のたびにテストやlintを走らせます。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`aqua:watchexec/watchexec`です。
- 確認コマンドは`watchexec --version`です。

## 使い方

```bash
watchexec --exts rs -- cargo test
```

常駐するプロセスです。確認が終わったら止めます。

## 参考資料

- [watchexec](https://github.com/watchexec/watchexec)
