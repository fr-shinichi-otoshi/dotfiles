# 開発環境のセットアップ

- **対象者**：新卒や、Linuxでの開発経験がないチームメンバー。
- **進め方**：前提条件を確認し、初回セットアップを上から順に実行します。
- **現在の状態**：snapのchezmoi適用後にbootstrapでプロビジョニングする流れまで実装済みです。Git共通設定（署名以外）も配布します。署名・鍵運用は未整備です。整備者の検証はDockerのみ（実機検証は対象外）です。[実装・検証状況](maintenance.md#実装検証状況)を確認してから利用してください。

## 前提条件

### 作業環境・権限

**Windowsの場合**

- WSL2を利用できるWindowsである必要があります。対応条件は[Microsoft公式手順](https://learn.microsoft.com/en-us/windows/wsl/install)で確認します。
- WSLの導入時に管理者権限を使用できる必要があります。
- Ubuntu 24.04 LTSは、以下の手順で導入します。

**Linuxの場合**

- Ubuntuにインストール・ログイン済みである必要があります。検証基準はUbuntu 24.04 LTSです。
- sudoを実行できる一般ユーザーで作業します。

**共通で必要なもの**

- GitHubとUbuntu・ツールの配布先へ接続できるネットワーク。
- GitHubへのログインと公開鍵の登録に使うブラウザ。

- WSL導入後の作業では、Ubuntu内でもsudoを実行できることが必要です。
- 会社のPCで管理者権限や外部への通信が制限されている場合は、導入前に担当者へ確認します。Docker Engineの導入も制限対象になることがあります。
- Git・SSHは以下の手順で導入します。chezmoiはsnapで導入します（`scripts/bootstrap.sh`では入れません）。
- `scripts/bootstrap.sh`はDocker Engineも公式aptリポジトリから導入します。
- WSLでsnapとDockerを使う場合は、systemdを有効にしてください。
- systemdが無効な場合は、指導者へ確認してください。

### 用意しておくアカウント・情報

- **GitHubアカウント**：公開鍵の登録に使用します。
- **リポジトリの所有者名**：配布元、または自分のフォークの所有者名。指導者から案内を受けます。
- **Gitで使用する名前**：コミットの作成者名。GitHubのユーザー名と同じでなくても構いません。
- **Gitで使用するメールアドレス**：GitHubアカウントに登録したアドレス、またはGitHubのnoreplyアドレスを用意します。

- GitHubへのログイン方法・二要素認証を確認し、ブラウザでログインできる状態にしておきます。
- SSH鍵は以下の手順で作成するため、まだ持っていなくても構いません。

### コマンドを実行するときの約束

- コードブロック内のコマンドを、上から順に実行します。
- `<>`で囲まれた箇所は、自分または案内された値に置き換えます。
- エラーが出た場合は、そのまま次へ進まず指導者に確認します。
- 既存の設定があるPCでは、適用前に対象ファイルをバックアップします。新規環境ではこの作業は不要です。

## セットアップの流れ

1. Ubuntuを準備します。
2. Git・SSHをインストールし、SSH鍵を生成します。
3. 公開鍵をGitHubに登録します。
4. GitHubへのSSH接続を確認します。
5. dotfilesをSSHでクローンします。
6. 名前・メールアドレスを設定します。
7. snapでchezmoiを導入し、設定を適用します。
8. `~/dotfiles`で`scripts/bootstrap.sh`を実行します。
9. 新しいターミナルで導入結果を確認します。

- WindowsのWSL導入はPowerShell、以降のコマンドはUbuntuで実行します。
- GitHubへの公開鍵登録はブラウザで行います。

## 初回セットアップ

### Ubuntuを準備する

**Windowsの場合**

1. 管理者権限のPowerShellでUbuntuを導入します。

   ```powershell
   wsl --install -d Ubuntu-24.04
   ```

2. Windowsの再起動を求められた場合は、再起動します。
3. Ubuntuを起動し、Linuxのユーザー名とパスワードを設定します。
4. PowerShellで`wsl --list --verbose`を実行し、対象のUbuntuの`VERSION`が`2`であることを確認します。

**LinuxのUbuntuの場合**

- Ubuntuにログインし、ターミナルを開きます。

- **ここからの実行場所**：Windowsの場合も、コマンドはUbuntuのターミナルで実行します。GitHubの登録操作のみブラウザを使います。
- **既にUbuntuを利用している場合**：OSの再インストールは不要です。既存のSSH鍵や設定がある場合は、上書きする前に指導者へ確認します。

### GitとSSHのコマンドを準備する

- **実行場所**：Ubuntuのターミナル。Windows側のPowerShellでは実行しません。
- sudoのパスワードを求められた場合は、Ubuntuの初回起動時に設定したパスワードを入力します。入力中に文字が表示されなくても、そのまま入力してEnterを押します。

```bash
sudo apt-get update
sudo apt-get install -y git openssh-client ca-certificates
```

### SSHの公開鍵と秘密鍵を作成する

- `EMAIL`に、自分のGitHubアカウントのメールアドレスを設定します。設定後に`echo $EMAIL`で値を確認します。
- 既にSSH鍵を使っている場合は、新規作成の前に指導者へ確認します。上書きを求められた場合は`n`で中止します。

```bash
export EMAIL="<email>"
echo $EMAIL
ssh-keygen -t ed25519 -C "$EMAIL"
```

質問には、次の順に回答します。

1. `Enter file in which to save the key`：Enterを押し、標準の保存先を使います。
2. `Enter passphrase`：何も入力せずEnterを押します。
3. `Enter same passphrase again`：何も入力せずEnterを押します。

- パスフレーズは設定しません。
- 次の2ファイルが作成されます。

| 種類   | ファイル                |
| ------ | ----------------------- |
| 秘密鍵 | `~/.ssh/id_ed25519`     |
| 公開鍵 | `~/.ssh/id_ed25519.pub` |

- 秘密鍵はこのUbuntu内に保持します。他人に渡したり、GitHubに登録したりしません。
- 公開鍵は次の手順でGitHubに登録します。

### 公開鍵をGitHubに登録する

1. Ubuntuのターミナルで公開鍵とTitle用の名前を表示します。

   ```bash
   cat ~/.ssh/id_ed25519.pub
   echo "$(whoami)@$(hostname)"
   ```

2. 表示された公開鍵（`ssh-ed25519`から始まる1行全体）と、Title用の名前（`username@host`形式）をそれぞれコピーします。コマンドやターミナルのプロンプトは含めません。
3. ブラウザで[GitHubのSSH鍵設定](https://github.com/settings/keys)を開きます。
4. **New SSH key**を選び、以下を入力します。

   - **Title**：手順1で表示した`username@host`形式の名前。
   - **Key type**：`Authentication Key`。
   - **Key**：コピーした公開鍵の1行全体。

5. **Add SSH key**を選択して登録します。

### GitHubへのSSH接続を確認する

1. Ubuntuのターミナルでssh-agentを起動し、秘密鍵を読み込ませます。

   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

   - パスフレーズは設定していないため、入力は求められません。
   - この読み込みは現在の作業用です。Ubuntuを再起動した後は、接続前に上記の2コマンドを実行します。

2. 次のコマンドで、GitHubへのSSH接続を確認します。

   ```bash
   ssh -T git@github.com
   ```

3. 初回に接続先の確認が表示されたら、表示されたフィンガープリントが[GitHub公式の値](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)と一致することを確認し、`yes`を入力します。
4. 次のメッセージの`<username>`が自分のGitHubユーザー名になっていることを確認します。

   ```text
   Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
   ```

- **成功の判断**：`successfully authenticated`が表示されれば認証成功です。`does not provide shell access`はエラーではありません。
- **失敗時**：`Permission denied (publickey)`が表示された場合は先へ進まず、公開鍵の登録先と`ssh-add`の結果を確認します。

### SSHでdotfilesをクローンする

- `<github-username>`を、配布元または自分がフォークしたリポジトリの所有者名に置き換えます。
- 自分用の変更をGitHubで管理する場合は、先にブラウザ上でフォークします。
- 以下をUbuntuのターミナルで実行します。chezmoiの事前インストールは不要です。

```bash
git clone git@github.com:<github-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

- **確認結果**：クローンが完了し、`~/dotfiles`へ移動できること。
- **次の操作**：クローン後に個人設定を作成し、chezmoiを導入して設定を適用します。

### 名前とメールアドレスを設定する

- **実行場所**：Ubuntuのターミナル。
- **書き換える箇所**：`<name>`と`<email>`を、自分の名前とGitで使用するメールアドレスに置き換えます。
- **実行タイミング**：初回のセットアップ時。既存の`chezmoi.toml`がある場合は、このコマンドで上書きしません。

```bash
mkdir -p ~/.config/chezmoi
cat > ~/.config/chezmoi/chezmoi.toml <<'EOF'
[data]
name = "<name>"
email = "<email>"
EOF
```

- この操作で、個人設定ファイル`~/.config/chezmoi/chezmoi.toml`を作成します。
- 設定ファイルは各自のUbuntu内に保存され、共有リポジトリには含まれません。
- 次のコマンドで、名前とメールアドレスが正しく書かれていることを確認します。

```bash
cat ~/.config/chezmoi/chezmoi.toml
```

作成される設定の例は次のとおりです。

```toml
[data]
name = "Taro Yamada"
email = "taro@example.com"
```

### chezmoiを導入し、設定を適用する

- **実行場所**：取得したリポジトリ内（`~/dotfiles`）。
- snapでchezmoiを導入します。`--classic`が必要です。

```bash
sudo snap install chezmoi --classic
chezmoi --version
```

- このリポジトリをsourceにして初期化し、ホームへ設定を適用します。

```bash
cd ~/dotfiles
chezmoi init --source="$PWD"
chezmoi apply --source="$PWD"
```

- **確認結果**：次のファイルが存在すること。`~/.config/mise/config.toml`、`~/.zshrc`、`~/.vimrc`、`~/.gitconfig`、`~/.gitignore_global`。

```bash
test -f ~/.config/mise/config.toml && test -f ~/.zshrc && test -f ~/.vimrc && test -f ~/.gitconfig && test -f ~/.gitignore_global && echo ok
```

- 個人設定（name/email）が無いと、以降の手順で困る場合があります。適用前に`chezmoi.toml`を確認します。

### bootstrap.shを実行する

- **実行場所**：取得したリポジトリ内（`~/dotfiles`）。
- **前提**：上記のchezmoi適用が完了している必要があります。
- **操作**：以下を実行し、sudoのパスワードを求められたらUbuntuのパスワードを入力します。

```bash
bash scripts/bootstrap.sh
```

- mitamaeによるパッケージ導入と、miseによるCLI導入を、このスクリプトが行います。chezmoiのinstall/applyは行いません。処理の詳細は[管理・保守の方針](maintenance.md)を参照してください。
- `sudo bash scripts/bootstrap.sh`ではなく、上記のとおり一般ユーザーで実行します。

### 導入結果を確認する

- 新しいターミナルを開くか、`exec zsh`を実行します。
- ログインシェルと主要コマンドを確認します。

```bash
getent passwd "$USER" | cut -d: -f7
git --version
git-lfs --version
git config --global --get user.name
git config --global --get user.email
delta --version
mise --version
chezmoi --version
gh --version
sops --version
age --version
fzf --version
rg --version
fd --version
eza --version
sheldon --version
starship --version
atuin --version
lazygit --version
lefthook version
node --version
uv --version
terraform version
tflint --version
terraform-docs --version
broot --version
gping --version
rga --version
lazydocker --version
herdr --version
hunk --version
docker --version
vim --version | head -n 1
test -f ~/.gitconfig && test -f ~/.gitignore_global && echo gitconfig_ok
chezmoi diff
```

- Vimは`chezmoi apply`後に一度`vim`を起動すると、vim-plugとプラグインが自動導入されます（`curl`が必要です。aptのvimはbootstrapで入ります）。
- Dockerをsudoなしで使うには、再ログインするか`newgrp docker`を実行します。

```bash
newgrp docker
docker version
sudo docker run --rm hello-world
```

- **完了条件**：
  - ログインシェルが`/usr/bin/zsh`です。
  - 上記コマンドのバージョンが表示されます。
  - `chezmoi diff`に意図しない差分がありません。
  - `docker version`と`hello-world`が成功します。

## 導入後の更新

- 配布元を直接利用している場合は、以下のコマンドで更新します。
- 自分のフォークを利用している場合は、配布元の変更をフォークへ取り込んでから実行します。
- ローカルでファイルを変更している場合は、先に指導者と変更内容を確認します。

```bash
cd ~/dotfiles
git pull --ff-only
chezmoi apply --source="$PWD"
bash scripts/bootstrap.sh
```

- 更新後も「導入結果を確認する」を確認します。
- 個人設定を作成するコマンドは、通常の更新では実行しません。
- 日常更新用の`scripts/update.sh`は未実装です。

## 困ったとき

### パスワードの入力中に文字が表示されない

- sudoでは正常な動作です。そのままUbuntuのパスワードを入力します。

### SSH鍵の上書きを求められる

- `n`で中止し、既存の鍵を使うか指導者へ確認します。

### SSH接続でエラーが出る

- `Permission denied (publickey)`：公開鍵を登録したGitHubアカウントと`ssh-add`の結果を確認します。
- `does not provide shell access`：同じメッセージに`successfully authenticated`と自分のユーザー名があれば成功です。

### クローンできない

- `Repository not found`：リポジトリの所有者名と、自分のアカウントのアクセス権を確認します。
- `~/dotfiles`が既に存在する：削除せず、以前の作業結果か指導者へ確認します。

### bootstrap.shが見つからない

- `~/dotfiles`で`bash scripts/bootstrap.sh`を実行しているか確認します。
- 配布されているブランチに`scripts/bootstrap.sh`があるか確認します。

### chezmoi または mise 設定が無いと bootstrap が停止する

- [chezmoiを導入し、設定を適用する](#chezmoiを導入し設定を適用する)を先に完了します。
- `chezmoi`コマンドが無い場合は、snap導入を確認します。
- `~/.config/mise/config.toml`が無い場合は、`chezmoi apply --source="$PWD"`を再実行します。

### snap install に失敗する

- WSLではsystemdが無効になっていることがあります。指導者へ確認します。
- `sudo snap install chezmoi --classic`のエラー全文を残して共有します。

## 参考資料

- [GitHub：SSH鍵の生成とssh-agentへの追加](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [GitHub：公開鍵の登録](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- [GitHub：SSH接続の確認](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection)

- [chezmoiのインストール](https://www.chezmoi.io/install/)
- [chezmoiのセットアップ](https://www.chezmoi.io/user-guide/setup/)
- [chezmoiの除外設定](https://www.chezmoi.io/reference/special-files/chezmoiignore/)
- [chezmoiの管理対象ルートの指定](https://www.chezmoi.io/reference/special-files/chezmoiroot/)
- [MicrosoftのWSL導入手順](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Dockerのコンテナ実行](https://docs.docker.com/engine/containers/run/)

[リポジトリの概要へ戻る](https://github.com/fr-shinichi-otoshi/dotfiles)
