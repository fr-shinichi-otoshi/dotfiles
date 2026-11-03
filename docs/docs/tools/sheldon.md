---
title: sheldon
---

# sheldon

zshプラグインの取得と読み込みを行うツールです。

## この環境での役割

- 補完、入力候補、構文の色分けをまとめて読みます。
- 導入済みCLIのzsh補完スクリプトも、ここで生成します。
- [fzf](fzf.md)本体のキーバインドはsheldonの外です。`~/.zshrc`の`fzf --zsh`が読みます。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`sheldon`です。
- 確認コマンドは`sheldon --version`です。
- bootstrapとupdateが`sheldon lock --update`を実行し、そのあとキャッシュを削除します。

## 設定ファイル

- 一覧のソースは`home/dot_config/sheldon/plugins.toml`です。配置先は`~/.config/sheldon/plugins.toml`です。
- 取得した版の記録は`~/.local/share/sheldon/plugins.lock`です。このファイルはリポジトリへ入れません。
- 展開結果のキャッシュは`~/.cache/sheldon/sheldon.zsh`です。
- キャッシュする理由は、起動を速くするためです。
- `plugins.toml`かlockが新しいときは、キャッシュを作り直します。

## 読み込み順

1. zsh-completionsは、追加の補完定義をfpathへ足します。コマンド自体は実行しません。
2. cli-completionsは、次のコマンドが入っているときだけ補完を生成します。生成先は`~/.local/share/zsh/site-functions`です。
3. `compinit -C`で補完を初期化します。毎回のダンプ検査は省きます。
4. zsh-autosuggestionsは、履歴から入力中の続きを提案します。受け入れるキーは右矢印です。
5. fzf-tabは、補完候補をfzfと同じ操作の一覧で選びます。
6. zsh-syntax-highlightingは、コマンド行へ色を付けます。構文に影響するプラグインの最後で読みます。

cli-completionsの対象は次のとおりです。

- chezmoi
- mise
- starship
- atuin
- sheldon
- rg
- docker
- sops
- lazygit
- terraform-docs

## 関連

- [zsh](zsh.md)
- [fzf](fzf.md)
- [導入後の更新](../update.md)

## 参考資料

- [sheldon](https://sheldon.cli.rs/)
