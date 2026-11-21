---
title: cwebp
---

# cwebp

画像をWebPへ変換するツールです。

## この環境での役割

- JPEGやPNGを、Web向けのWebPにします。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。公式のlibwebpプレビルドを入れます。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`http:libwebp`です。
- 確認コマンドは`cwebp -version`です。

## 使い方

```bash
cwebp -q 80 input.png -o output.webp
```

`-q`は品質です。0から100の範囲で指定します。

## 関連

- [oxipng](oxipng.md)

## 参考資料

- [cwebp](https://developers.google.com/speed/webp/docs/cwebp)
- [libwebpのプレビルド](https://developers.google.com/speed/webp/docs/precompiled)
