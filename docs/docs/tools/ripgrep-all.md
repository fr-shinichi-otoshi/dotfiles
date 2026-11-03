---
title: ripgrep-all
---

# ripgrep-all

PDFやOffice文書など、プレーンテキスト以外の中も検索するツールです。コマンド名は`rga`です。

## この環境での役割

- 通常のソース検索は[ripgrep](ripgrep.md)です。
- 文書ファイルの中を探すときにrgaを使います。
- PDFのテキスト化には`poppler-utils`、Office文書などには`pandoc`を使います。両方とも[補助パッケージ](support-packages.md)です。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`ripgrep-all`です。
- 確認コマンドは`rga --version`です。

## 設定

このリポジトリはrgaの設定ファイルを配布しません。

## 使い方

```bash
rga TODO ./docs
```

検索そのものの考え方はripgrepに近く、対象ファイルの種類が広いです。

## 関連

- [ripgrep](ripgrep.md)
- [補助パッケージ](support-packages.md)

## 参考資料

- [ripgrep-all](https://github.com/phiresky/ripgrep-all)
