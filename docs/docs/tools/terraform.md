---
title: Terraform
---

# Terraform

インフラの定義ファイルを実行するツールです。

## この環境での役割

- 共通のTerraform 1系をmiseで入れます。
- 検査は[tflint](tflint.md)、モジュールの文書化は[terraform-docs](terraform-docs.md)です。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`terraform`、指定値は`1`です。
- 確認コマンドは`terraform version`です。`--version`ではありません。

## プロジェクトごとの版

`.terraform-version`があると、その版を優先します。有効化の説明は[mise](mise.md)です。

## 使い方

作業ディレクトリで、そのプロジェクトの手順に従います。

```bash
terraform fmt
terraform init
terraform plan
```

状態ファイルやクラウドの認証情報は、各プロジェクトと各自の認証管理で扱います。このリポジトリへは入れません。

## 関連

- [tflint](tflint.md)
- [terraform-docs](terraform-docs.md)
- [mise](mise.md)

## 参考資料

- [Terraform](https://developer.hashicorp.com/terraform/docs)
