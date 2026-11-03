---
title: lazygit
---

# lazygit

Gitのstatus、stage、commit、pushを画面で行うツールです。

## この環境での役割

- リポジトリ直下で起動する、日常のGit操作画面です。
- 差分のページャ自体は[delta](delta.md)です。lazygitの表示設定は上書きしません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`lazygit`です。
- 確認コマンドは`lazygit --version`です。
- zshの補完は[sheldon](sheldon.md)が生成します。

## 設定

このリポジトリは`~/.config/lazygit/config.yml`を配布しません。

## 使い方

```bash
lazygit
```

Gitリポジトリの中で実行します。

## 関連

- [Git](git.md)
- [delta](delta.md)
- [hunk](hunk.md)

## 参考資料

- [lazygit](https://github.com/jesseduffield/lazygit)
