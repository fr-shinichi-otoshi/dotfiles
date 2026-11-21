---
title: difftastic
---

# difftastic

構文に基づいて差分を表示するツールです。コマンド名は`difft`です。

## この環境での役割

- 関数の移動や整形だけの差分を、行単位の差分と分けて見ます。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`aqua:Wilfred/difftastic`です。
- 確認コマンドは`difft --version`です。

## 使い方

```bash
difft file-a.rs file-b.rs
```

Gitの差分として使うときは、次のように実行します。

```bash
GIT_EXTERNAL_DIFF=difft git diff
```

## 関連

- [delta](delta.md)
- [Git](git.md)

## 参考資料

- [difftastic](https://difftastic.wilfred.me.uk/)
- [difftasticのリポジトリ](https://github.com/Wilfred/difftastic)
