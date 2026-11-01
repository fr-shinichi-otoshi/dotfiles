# 困ったとき

セットアップや更新で止まったときの確認事項です。解決しない場合は、エラー全文を残して管理者へ確認します。

## 事前確認

- **環境**：WSL2上のUbuntu、またはLinuxのUbuntu。検証基準はUbuntu 24.04 LTSです。
- **権限**：WSL導入時は管理者権限、Ubuntu内ではsudoを実行できる一般ユーザーが必要です。
- **ネットワーク**：GitHubとパッケージ配布先へ接続できること。会社PCでは制限の有無を事前に確認します。
- **systemd**：WSLでsnapとDockerを使う場合は有効であること。無効なら管理者へ確認します。
- **約束**：コマンドは上から順に実行します。`<>`は案内された値に置き換えます。既存設定があるPCでは、上書き前にバックアップします。

用意するものは、GitHubアカウント、リポジトリの所有者名、Git用の名前とメールアドレスです。

## パスワードの入力中に文字が表示されない

sudoでは正常な動作です。そのままUbuntuのパスワードを入力します。

## SSH鍵の上書きを求められる

`n`で中止し、既存の鍵を使うか管理者へ確認します。

## SSH接続でエラーが出る

- `Permission denied (publickey)`：公開鍵を登録したGitHubアカウントと`ssh-add`の結果を確認します。
- `does not provide shell access`：同じメッセージに`successfully authenticated`と自分のユーザー名があれば成功です。

## クローンできない

- `Repository not found`：リポジトリの所有者名と、自分のアカウントのアクセス権を確認します。
- `~/dotfiles`が既に存在する：削除せず、以前の作業結果か管理者へ確認します。

## bootstrap.shが見つからない

- `~/dotfiles`で`bash scripts/bootstrap.sh`を実行しているか確認します。
- 配布されているブランチに`scripts/bootstrap.sh`があるか確認します。

## chezmoi または mise 設定が無いと bootstrap が停止する

- [chezmoiを導入し、設定を適用する](getting-started.md#chezmoiを導入し設定を適用する)を先に完了します。
- `chezmoi`コマンドが無い場合は、snap導入を確認します。
- `~/.config/mise/config.toml`が無い場合は、`chezmoi apply --source="$PWD"`を再実行します。

## snap install に失敗する

- WSLではsystemdが無効になっていることがあります。管理者へ確認します。
- `sudo snap install chezmoi --classic`のエラー全文を残して共有します。

## 参考資料

- [GitHub：SSH鍵の生成とssh-agentへの追加](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [GitHub：公開鍵の登録](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- [GitHub：SSH接続の確認](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection)
- [chezmoiのインストール](https://www.chezmoi.io/install/)
- [MicrosoftのWSL導入手順](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Dockerのコンテナ実行](https://docs.docker.com/engine/containers/run/)
