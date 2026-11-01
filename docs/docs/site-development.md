# ドキュメントサイトの開発・公開

## 構成

- **本文**：`docs/docs/`にMarkdownで記述します。
- **サイト設定**：`docs/`でDocusaurusを管理します。
- **テーマ**：標準テーマを使用し、日本語のドキュメント専用サイトとします。
- **README**：リポジトリの概要と詳細手順への入口に絞る。

## 前提条件

- Node.js 24 LTSを導入済みである必要があります。
- pnpm 11.25.0を利用できる必要があります。`node --version`と`pnpm --version`で確認します。
- 以下はドキュメントを整備する人向けの作業であり、dotfiles利用者の初回セットアップには不要です。

## ローカルで表示する

リポジトリのルートから実行します。

```bash
cd docs
pnpm install --frozen-lockfile
pnpm start
```

- 起動時に表示されたURLをブラウザで開きます。
- 終了するときはターミナルで`Ctrl+C`を押します。

## ビルドを確認する

`docs/`内で実行します。

```bash
pnpm build
pnpm serve
```

- 静的ファイルは`docs/build/`に出力される。
- Markdownのリンク切れはビルドエラーとして検出します。

## 文章・コード・書式を確認する

`docs/`内で実行します。

```bash
pnpm check
```

- **ESLint**：JavaScriptの設定ファイルを検査します。
- **Stylelint**：標準ルールでCSSを検査します。
- **textlint**：ドキュメント本文とルートのREADMEを検査します。文体、表記ゆれ、スペース、AI生成文に見られる表現を確認します。
- **Prettier**：設定ファイル、本文、README、公開ワークフローの書式を検査します。生成物とロックファイルは整形対象から除きます。
- `package.json`は`prettier-plugin-packagejson`の標準順で整形します。項目の順序と、スクリプト・依存パッケージの並び順も統一します。
- 依存パッケージは`pnpm install --frozen-lockfile`でまとめて導入します。各ツールのグローバルインストールは不要です。

書式を自動修正する場合は、以下を実行します。

```bash
pnpm format
```

- 個別に確認する場合は`pnpm lint:js`、`pnpm lint:css`、`pnpm lint:text`、`pnpm format:check`を使います。
- CSSを自動修正する場合は`pnpm lint:css:fix`を実行します。
- textlintの指摘は内容を確認して修正します。文の意味を変える修正は自動では行いません。

### コマンドの管理

- 長いコマンドの引数は`docs/scripts/`でツールごとに管理します。
- `package.json`には、各スクリプトの呼び出しとチェックの実行順を記述します。
- Node.jsから各ツールを起動するため、WindowsとUbuntuで同じコマンドを使用できます。
- `--fix`や`--no-cache`などの追加引数は、そのまま各ツールへ渡します。

### textlintのルール

- `preset-ja-technical-writing`：日本語の技術文書に使う基本ルールを適用します。本文・見出し・箇条書きは「です・ます調」に統一します。
- `preset-ai-writing`：機械的なリスト・強調・誇張表現を検査します。`ai-tech-writing-guideline`はエラーではなく改善提案として扱います。
- `preset-ja-spacing`：日本語と英数字・コード・リンク周辺のスペースを統一します。
- `prh`：`prh.yml`を使い、GitHub・Node.js・textlint・Docusaurusの表記ゆれを検出します。

### チェック結果のキャッシュ

- 各コマンドはキャッシュを有効にし、変更のないファイルの処理を省略します。
- 保存先は`docs/.cache/`配下に統一します。

```text
docs/.cache/
├── eslint/
├── stylelint/
├── textlint/
└── prettier/
```

- キャッシュはGit管理・コード検査・整形の対象から除外します。
- Prettierのチェックと自動整形は、同じキャッシュを利用します。
- `prh.yml`の辞書を変更した場合は、`pnpm lint:text:full`でキャッシュを使わずに確認します。

## ページを追加する

1. `docs/docs/`にMarkdownファイルを追加します。
2. `docs/sidebars.js`へ、拡張子を除いたファイル名を追加します。
3. `pnpm check`で文章・コード・書式を確認します。
4. `pnpm build`でリンクと表示用ファイルの生成を確認します。

- 既存ページへのリンクは`getting-started.md`のような相対パスで記述します。
- 見出しに番号は付けず、説明は箇条書きを基本とします。表は短い比較に限定します。

## GitHub Pagesへ公開する

1. GitHubでリポジトリの**Settings → Pages**を開きます。
2. **Build and deployment → Source**を**GitHub Actions**に設定します。
3. 変更を`main`へプッシュします。手動の場合はActionsの**Docs CD**から実行します。
4. ワークフローが成功した後、Pagesの公開URLを開きます。

- **Docs CI**（`.github/workflows/docs-ci.yml`）：プルリクエストと`main`へのpushで`pnpm check`とビルドを実行します。公開はしません。
- **Docs CD**（`.github/workflows/docs-cd.yml`）：`main`へのpushでビルドし、GitHub Pagesへ公開します。
- Actionsではpnpmストアをキャッシュします。Docs CIでは加えて`docs/.cache/`（ESLint/Stylelint/textlint/Prettier）もキャッシュします。
- GitHub Actionsでは`GITHUB_REPOSITORY`から所有者名とリポジトリ名を取得し、URLとベースパスを設定します。
- フォーク先でローカル表示の公開先設定を変える場合は、`docs/docusaurus.config.js`の既定値を変更するか、`GITHUB_REPOSITORY`を設定します。
- このプロジェクト作成時点では、Pagesの有効化・プッシュ・公開は実行していません。

## 参考資料

- [Docusaurusの導入](https://docusaurus.io/docs/installation)
- [Docusaurusの公開](https://docusaurus.io/docs/deployment)
- [GitHub Pagesのカスタムワークフロー](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)
