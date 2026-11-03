---
title: mitamae
---

# mitamae

マシンへパッケージやログインシェルを入れる構成管理ツールです。itamaeの単体バイナリ版です。

## この環境での役割

- aptパッケージ、Docker Engine、mise、bashrcのPATH、ログインシェルを入れます。
- ホームのドットファイルは扱いません。そちらは[chezmoi](chezmoi.md)です。
- 利用者は`scripts/bootstrap.sh`経由で実行します。

## 導入

- 導入手段はGitHub Releasesです。配置先は`~/.local/bin/mitamae`です。
- 版は`scripts/bootstrap.sh`の`MITAMAE_VERSION`です。現在の指定は`2.0.6`です。
- 同じ版が既にあるときは、再取得しません。
- 確認コマンドは`mitamae version`です。

## レシピ

入口は`mitamae/recipes/default.rb`です。次のロールを順に実行します。

1. `mitamae/roles/apt.rb`
2. `mitamae/roles/docker.rb`
3. `mitamae/roles/mise.rb`
4. `mitamae/roles/shell_path.rb`
5. `mitamae/roles/zsh.rb`

実行はsudo付きです。再実行しても、導入済みの処理はスキップします。

## 関連

- [セットアップ](../getting-started.md)
- [Docker Engine](docker.md)
- [mise](mise.md)
- [zsh](zsh.md)

## 参考資料

- [mitamae](https://github.com/itamae-kitchen/mitamae)
