---
title: tflint
---

# tflint

Terraformの定義を静的に検査するツールです。

## この環境での役割

- Terraformと一緒に入れます。
- ルールセットの中身は各プロジェクトが決めます。dotfilesは`.tflint.hcl`を配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`tflint`です。
- 確認コマンドは`tflint --version`です。

## 使い方

Terraformのディレクトリで実行します。

```bash
tflint --init
tflint
```

プラグイン方式のルールでは、先に`tflint --init`でプラグインを取ります。

## 関連

- [Terraform](terraform.md)
- [terraform-docs](terraform-docs.md)

## 参考資料

- [TFLint](https://github.com/terraform-linters/tflint)
