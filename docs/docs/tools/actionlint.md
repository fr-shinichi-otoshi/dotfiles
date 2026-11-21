---
title: actionlint
---

# actionlint

GitHub Actionsのworkflowを静的に検査するツールです。

## この環境での役割

- workflowの追加や修正のあと、式やジョブ依存の誤りを確認します。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`aqua:rhysd/actionlint`です。
- 確認コマンドは`actionlint --version`です。

## 使い方

`.github/workflows`があるディレクトリで実行します。

```bash
actionlint
```

## 参考資料

- [actionlint](https://github.com/rhysd/actionlint)
