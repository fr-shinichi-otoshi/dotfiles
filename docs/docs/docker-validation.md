# Dockerでの検証

## 検証の対象と前提

- **目的**：ホストのホーム設定を変更せず、初回構築と再適用を確認する。
- **対象**：ローカルのdotfilesリポジトリ。未コミット・未プッシュの変更も含む。
- **SSH認証との関係**：この検証ではソースをコピーするため、GitHub用の鍵生成・登録・クローンは行わない。実際の導入では利用者向け手順でSSH認証を確認する。
- **前提**：Dockerが起動済みであり、`docker version`でサーバーへ接続できること。
- **適用前の準備**：管理対象、除外設定、必要な個人設定を整えること。
- **手順の位置付け**：以下の手動検証手順は未実行である。Dockerfileと自動検証は今後追加する。

## 検証用コンテナにローカルのソースを渡す

ホスト側でdotfilesリポジトリのルートに移動し、以下を実行する。PowerShellでも実行できる。

```bash
docker run --rm -dit --name dotfiles-check ubuntu:24.04 bash
docker cp . dotfiles-check:/tmp/dotfiles
docker exec -it dotfiles-check bash
```

- **コピー対象**：現在のディレクトリ全体。コピー前に認証情報などを置いていないことを確認する。
- **検証対象の更新**：コピー後のホスト側の変更は自動反映されない。再検証時は新しいコンテナへコピーする。
- **ホストとの接続**：ホームディレクトリとDockerソケットはマウントしない。

## 一般ユーザーの検証環境を作る

コンテナ内のrootとして実行する。

```bash
apt-get update
apt-get install -y ca-certificates curl git sudo
useradd --create-home --shell /bin/bash --groups sudo developer
passwd developer

mkdir -p /home/developer/dotfiles
cp -a /tmp/dotfiles/. /home/developer/dotfiles/
chown -R developer:developer /home/developer
su - developer
```

- `passwd`で検証用パスワードを設定する。以降のsudoでも同じパスワードを使う。
- `su - developer`以降は一般ユーザーとして作業する。

## bootstrap.shで初回導入と再実行を確認する

1. [名前とメールアドレスを設定する](getting-started.md#名前とメールアドレスを設定する)を実行する。検証用の名前・メールアドレスを使う。
2. コピーしたリポジトリでbootstrap.shを実行する。chezmoiは事前に導入しない。

   ```bash
   cd ~/dotfiles
   bash bootstrap.sh
   ```

3. [導入結果を確認する](getting-started.md#導入結果を確認する)のコマンドを、新しいシェルでも実行する。
4. 同じリポジトリで`bash bootstrap.sh`を再実行し、個人設定の保持と処理結果を確認する。

## 合格条件

- [ ] 初回の導入・設定適用が一般ユーザーで完了する。
- [ ] 管理対象だけが意図した場所に配置される。
- [ ] 入力した個人設定が反映される。
- [ ] 新しいシェルからツールを起動できる。
- [ ] 再適用で設定の重複・破損・不要な再インストールが発生しない。
- [ ] 適用後の`chezmoi diff`に意図しない差分が残らない。
- [ ] 新しいコンテナでも同じ手順で初回構築を再現できる。

## 終了・再検証

1. `exit`で一般ユーザーのシェルを抜け、もう一度`exit`で`docker exec`を終了する。
2. ホスト側でコンテナを停止する。`--rm`によりコンテナ内の設定も削除される。

   ```bash
   docker stop dotfiles-check
   ```

3. 初回構築を再検証する場合は、「検証用コンテナにローカルのソースを渡す」から新しいコンテナでやり直す。

## 実環境で別途確認する項目

- **WSL 2上のUbuntu**：WSLの導入・起動と、Windowsとの連携。
- **利用対象の実環境**：GUIツール、デスクトップとの連携、systemdを前提とするサービス。
- **各自のアカウントを設定した実環境**：AI開発ツールの認証と実際の利用。

[セットアップ手順へ](getting-started.md)
