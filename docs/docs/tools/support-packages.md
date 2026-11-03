---
title: 補助パッケージ
---

# 補助パッケージ

他ツールの依存としてaptで入れるパッケージです。

## 導入

- 定義は`mitamae/roles/apt.rb`です。
- 版はUbuntuの提供版です。

## パッケージ

- `curl`はファイルの取得に使います。mise、mitamae、vim-plugの導入で使います。
- `ca-certificates`はHTTPSの証明書ストアです。
- `poppler-utils`はPDFをテキストにします。[ripgrep-all](ripgrep-all.md)が使います。
- `pandoc`は文書形式の変換です。ripgrep-allがOffice文書などに使います。
- `libatomic1`は共有ライブラリです。[Node.js](node.md)の公式バイナリが要求します。

## 関連

- [mitamae](mitamae.md)
- [ripgrep-all](ripgrep-all.md)
- [Node.js](node.md)
- [Vim](vim.md)
