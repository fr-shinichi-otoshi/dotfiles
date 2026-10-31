# 開発環境のセットアップ

- **対象者**：新卒や、Linuxでの開発経験がないチームメンバー。
- **進め方**：前提条件を確認し、初回セットアップを上から順に実行する。
- **現在の状態**：bootstrap.shと共通設定は未実装である。[実装・検証状況](maintenance.md#実装検証状況)を確認してから利用する。

## 前提条件

### 作業環境・権限

**Windowsの場合**

- WSL 2を利用できるWindowsであること。対応条件は[Microsoft公式手順](https://learn.microsoft.com/en-us/windows/wsl/install)で確認する。
- WSLの導入時に管理者権限を使用できること。
- Ubuntu 24.04 LTSは、以下の手順で導入する。

**Linuxの場合**

- Ubuntuにインストール・ログイン済みであること。検証基準はUbuntu 24.04 LTSである。
- sudoを実行できる一般ユーザーで作業すること。

**共通で必要なもの**

- GitHubとUbuntu・ツールの配布先へ接続できるネットワーク。
- GitHubへのログインと公開鍵の登録に使うブラウザ。

- WSL導入後の作業では、Ubuntu内でもsudoを実行できることが必要である。
- 会社のPCで管理者権限や外部への通信が制限されている場合は、導入前に担当者へ確認する。
- Dockerは通常の導入には不要である。リポジトリを整備・検証する人だけが使用する。
- Git・SSH・chezmoiは事前にインストールしなくてよい。Git・SSHは以下の手順で、chezmoiはbootstrap.shで導入する。

### 用意しておくアカウント・情報

- **GitHubアカウント**：公開鍵の登録に使用する。
- **リポジトリの所有者名**：配布元、または自分のフォークの所有者名。指導者から案内を受ける。
- **Gitで使用する名前**：コミットの作成者名。GitHubのユーザー名と同じでなくてもよい。
- **Gitで使用するメールアドレス**：GitHubアカウントに登録したアドレス、またはGitHubのnoreplyアドレスを用意する。

- GitHubへのログイン方法・二要素認証を確認し、ブラウザでログインできる状態にしておく。
- SSH鍵は以下の手順で作成するため、まだ持っていなくてもよい。

### コマンドを実行するときの約束

- コードブロック内のコマンドを、上から順に実行する。
- 例の名前・メールアドレス・`YOUR_GITHUB_USERNAME`は、自分または案内された値に置き換える。
- エラーが出た場合は、そのまま次へ進まず指導者に確認する。
- 既存の設定があるPCでは、適用前に対象ファイルをバックアップする。新規環境ではこの作業は不要である。

## セットアップの流れ

1. Ubuntuを準備する。
2. Git・SSHをインストールし、SSH鍵を生成する。
3. 公開鍵をGitHubに登録する。
4. GitHubへのSSH接続を確認する。
5. dotfilesをSSHでクローンする。
6. `echo`で名前・メールアドレスを設定する。
7. `~/dotfiles`で`bootstrap.sh`を実行する。
8. 新しいターミナルで導入結果を確認する。

- WindowsのWSL導入はPowerShell、以降のコマンドはUbuntuで実行する。
- GitHubへの公開鍵登録はブラウザで行う。

## 初回セットアップ

### Ubuntuを準備する

**Windowsの場合**

1. 管理者権限のPowerShellでUbuntuを導入する。

   ```powershell
   wsl --install -d Ubuntu-24.04
   ```

2. Windowsの再起動を求められた場合は、再起動する。
3. Ubuntuを起動し、Linuxのユーザー名とパスワードを設定する。
4. PowerShellで`wsl --list --verbose`を実行し、対象のUbuntuの`VERSION`が`2`であることを確認する。

**LinuxのUbuntuの場合**

- Ubuntuにログインし、ターミナルを開く。

- **ここからの実行場所**：Windowsの場合も、コマンドはUbuntuのターミナルで実行する。GitHubの登録操作のみブラウザを使う。
- **既にUbuntuを利用している場合**：OSの再インストールは不要である。既存のSSH鍵や設定がある場合は、上書きする前に指導者へ確認する。

### GitとSSHのコマンドを準備する

- **実行場所**：Ubuntuのターミナル。Windows側のPowerShellでは実行しない。
- sudoのパスワードを求められた場合は、Ubuntuの初回起動時に設定したパスワードを入力する。入力中に文字が表示されなくても、そのまま入力してEnterを押す。

```bash
sudo apt-get update
sudo apt-get install -y git openssh-client ca-certificates
```

### SSHの公開鍵と秘密鍵を作成する

- `taro@example.com`を、自分のGitHubアカウントのメールアドレスに置き換える。
- 既にSSH鍵を使っている場合は、新規作成の前に指導者へ確認する。上書きを求められた場合は`n`で中止する。

```bash
ssh-keygen -t ed25519 -C "taro@example.com"
```

質問には、次の順に回答する。

1. `Enter file in which to save the key`：Enterを押し、標準の保存先を使う。
2. `Enter passphrase`：鍵を保護するためのパスフレーズを入力する。
3. `Enter same passphrase again`：同じパスフレーズを再入力する。

- パスフレーズは自分で決める。入力中の文字は表示されない。
- 次の2ファイルが作成される。

| 種類   | ファイル                |
| ------ | ----------------------- |
| 秘密鍵 | `~/.ssh/id_ed25519`     |
| 公開鍵 | `~/.ssh/id_ed25519.pub` |

- 秘密鍵はこのUbuntu内に保持する。他人に渡したり、GitHubに登録したりしない。
- 公開鍵は次の手順でGitHubに登録する。

### 公開鍵をGitHubに登録する

1. Ubuntuのターミナルで公開鍵を表示する。

   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

2. 表示された`ssh-ed25519`から始まる1行全体をコピーする。コマンドやターミナルのプロンプトは含めない。
3. ブラウザで[GitHubのSSH鍵設定](https://github.com/settings/keys)を開く。
4. **New SSH key**を選び、以下を入力する。

   - **Title**：`開発用PC Ubuntu`など、どの環境の鍵か分かる名前。
   - **Key type**：`Authentication Key`。
   - **Key**：コピーした公開鍵の1行全体。

5. **Add SSH key**を選択して登録する。

### GitHubへのSSH接続を確認する

1. Ubuntuのターミナルでssh-agentを起動し、秘密鍵を読み込ませる。

   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

   - パスフレーズを求められたら、SSH鍵の作成時に決めたものを入力する。
   - この読み込みは現在の作業用である。Ubuntuを再起動した後は、接続前に上記の2コマンドを実行する。

2. GitHubへ接続する。

   ```bash
   ssh -T git@github.com
   ```

3. 初回に接続先の確認が表示されたら、表示されたフィンガープリントが[GitHub公式の値](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints)と一致することを確認し、`yes`を入力する。
4. 次のメッセージの`USERNAME`が自分のGitHubユーザー名になっていることを確認する。

   ```text
   Hi USERNAME! You've successfully authenticated, but GitHub does not provide shell access.
   ```

- **成功の判断**：`successfully authenticated`が表示されれば認証成功である。`does not provide shell access`はエラーではない。
- **失敗時**：`Permission denied (publickey)`が表示された場合は先へ進まず、公開鍵の登録先と`ssh-add`の結果を確認する。

### SSHでdotfilesをクローンする

- `YOUR_GITHUB_USERNAME`を、配布元または自分がフォークしたリポジトリの所有者名に置き換える。
- 自分用の変更をGitHubで管理する場合は、先にブラウザ上でフォークする。
- 以下をUbuntuのターミナルで実行する。chezmoiの事前インストールは不要である。

```bash
git clone git@github.com:YOUR_GITHUB_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

- **確認結果**：クローンが完了し、`~/dotfiles`へ移動できること。
- **次の操作**：クローン後に個人設定を作成し、その後で`bootstrap.sh`を実行する。

### 名前とメールアドレスを設定する

- **実行場所**：Ubuntuのターミナル。
- **書き換える箇所**：`山田 太郎`と`taro@example.com`を、自分の名前とGitで使用するメールアドレスに置き換える。
- **実行タイミング**：初回のセットアップ時。既存の`chezmoi.toml`がある場合は、このコマンドで上書きしない。

```bash
mkdir -p ~/.config/chezmoi
echo '[data]' > ~/.config/chezmoi/chezmoi.toml
echo 'name = "山田 太郎"' >> ~/.config/chezmoi/chezmoi.toml
echo 'email = "taro@example.com"' >> ~/.config/chezmoi/chezmoi.toml
```

- この操作で、個人設定ファイル`~/.config/chezmoi/chezmoi.toml`を作成する。
- 設定ファイルは各自のUbuntu内に保存され、共有リポジトリには含まれない。
- 次のコマンドで、名前とメールアドレスが正しく書かれていることを確認する。

```bash
cat ~/.config/chezmoi/chezmoi.toml
```

作成される設定の例は次のとおりである。

```toml
[data]
name = "山田 太郎"
email = "taro@example.com"
```

### bootstrap.shを実行する

- **実行場所**：取得したリポジトリ内（`~/dotfiles`）。
- **操作**：以下を実行し、sudoのパスワードを求められたらUbuntuのパスワードを入力する。

```bash
bash bootstrap.sh
```

- chezmoiの導入と共通設定の適用は、このスクリプトが行う設計である。処理の詳細は[管理・保守の方針](maintenance.md)を参照する。
- `sudo bash bootstrap.sh`ではなく、上記のとおり一般ユーザーで実行する。

### 導入結果を確認する

- 新しいターミナルを開き、以下を実行する。

```bash
chezmoi --version
git --version
chezmoi diff
```

- **完了条件**：ツールのバージョンが表示され、`chezmoi diff`に意図しない差分がないこと。
- **追加する確認**：導入ツールの選定後、ツールごとの起動・設定確認を追記する。

## 導入後の更新

- 配布元を直接利用している場合は、以下のコマンドで更新する。
- 自分のフォークを利用している場合は、配布元の変更をフォークへ取り込んでから実行する。
- ローカルでファイルを変更している場合は、先に指導者と変更内容を確認する。

```bash
cd ~/dotfiles
git pull --ff-only
bash bootstrap.sh
```

- 更新後も「導入結果を確認する」を確認する。
- 個人設定を作成する`echo`コマンドは、通常の更新では実行しない。

## 困ったとき

### パスワードの入力中に文字が表示されない

- sudoでは正常な動作である。そのままUbuntuのパスワードを入力する。

### SSH鍵の上書きを求められる

- `n`で中止し、既存の鍵を使うか指導者へ確認する。

### SSH接続でエラーが出る

- `Permission denied (publickey)`：公開鍵を登録したGitHubアカウントと`ssh-add`の結果を確認する。
- `does not provide shell access`：同じメッセージに`successfully authenticated`と自分のユーザー名があれば成功である。

### クローンできない

- `Repository not found`：リポジトリの所有者名と、自分のアカウントのアクセス権を確認する。
- `~/dotfiles`が既に存在する：削除せず、以前の作業結果か指導者へ確認する。

### bootstrap.shが見つからない

- `~/dotfiles`で実行しているか確認する。
- 配布されているブランチにスクリプトがあるか確認する。現時点では未実装である。

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
