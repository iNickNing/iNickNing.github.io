---
title: WEB-给自己所有的域名加上HTTPS
id: article20190703030931
date: 2019-07-03 11:09:31
categories: 学习记录
tags: 
  - Linux
  - Ubuntu
  - Nginx
  - HTTPS
---

### # 背景
在 **HTTPS** "强行"推广之后,
几乎所有的浏览器都会对没有 **HTTPS** 的网站进行报警,
其次是为了装比,
但是在阿里云的免费 **SSL证书** 服务有申请次数限制,
所以,就找了一些免费签发 **SSL证书** 的网站,
其中 **Let's Encrypt** 最适合我(这种白嫖怪).

<!--more-->

### # 环境
最开始先把我的环境说一下,
免得后面环境出问题.

系统: Ubuntu 16.04
Web服务: Nginx
证书签发: Let's Encrypt
签发脚本: certbot


### # 操作步骤
#### 先了解一下 Let's Encrypt
Let's Encrypt是一个于2015年三季度推出的数字证书认证机构，
旨在以自动化流程消除手动创建和安装证书的复杂流程，
并推广使万维网服务器的加密连接无所不在，
为安全网站提供免费的SSL/TLS证书。

当然这里是我从百度百科抄过来的

我主要说一下几个注意的点:
  - 可以免费申请
  - 但是使用时长只有90天
  - 可以使用脚本一键申请,部署,续签


#### 添加 Certbot PPA 
这就是上面所说到的脚本工具,
应该是 **Let's Encrypt** 的御用脚本
因为我是在它官网找到的

我们在终端输入:
``` shell
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
```

#### 安装 certbot
因为我这里的Web服务是使用 **Nginx** 的
所以我需要额外安装的是 **python-certbot-nginx** 

在终端输入:
``` shell
sudo apt-get install certbot python-certbot-nginx 
```


#### 运行 certbot 
这里我需要啰嗦一下,
我执行的这个命令是可以一键配置好的,
**但是,但是,但是,你要提前做好一下这些事**
  - 关闭 **Nginx** 服务,免得配置时端口占用出错
  - 自己在 **/etc/nginx/conf.d/** 目录下创建好基本的配置文件

基本的配置文件,例如:
``` conf
server {
    listen 80;
    server_name test.inick.top;

    location / {
        root /home/xxx/test;
        index index.php index.html index.htm;
    }
}
```
然后现在开始运行certbot
开始设定你的配置

``` shell
sudo certbot --nginx
```
执行之后,它会把你当前所有配置的网址列出来,例如:
![20190703125919.png](https://i.loli.net/2019/07/03/5d1c362a53a1968997.png)

这里我选择 5 
然后回车
刷刷刷,然后问我要不要设置,
将 **HTTP** 请求强转 **HTTPS**
我懒得改了,直接选择 2(转发) 回车

![20190703130052.png](https://i.loli.net/2019/07/03/5d1c36858b12087848.png)

再刷刷刷,成功了.
![20190703130339.png](https://i.loli.net/2019/07/03/5d1c372b749f646017.png)


#### 最后重启一下 Nginx
现在去重启一下 **Nginx**
``` shell
sudo systemctl restart nginx
```

接下来访问一下我的网站~
![20190703131117.png](https://i.loli.net/2019/07/03/5d1c38f56336a78759.png)

看起来还不错,绿色的小锁很养眼.

### # 附录

这里放上相关的网址吧
Let's Encrypt: https://letsencrypt.org/
certbot: https://certbot.eff.org/
certbot github 地址: https://github.com/certbot/certbot


PS:
  如有错误,还请多多指出来~

-- Nick
-- 2019/07/03

