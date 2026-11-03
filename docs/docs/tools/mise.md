---
title: mise
---

# mise

CLIとランタイムの版を揃えるツールです。

## この環境での役割

- シェル系CLI、Git系CLI、Node.js、Terraform、herdr、hunkなどを同じ版で入れます。
- 版の正は`home/dot_config/mise/config.toml`です。適用後は`~/.config/mise/config.toml`です。
- chezmoiとDocker Engineはmiseでは管理しません。

## 導入

- 導入手段は公式インストーラです。処理は`mitamae/roles/mise.rb`にあります。
- 実行ファイルは`~/.local/bin/mise`です。
- 本体の版はインストーラが入れる版です。ピン留めしません。
- 確認コマンドは`mise --version`です。
- bootstrapはレシピのあと、もう一度`mise install`を実行します。

## シェルへの組み込み

- zshでは`~/.zshenv`が`mise activate zsh`を実行します。
- `.zshenv`は非対話シェルでも読むため、エディタのエージェントからもツールを呼べます。
- bashでは`~/.bashrc`が有効化します。追記は`mitamae/roles/shell_path.rb`です。

## プロジェクトごとの版

次のツールだけ、ディレクトリ移動で版ファイルに追従します。

- node：`.node-version`と`.nvmrc`
- terraform：`.terraform-version`

ファイルが複数あるときの優先順位は、miseの実装に従います。

## 使い方

```bash
mise install
mise ls
```

- `mise install`は、設定にあって未導入のツールを入れます。
- `mise ls`は、入っている版を表示します。
- 日常の版バンプは[導入後の更新](../update.md)が`mise upgrade --bump`で行います。
- `--bump`は`~/.config/mise/config.toml`を書き換えることがあります。共有する手順は[CLIの版を上げて共有する](../maintenance.md#cliの版を上げて共有する)です。

## 関連

- [導入するツール](index.md)
- [Node.js](node.md)
- [Terraform](terraform.md)

## 参考資料

- [mise](https://mise.jdx.dev/)
