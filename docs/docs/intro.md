---
slug: /
title: はじめに
---

# AI駆動開発の環境をそろえる

- **目的**：開発環境の構築手順と共通設定を共有し、チームで同じ環境を使い始められるようにする。
- **対象**：新卒やLinuxでの開発経験がないチームメンバー。
- **環境**：WSL 2上のUbuntu、またはLinuxのUbuntu。検証基準はUbuntu 24.04 LTSである。

## まず読むページ

- [セットアップ手順](getting-started.md)：前提条件の確認から、SSH認証、クローン、個人設定、bootstrap.shの実行までを扱う。
- コマンドは上から順に実行する。chezmoiの仕組みは、初回導入時に理解する必要はない。

## 現在の状態

- bootstrap.shと共通設定は未実装であり、セットアップはまだ完了できない。
- 詳細は[実装・検証状況](maintenance.md#実装検証状況)を参照する。

## 整備を担当する人へ

- [Dockerでの検証](docker-validation.md)
- [管理・保守の方針](maintenance.md)
- [ドキュメントサイトの開発・公開](site-development.md)
