---
title: Node.js
---

# Node.js

JavaScriptの実行環境です。npmは同じ配布物に含まれます。

## この環境での役割

- 共通のNode.jsをmiseで入れます。
- ドキュメントサイトはNode.js 24とpnpmを使います。pnpm自体はmiseの`[tools]`にはありません。導入は[ドキュメントサイトの開発・公開](../site-development.md)です。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`node`、指定値は`24`です。
- 24系の版が入ります。
- 確認コマンドは`node --version`です。
- 公式バイナリが要求する`libatomic1`は[補助パッケージ](support-packages.md)で入ります。

## プロジェクトごとの版

ディレクトリに`.node-version`か`.nvmrc`があると、その版を優先します。ファイルが複数あるときの優先順位はmiseに従います。有効化の説明は[mise](mise.md)です。

## 使い方

```bash
node --version
npm --version
```

プロジェクトの依存関係は、そのプロジェクトの手順で入れます。dotfilesはNode.js本体だけを共通化します。

## 関連

- [mise](mise.md)
- [補助パッケージ](support-packages.md)
- [uv](uv.md)

## 参考資料

- [Node.js](https://nodejs.org/)
