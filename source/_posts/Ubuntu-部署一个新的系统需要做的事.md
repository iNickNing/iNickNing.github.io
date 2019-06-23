---
title: Ubuntu-部署一个新的系统需要做的事
id: article20190619070540
date: 2019-06-19 15:05:40
categories: 学习记录
tags:
  - Linux
---

### # 背景
因为需要部署一些机器用于生产环境，
然后又需要后期好维护，
再这之前，我需要在电脑上做一些操作，
记性不好，所以用一片文来记录一下。

<!--more-->

### # 任务列表
 - 关闭 Ubuntu 的自动更新
 - 关闭错误弹框
 - 安装设置 SaltStack
 - 安装设置 frpc
 - 安装设置 Teamviewer
 - 开启 Ubuntu 远程协助 (VNC)
 - 设置屏幕永不锁屏
 - 设置当前用户自动登录

### # 操作记录


#### 1.关闭 Ubuntu 的自动更新
打开系统设置，找到软件与更新
![软件与更新](https://i.loli.net/2019/06/19/5d09e8a2da99a21957.png)

然后找到Updates，做以下设置
![设置从不更新](https://i.loli.net/2019/06/20/5d0b335b850eb31316.png)
把能关的全部关掉


#### 2.关闭错误弹框
修改 /etc/default/apport 文件，
将 里面的 enable 的值从 1 改为 0 

``` shell
sudo vi /etc/default/apport
```

如图：
![enable 的值从 1 改为 0 ](https://i.loli.net/2019/06/20/5d0b34998728670194.png)


#### 3.安装设置 SaltStack
按照首先添加 SaltStack 仓库 
（我这里使用的是py3的版本）
``` shell
wget -O - https://repo.saltstack.com/py3/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
```

设置 SaltStack 的 apt 更新地址
``` shell
sudo bash -c 'echo "deb http://repo.saltstack.com/py3/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list'
```

之后更新一下 apt， 再进行安装 salt-minion 
``` shell
sudo apt-get update
sudo apt-get install salt-minion
```

设置一下 salt-master 的地址，
用于连接服务器
``` shell
sudo bash -c 'echo "master: 22.89.199.61" > /etc/salt/minion.d/set_master.conf'
```
注意将 ***22.89.199.61*** 替换成你的服务器 ip

最后重新启动一下 salt-minion 服务
``` shell
sudo systemctl restart salt-minion
```

有关 SaltStack 的详细配置，还请参照官网文档:
[SaltStack Package Repo](https://repo.saltstack.com/#ubuntu)

#### 4.安装设置 frpc

首先去 frp 项目仓库把 frp 的文件下载下来
[fatedier/frp](https://github.com/fatedier/frp)

拿到 frpc， frpc.ini, frpc.service 三个文件，
(因为主要是用在客户端，所以这三个就够了)

首先配置好frpc.ini,
server_addr 是你服务器的ip
hostname ，最好每一台机器都要设置不同的名字，
......
具体请看仓库的 README.md文件 里面有详细配置
``` text
[common]
server_addr = 22.89.199.61
server_port = 7000

[ssh-hostname]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 7070

[vnc-hostname]
type = tcp
local_ip = 127.0.0.1
local_port = 5900
remote_port = 7077
```

然后进行安装（一系列骚操作）：
``` shell
sudo cp frpc /usr/local/bin/
sudo mkdir -p /etc/frp
sudo cp frpc.ini /etc/frp/
sudo cp frpc.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start frpc
sudo systemctl enable frpc
```

#### 5.安装设置 Teamviewer
去 Teamviewer 官网下载 Teamviewer
[下载 Linux 版 TeamViewer](https://www.teamviewer.cn/cn/download/linux/)
安装之后，设置无人值守模式，设置独立密码。
![设置独立密码](https://i.loli.net/2019/06/20/5d0b3d3590da781854.png)


#### 6.开启 Ubuntu 远程协助 (VNC)
直接搜索 Desktop Sharing 就可
（我这里少打了字，谅解）
![20190620160312.png](https://i.loli.net/2019/06/20/5d0b3dc129d5f52327.png)

然后继续如下设置
  - 设置允许其他用户访问我的桌面
  - 允许其他用户控制我的桌面
  - 需要用户输入密码
  - 不显示通知栏图标

![20190620160452.png](https://i.loli.net/2019/06/20/5d0b3e28a5d2172554.png)


#### 7.设置屏幕永不锁屏
打开设置，找到
亮度和锁屏
![20190620160811.png](https://i.loli.net/2019/06/20/5d0b3eec745a880775.png)

将关闭屏幕的时间设置为 永不，
如图
![20190620161010.png](https://i.loli.net/2019/06/20/5d0b3f662cbde91107.png)


#### 8.设置当前用户自动登录
打开设置，找到
用户账户
![20190620161154.png](https://i.loli.net/2019/06/20/5d0b3fcb90cd365181.png)

然后解锁，输入密码，验证通过，开启自动登录
![20190620161541.png](https://i.loli.net/2019/06/20/5d0b40ae686d884191.png)

然后如图所示
![20190620161629.png](https://i.loli.net/2019/06/20/5d0b40dda31e153942.png)


待续。。。。

如有不对，还请多多指教。

-- Nick
-- 2019/06/20