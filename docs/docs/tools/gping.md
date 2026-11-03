---
title: gping
---

# gping

応答時間をグラフで見るpingです。

## この環境での役割

- 到達性の確認を、数値の羅列ではなくグラフで行います。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`gping`です。
- 確認コマンドは`gping --version`です。

## 使い方

```bash
gping example.com
gping example.com github.com
```

複数のホストを渡すと、応答時間を並べて表示します。

## 参考資料

- [gping](https://github.com/orf/gping)
