---
title: >-
  问题解决-RPC failed; HTTP 413 curl 22 The requested URL returned error: 413 Request Entity Too Large
id: 'article2019-07-19 09:16:25'
date: 2019-07-19 17:16:25
categories: 问题解决
tags:
  - git
  - http
  - nginx
---

### # 背景

在创建了一个新项目,
打算将它上传到自己的git服务器时,
报错了:
error: RPC failed; HTTP 413 curl 22 The requested URL returned error: 413 Request Entity Too Large

<!--more-->

### # 查找问题

#### HTTPS的原因吗? x

最开始我以为是我的 Gogs 的设置错了,
因为我原来一直是 http 来进行push的
这次我更新了站点的协议,全部变成了 https
可能是这个,然后我去 Gogs 的配置文件,进行修改

  > {gogs根目录}/custom/conf/app.ini 
 
修改了服务请求的网址,然后加上了 https 证书

``` shell
ROOT_URL         = https://****
CERT_FILE = /******/cert.pem
KEY_FILE = /******/key.pem
```

重启服务
``` shell
sudo systemctl restart gogs
```

然而,还是报错.


#### 采用 SSH 尝试推送 O

记起来我以前为了方便都是使用 SSH 进行推送的,
从没有遇到这个错误,
这次使用的协议不一样,我试试用 SSH ,
刷刷刷...

添加 公钥
修改git远程仓库
推送
....

行云流水,问题解决,
不对,没有解决,这是在逃避问题.


#### 也许是代理的问题? O

看到报错的最后几个单词,
请求实体太大了???
这个错误有点眼熟,
在很久以前做文件存储服务时候遇到过,
大文件一直上传不来,
当时是 Nginx 进行代理的,

一下子记起来了,需要设置一下 Nginx 的配置文件,
这次因为太匆忙没有设置.

关键字应该是:

``` config
client_max_body_size 128m;
```

问题应该解决!!


### # 问题原因

因为 Nginx 的 client_max_body_size 默认大小只有 1M
而我要上传的文件超过了 1M 
太大了,结果直接报错,不干活.


### # 问题解决

找到问题就简单了,
两步解决:

#### 修改 Nginx 配置文件


#### 重启 Nginx





