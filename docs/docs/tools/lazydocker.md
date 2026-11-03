---
title: lazydocker
---

# lazydocker

コンテナ、イメージ、ボリュームを画面で見るツールです。

## この環境での役割

- [Docker Engine](docker.md)の状態確認に使います。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`lazydocker`です。
- 確認コマンドは`lazydocker --version`です。
- Dockerのグループ追加が未反映のシェルでは起動に失敗します。`newgrp docker`かログインし直しのあとで実行します。

## 使い方

```bash
lazydocker
```

Dockerデーモンへ接続できるユーザーで実行します。

## 関連

- [Docker Engine](docker.md)

## 参考資料

- [lazydocker](https://github.com/jesseduffield/lazydocker)
