---
title: shfmt
---

# shfmt

シェルスクリプトのインデントなどを揃えるツールです。

## この環境での役割

- 整形を手作業で揃える手間を省きます。
- 静的検査は[ShellCheck](shellcheck.md)です。
- 専用の設定ファイルは配布しません。プロジェクトの`.editorconfig`があれば、それに従います。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`shfmt`です。
- 確認コマンドは`shfmt --version`です。

## 使い方

差分だけ見るときは`-d`です。ファイルは変わりません。

```bash
shfmt -d scripts/bootstrap.sh
```

書き戻すときは`-w`です。

```bash
shfmt -w scripts/bootstrap.sh
```

## 関連

- [ShellCheck](shellcheck.md)

## 参考資料

- [shfmt](https://github.com/mvdan/sh)
