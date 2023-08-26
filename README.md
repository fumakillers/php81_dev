# README

Docker Desktop for Windows.  
(Use the WSL 2 based engine)  
Nginx 1.25.2 & PHP 8.2 & Xdebug 3.2.2 & MySQL 8.0.34.  

## What is this repository?

Windows上でのNginx & PHP & Xdebugの情報が少なかったため一度作っておきたかった。

## php-fpm & xdebug

xdebug.ini(3.x)のxdebug.client_host, docker-compose.ymlのextra_hosts, これらを __host.docker.internal__ にするとVScodeでステップ実行ができるというエントリが多い。が、どうやらWindowsだと上手く動かない。そういった記事も多く例に漏れず自身も上手く通信させることができなかった。  
念のため、このリポジトリでもコメントアウトする形で残している。
結局、適当なネットワークで各コンテナを同一ネットワーク内で構築し、`イーサネットアダプター vEthenet (WSL)`のIPv4アドレスをxdebug.iniのclient_hostに指定することで安定してdebuggerを使用できている。

## setup

WSL2が入っていてDocker DesktopをWSL2 engineで動作させていることが前提。

### xdebug.ini

`ipconfig /all`でホストPCの`イーサネットアダプター vEthenet (WSL)`のIPv4アドレスを確認。その値を./files/xdebug.iniのxdebug.client_hostに指定。

### VScode launch.json

```json
{
    // IntelliSense を使用して利用可能な属性を学べます。
    // 既存の属性の説明をホバーして表示します。
    // 詳細情報は次を確認してください: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "hostname": "0.0.0.0",
            "pathMappings": {
                "/var/source":"${workspaceRoot}"
            }
        }
    ]
}
```

複数configが作られるが基本的にこれだけでよい。

### up

```
docker-compose up -d
```

## etc

ソースコードを直接 /volume/source に配置せず、開発時に使用するrepositoryにシンボリックリンクを貼ると環境を使い回せて便利。  

1. /volume/sourceディレクトリを削除
2. シンボリックリンクをsourceの名前で作成(用管理者権限)  
    ex)  
    `E:\php_dev_docker\volumes>mklink /d source e:\Repository\hogefuga`

おわり
