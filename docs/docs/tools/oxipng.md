---
title: oxipng
---

# oxipng

PNGを可逆圧縮するツールです。画質は変えません。

## この環境での役割

- 画像アセットのファイルサイズを減らします。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`aqua:oxipng/oxipng`です。
- 確認コマンドは`oxipng --version`です。

## 使い方

```bash
oxipng image.png
```

上書きせず別ファイルへ出すときは`--out`を付けます。

## 関連

- [cwebp](cwebp.md)

## 参考資料

- [oxipng](https://github.com/oxipng/oxipng)
