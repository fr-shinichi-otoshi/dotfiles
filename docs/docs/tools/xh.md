---
title: xh
---

# xh

HTTPリクエストを送るツールです。JSONの送受信に向いています。

## この環境での役割

- APIやローカルサーバへの疎通を、短いフラグで確認します。
- 専用の設定ファイルは配布しません。

## 導入

- 導入手段はmiseです。
- 版の指定ファイルは`home/dot_config/mise/config.toml`です。キー名は`aqua:ducaale/xh`です。
- 確認コマンドは`xh --version`です。

## 使い方

```bash
xh get https://httpbin.org/json
xh post :8080/api name=test
```

## 参考資料

- [xh](https://github.com/ducaale/xh)
