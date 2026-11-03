---
title: Docker Engine
---

# Docker Engine

コンテナの実行環境です。ComposeとBuildxも一緒に入ります。

## この環境での役割

- 公式aptのstableからDocker Engineを入れます。
- 定義は`mitamae/roles/docker.rb`です。
- miseでは管理しません。
- 画面操作は[lazydocker](lazydocker.md)です。

## 導入

- 入るパッケージは`docker-ce`、`docker-ce-cli`、`containerd.io`、`docker-buildx-plugin`、`docker-compose-plugin`です。
- 導入処理は、公式が衝突とするパッケージを外してから入れます。
- 実行ユーザーを`docker`グループへ追加し、サービスを有効化します。
- 版はstableチャネルです。
- 確認コマンドは`docker --version`です。
- グループ追加の直後は、`newgrp docker`かログインし直しが要ります。確認手順は[導入結果を確認する](../getting-started.md#導入結果を確認する)です。
- WSLではsystemdを有効にします。無効なら[困ったとき](../troubleshooting.md#事前確認)を見ます。

## 使い方

```bash
docker version
docker compose version
sudo docker run --rm hello-world
```

Compose V2のコマンドは`docker compose`です。

## 設定

このリポジトリは`daemon.json`などの専用設定を配布しません。

zshの補完は[sheldon](sheldon.md)が生成します。

## 関連

- [lazydocker](lazydocker.md)
- [mitamae](mitamae.md)

## 参考資料

- [Docker Engine の Ubuntu への導入](https://docs.docker.com/engine/install/ubuntu/)
- [コンテナの実行](https://docs.docker.com/engine/containers/run/)
