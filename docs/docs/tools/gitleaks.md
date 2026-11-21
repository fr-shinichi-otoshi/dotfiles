---
title: gitleaks
---

# gitleaks

作業ツリーやGitの履歴から、秘密情報の混入を検出するツールです。

## この環境での役割

- コミット前に、鍵やトークンがファイルへ入っていないか確認します。
- 依存関係の脆弱性は[OSV-Scanner](osv-scanner.md)が見ます。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`aqua:gitleaks/gitleaks`です。
- 確認コマンドは`gitleaks version`です。

## 使い方

```bash
gitleaks detect --no-banner
```

検出内容はチャットやログへ貼らないでください。

## 関連

- [OSV-Scanner](osv-scanner.md)
- [age](age.md)
- [SOPS](sops.md)

## 参考資料

- [gitleaks](https://github.com/gitleaks/gitleaks)
