---
title: Rust
---

# Rust

Rustのコンパイラとcargoです。コマンド名は`rustc`と`cargo`です。

## この環境での役割

- [tokei](tokei.md)をソースからビルドするために入れます。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`rust`です。値は`stable`です。
- 確認コマンドは`rustc --version`です。
- リンクにはaptの`build-essential`を使います。説明は[補助パッケージ](support-packages.md)です。

## 関連

- [tokei](tokei.md)
- [mise](mise.md)

## 参考資料

- [Rust](https://www.rust-lang.org/)
