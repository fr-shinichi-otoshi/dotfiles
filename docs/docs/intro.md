---
slug: /
title: はじめに
---

# ローカル開発環境をそろえる

- **目的**：開発環境の構築手順と共通設定を共有し、チームで同じ環境を使い始められるようにします。
- **対象**：開発メンバー。
- **環境**：WSL2上のUbuntu、またはLinuxのUbuntu。検証基準はUbuntu 24.04 LTSです。

## やること

1. [セットアップ](getting-started.md)を上から実行します。
2. 導入後の取り込みは[更新](update.md)です。
3. 止まったら[困ったとき](troubleshooting.md)を見ます。

chezmoiの仕組みは、初回導入時に理解する必要はありません。

## 現在の状態

snapのchezmoi適用後にbootstrapでプロビジョニングする流れと、Git共通設定（署名以外）まで利用できます。署名・鍵運用は未整備です。詳細は[実装・検証状況](architecture.md#実装検証状況)を参照してください。

## 整備を担当する人へ

1. [構成と方針](architecture.md)で全体を把握します。
2. 変更は[設定の変更手順](maintenance.md)に従い、[Dockerでの検証](docker-validation.md)で確認します。
3. ドキュメントサイトは[ドキュメントサイトの開発・公開](site-development.md)です。
