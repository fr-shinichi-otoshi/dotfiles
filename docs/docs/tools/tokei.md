---
title: tokei
---

# tokei

言語ごとのファイル数とコード行数を集計するツールです。

## この環境での役割

- 初めて見るリポジトリの規模と、主な言語を把握します。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。プレビルドが無いため、cargoでビルドします。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`cargo:tokei`です。
- 同じ設定の[Rust](rust.md)と、aptの`build-essential`が必要です。
- 確認コマンドは`tokei --version`です。

## 使い方

```bash
tokei
tokei src
```

## 関連

- [Rust](rust.md)
- [補助パッケージ](support-packages.md)

## 参考資料

- [tokei](https://github.com/XAMPPRocky/tokei)
