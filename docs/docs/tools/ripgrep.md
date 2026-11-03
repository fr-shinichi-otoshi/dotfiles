---
title: ripgrep
---

# ripgrep

ディレクトリ以下のテキストを高速に検索するツールです。コマンド名は`rg`です。

## この環境での役割

- ソースコード検索の標準コマンドです。
- PDFやOffice文書の中は[ripgrep-all](ripgrep-all.md)が担当します。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`ripgrep`です。
- 確認コマンドは`rg --version`です。
- zshの補完は[sheldon](sheldon.md)が`rg --generate=complete-zsh`で作ります。

## 使い方

```bash
rg TODO
rg -n 'func ' ./scripts
```

- 既定で`.gitignore`に合うパスを除外します。
- 隠しファイルも、無視ルールに含まれるときは除外します。
- `-uu`で無視ルールと隠しファイルの両方を検索対象にできます。

## 関連

- [ripgrep-all](ripgrep-all.md)
- [fd](fd.md)

## 参考資料

- [ripgrep](https://github.com/BurntSushi/ripgrep)
