---
title: SOPS
---

# SOPS

YAMLやJSONなどの設定ファイルを、暗号化したまま保管するツールです。

## この環境での役割

- 秘密情報ファイルの暗号化に[age](age.md)と組み合わせて使います。
- `.sops.yaml`や鍵は配布していません。鍵の配置と運用は未整備です。
- 方針が決まるまでは、暗号化手順をこのリポジトリの標準としては置きません。詳細は[今後の整備順序](../architecture.md#今後の整備順序)です。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`sops`です。
- 確認コマンドは`sops --version`です。
- zshの補完は[sheldon](sheldon.md)が生成します。

## ツールの動き

- ファイルを暗号化するコマンドは`sops -e`です。
- 復号するコマンドは`sops -d`です。
- どの鍵を使うかは、運用が決まるまで置いてありません。

## 関連

- [age](age.md)

## 参考資料

- [SOPS](https://github.com/getsops/sops)
