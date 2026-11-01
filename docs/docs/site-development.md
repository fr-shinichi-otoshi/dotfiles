# ドキュメントサイトの開発・公開

やることの要約です。

1. ローカル表示：`cd docs` → `pnpm install --frozen-lockfile` → `pnpm start`
2. 文章とビルドの確認：`pnpm check` → `pnpm build`
3. 公開：GitHub PagesのSourceをGitHub Actionsにし、`main`へプッシュ（またはDocs CDを手動実行）します。

## 前提条件

- Node.js 24 LTSとpnpm 11.25.0。`node --version`と`pnpm --version`で確認します。
- ドキュメント整備者向けです。dotfiles利用者の初回セットアップには不要です。

## 構成

- **本文**：`docs/docs/`にMarkdownで記述します。
- **サイト設定**：`docs/`でDocusaurusを管理します。
- **README**：リポジトリの概要と詳細手順への入口に絞ります。

## ローカルで表示する

```bash
cd docs
pnpm install --frozen-lockfile
pnpm start
```

表示されたURLを開き、終了は`Ctrl+C`です。

## ビルドを確認する

```bash
pnpm build
pnpm serve
```

静的ファイルは`docs/build/`に出力されます。Markdownのリンク切れはビルドエラーになります。

## 文章・コード・書式を確認する

```bash
pnpm check
```

- ESLint、Stylelint、textlint、Prettierをまとめて実行します。
- 自動修正は`pnpm format`（CSSは`pnpm lint:css:fix`）。textlintの意味変更は手動で直します。
- 本文・見出し・箇条書きは「です・ます調」に統一します。
- 長い引数は`docs/scripts/`、実行順は`package.json`で管理します。キャッシュは`docs/.cache/`です。
- `prh.yml`変更後は`pnpm lint:text:full`で確認します。

## ページを追加する

1. `docs/docs/`にMarkdownを追加します。
2. `docs/sidebars.js`へ、拡張子を除いたファイル名を追加します。
3. `pnpm check`と`pnpm build`で確認します。

見出しに番号は付けず、説明は箇条書きを基本とします。リンクは相対パスです。

## GitHub Pagesへ公開する

1. **Settings → Pages**を開きます。
2. **Build and deployment → Source**を**GitHub Actions**にします。
3. `main`へプッシュするか、Actionsの**Docs CD**を手動実行します。
4. 成功後に公開URLを開きます。

- **Docs CI**：PRと`main`へのpushで`pnpm check`とビルド（公開なし）。
- **Docs CD**：`main`へのpushでPagesへ公開。
- `GITHUB_REPOSITORY`から所有者名とリポジトリ名を取り、URLとベースパスを設定します。

## 参考資料

- [Docusaurusの導入](https://docusaurus.io/docs/installation)
- [Docusaurusの公開](https://docusaurus.io/docs/deployment)
- [GitHub Pagesのカスタムワークフロー](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)
