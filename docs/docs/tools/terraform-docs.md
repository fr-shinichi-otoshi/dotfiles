---
title: terraform-docs
---

# terraform-docs

Terraformモジュールから、入出力の説明文書を生成するツールです。

## この環境での役割

- モジュールのREADME用に、変数や出力の一覧を作ります。
- 生成結果の置き場所は各プロジェクトが決めます。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`terraform-docs`です。
- 確認コマンドは`terraform-docs --version`です。
- zshの補完は[sheldon](sheldon.md)が生成します。

## 使い方

モジュールのディレクトリで実行します。

```bash
terraform-docs markdown table .
```

`markdown table`は、Markdownの表として標準出力へ出します。

## 関連

- [Terraform](terraform.md)
- [tflint](tflint.md)

## 参考資料

- [terraform-docs](https://terraform-docs.io/)
