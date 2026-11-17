---
title: OSV-Scanner
---

# OSV-Scanner

依存パッケージの既知の脆弱性を調べるツールです。コマンド名は`osv-scanner`です。

## この環境での役割

- ロックファイルなどから、更新を検討する依存関係を見つけます。
- 依存関係の更新そのものは、各プロジェクトの手順で行います。
- 専用の設定ファイルは配布しません。無視設定は各プロジェクトの`osv-scanner.toml`です。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`osv-scanner`です。
- 確認コマンドは`osv-scanner --version`です。

## 使い方

ディレクトリ以下のロックファイルを調べます。結果の取得には、外部のデータベースへの通信が必要です。

```bash
osv-scanner scan source -r .
```

- `-r`は、サブディレクトリも対象にします。
- `.gitignore`に合うパスは、既定では調べません。

## 参考資料

- [OSV-Scanner](https://google.github.io/osv-scanner/usage/scan-source)
