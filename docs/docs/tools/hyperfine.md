---
title: hyperfine
---

# hyperfine

コマンドの実行時間を、繰り返し測るツールです。

## この環境での役割

- 高速化の前後で同じ処理を測り、差を数値で見ます。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`hyperfine`です。
- 確認コマンドは`hyperfine --version`です。

## 使い方

```bash
hyperfine --warmup 3 'rg TODO src'
```

- `--warmup`は、計測の前に同じコマンドを実行し、初回の遅延を外します。
- 計測するコマンドに、ファイルの変更や外部への送信を含めないでください。

## 参考資料

- [hyperfine](https://github.com/sharkdp/hyperfine)
