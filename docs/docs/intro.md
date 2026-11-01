---
slug: /
title: はじめに
---

# ローカル開発環境をそろえる

- **目的**：開発環境の構築手順と共通設定を共有し、チームで同じ環境を使い始められるようにします。
- **対象**：新卒やLinuxでの開発経験がないチームメンバー。
- **環境**：WSL2上のUbuntu、またはLinuxのUbuntu。検証基準はUbuntu 24.04 LTSです。

## まず読むページ

- [セットアップ手順](getting-started.md)：前提条件の確認から、SSH認証、クローン、chezmoi適用、`scripts/bootstrap.sh`の実行までを扱います。
- コマンドは上から順に実行します。chezmoiの仕組みは、初回導入時に理解する必要はありません。

## 現在の状態

- snapのchezmoi適用後にbootstrapでプロビジョニングする流れまで実装済みです。
- Git共通設定（署名以外）は実装済みです。署名・鍵運用は未整備です。
- 整備者の検証はDockerのみとします（実機検証は対象外）。詳細は[実装・検証状況](maintenance.md#実装検証状況)を参照してください。

## 整備を担当する人へ

- [Dockerでの検証](docker-validation.md)
- [管理・保守の方針](maintenance.md)
- [ドキュメントサイトの開発・公開](site-development.md)
