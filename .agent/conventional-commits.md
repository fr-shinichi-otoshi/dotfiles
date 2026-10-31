# Conventional Commits

仕様: [Conventional Commits 1.0.0](https://www.conventionalcommits.org/ja/v1.0.0/)

コミットメッセージは次の形式に従うこと。

```
<type>[optional scope][!]: <description>

[optional body]

[optional footer(s)]
```

## ルール

- `type` は必須。新しい機能は `feat`、バグ修正は `fix` を使う。
- 推奨 type: `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
- `scope` は任意。括弧内の名詞（例: `feat(chezmoi):`）
- `type` / `scope` の直後に `!` を付けるか、フッターに `BREAKING CHANGE:` を書くと破壊的変更
- `:` の直後は半角スペース必須
- `description` と body は**日本語**。`type` / `scope` / `BREAKING CHANGE` などキーワードは英語
- `description` は変更内容の短い要約。末尾に句点（。）. を付けない
- body / footer を書く場合は、タイトルとのあいだに空行を1行入れる
- 複数 type にまたがる変更は、可能な限りコミットを分割する

## 例

```
feat(agent): Conventional Commits ルールを追加
```

```
fix(chezmoi): .chezmoiignore の除外パターン誤りを修正
```

```
feat(chezmoi)!: home 配下を管理対象ルートに変更する

BREAKING CHANGE: .chezmoiroot を追加し、既存の適用パスが home/ 基準になる
```

```
docs: README に導入・検証の手順案を追記
```

## 避ける例

```
# type なし
Conventional Commits ルールを追加

# 英語 description（このリポジトリでは日本語にする）
feat(agent): add conventional commits rules

# 末尾句点
feat(agent): Conventional Commits ルールを追加。
```
