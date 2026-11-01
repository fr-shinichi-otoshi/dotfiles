# 開発環境のセットアップ

上から順に実行します。失敗したら先へ進まず[困ったとき](troubleshooting.md)を確認します。

- **対象**：開発メンバー。環境はWSL2またはLinuxのUbuntu（検証基準は24.04 LTS）。
- **事前**：GitHubにログインできること。Git用の名前とメールアドレスを用意します。詳細は[事前確認](troubleshooting.md#事前確認)を参照してください。
- **場所**：WindowsのWSL導入だけPowerShell。以降と、公開鍵の登録以外はUbuntuのターミナルです。
- **クローン先**：自分のGitHubアカウントへフォークしてからクローンします。

## Ubuntuを準備する

**Windowsの場合**

```powershell
wsl --install -d Ubuntu-24.04
```

再起動を求められたら再起動し、Ubuntuでユーザー名とパスワードを設定します。`wsl --list --verbose`で`VERSION`が`2`であることを確認します。

**Linuxの場合**

Ubuntuにログインし、ターミナルを開きます。既存のSSH鍵がある場合は、上書き前に管理者へ確認します。

## GitとSSHを入れる

```bash
sudo apt-get update
sudo apt-get install -y git openssh-client ca-certificates
```

## SSH鍵を作成する

```bash
export EMAIL="<email>"
echo $EMAIL
ssh-keygen -t ed25519 -C "$EMAIL"
```

保存先・パスフレーズはEnterのまま（パスフレーズなし）にします。既に鍵がある場合は管理者へ確認し、上書きを求められたら`n`で中止します。

## 公開鍵をGitHubに登録する

```bash
cat ~/.ssh/id_ed25519.pub
echo "$(whoami)@$(hostname)"
```

表示された公開鍵1行と`username@host`をコピーし、[GitHubのSSH鍵設定](https://github.com/settings/keys)で**New SSH key**から登録します。

## GitHubへのSSH接続を確認する

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com
```

`successfully authenticated`が表示されれば成功です。`does not provide shell access`はエラーではありません。

## リポジトリをフォークする

配布元を自分のアカウントへコピーします。ブラウザで行います。

1. GitHubにログインした状態で、配布元の[dotfilesリポジトリ](https://github.com/fr-shinichi-otoshi/dotfiles)を開きます。
2. 右上の**Fork**を選びます。
3. **Owner**が自分のアカウントになっていることを確認し、**Create fork**を選びます。
4. 作成後のURLが`https://github.com/<github-username>/dotfiles`になっていることを確認します。`<github-username>`は自分のGitHubユーザー名です。

すでに自分のフォークがある場合は、この手順は不要です。管理者から別の配布元を案内された場合は、そのリポジトリを開いて同様にフォークします。

## dotfilesをクローンする

`<github-username>`を、いま作ったフォークの所有者名（自分のGitHubユーザー名）に置き換えます。

```bash
git clone git@github.com:<github-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## 名前とメールアドレスを設定する

既存の`chezmoi.toml`がある場合は上書きしません。

```bash
mkdir -p ~/.config/chezmoi
cat > ~/.config/chezmoi/chezmoi.toml <<'EOF'
[data]
name = "<name>"
email = "<email>"
EOF
cat ~/.config/chezmoi/chezmoi.toml
```

## chezmoiを導入し、設定を適用する

```bash
sudo snap install chezmoi --classic
cd ~/dotfiles
chezmoi init --source="$PWD"
chezmoi apply --source="$PWD"
test -f ~/.config/mise/config.toml && test -f ~/.zshrc && test -f ~/.vimrc && test -f ~/.gitconfig && test -f ~/.gitignore_global && echo ok
```

`ok`が表示されれば成功です。

## bootstrap.shを実行する

一般ユーザーで実行します（`sudo bash`は使いません）。

```bash
bash scripts/bootstrap.sh
```

## 導入結果を確認する

新しいターミナルを開くか`exec zsh`を実行します。

```bash
getent passwd "$USER" | cut -d: -f7
git --version
git config --global --get user.name
git config --global --get user.email
mise --version
chezmoi --version
docker --version
chezmoi diff
newgrp docker
docker version
sudo docker run --rm hello-world
```

- ログインシェルが`/usr/bin/zsh`であること。
- 各コマンドの版が表示され、`chezmoi diff`に意図しない差分がないこと。
- `docker version`と`hello-world`が成功すること。
- Vimは一度起動するとvim-plugが入ります。主要CLIの一覧は[構成と方針](architecture.md#導入するツール)を参照してください。

初回が終わったら、以降は[導入後の更新](update.md)を使います。
