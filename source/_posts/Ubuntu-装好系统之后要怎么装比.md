---
title: Ubuntu-装好系统之后要怎么装比
id: article20190622061839
date: 2019-06-22 14:18:39
categories: 学习记录
tags:
  - Linux
---

### # 背景
因为我总是时不时的就会把电脑重装，
重装系统之后又需要装很多环境，
装很多软件，时不时还找不到，忘记了。
所以，在这里记录一下。

<!--more-->

### # 任务列表
  - 替换 APT 源为清华源
  - 安装 exFat-utils
  - 安装 deepin-wine-for-ubuntu
  - 安装 deepin-qq 和 deepin-wechat
  - 安装 sogou输入法for Linux
  - 安装 Chrome 和 VSCode
  - 安装 NVIDIA 驱动（非N卡不需要）
  - 美化 Ubuntu （这里不做介绍了）
  - 登录 QQ ，开始截图装比

### # 操作记录

#### 1.替换 APT 源为清华源
因为感觉 Ubuntu 自己带的源 update 时太耗时间，
所以琢磨这换掉他的 APT 源。

第一步，将原来的源列表备份一下，以后有问题好恢复
（虽然一般不会用）
命令行输入：
``` shell
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```

然后编辑源列表文件，我使用的是 gedit 打开，Ubuntu 自带的编辑工具
命令行输入：
``` shell
sudo gedit /etc/apt/sources.list
```

然后把里面的东西全部删掉，把下面的源列表粘贴进去：
``` shell
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
```

最后记得 update 一下
``` shell
sudo apt-get update
```


我的 Ubuntu 的版本是 16.04 的，
所以上面我用的是 16.04 的版本的源，
具体可以根据 Linux 系统的版本来进行更换的。
下面是参考链接：
[清华大学开源软件镜像站 Ubuntu 镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/)


#### 2.安装 exFat-utils
因为我的移动硬盘的格式是 exFat 格式的，
所以我在这需要安装一下相对应的工具

直接执行命令 
``` shell
sudo apt-get install exfat-utils
```
跑完就可以了

#### 3.安装 deepin-wine-for-ubuntu
需要在 Ubuntu 里面登录QQ是一件麻烦的事，
因为官方并没有开发 Linux 版本的QQ，
不过还好，因为 Deepin 系统做了一个兼容 Linux 系统的 QQ，
然后又有热心的小伙伴把 Deepin 系统中的 wine 提取出来，
于是出现了 deepin-wine-for-ubuntu 项目，
这样子就可以在 Ubuntu 里面安装 QQ 啦~
下面开始：

首先从 github 或者 码云 上面去把这个项目 clone 下来，或者下载下来，
这里推荐下载 zip 包吧，因为还没有装 git
地址分别是：
https://gitee.com/wszqkzqk/deepin-wine-for-ubuntu
https://github.com/wszqkzqk/deepin-wine-ubuntu

进去之后找到 Clone and download 或者 克隆/下载
进行下载
![20190622144728.png](https://i.loli.net/2019/06/22/5d0dcf01eb23756592.png)
或者
![20190622144758.png](https://i.loli.net/2019/06/22/5d0dcf204757d67543.png)

下载解压之后，
进去解压的文件夹，
在文件夹中打开终端，输入sudo ./install.sh一键安装。
``` shell
sudo ./install.sh
```
就可以了。

后面就可以安装相对应的应用容器了，
例如QQ，微信，

附上下载地址
QQ：http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.qq.im/
微信：http://mirrors.aliyun.com/deepin/pool/non-free/d/deepin.com.wechat/
总仓库地址：http://mirrors.aliyun.com/deepin/pool/non-free/d/


#### 4.安装 deepin-qq 和 deepin-wechat
上面已经有下载地址了，
耳麦直接进入下载目录，
在文件夹中打开终端，输入命令进行安装
``` shell
sudo dpkg -i deepin.com.qq.im_8.9.19983deepin23_i386.deb
sudo dpkg -i deepin.com.wechat_2.6.2.31deepin0_i386.deb

```
当然具体看你下载的版本了。


#### 5.安装 sogou输入法for Linux
用不习惯 Ubuntu 自带的输入法，
然后发现 搜狗输入法 有 Linux 版本的，
所以就去官网下载了，
下载下来之后直接 使用

> sudo dpkg -i 文件名

进行安装
如果遇到安装出错了（十有八九这里会出错）
执行一下命令,修复依赖
``` shell
sudo apt install -f
```
然后再执行安装程序

到这里到一段落，
但是我们现在是看不到选项的，
我们还需要进行设置一番。

首先找到设置 --> 语言支持
> 这里是图片,以后补上

将系统输入法系统 改为:fcitx
> 这里是图片,以后补上

保存退出,然后重启
重启之后
点击输入法(状态栏的小企鹅),
然后弹出菜单,选择配置 Fcitx,
在 Fcitx 界面点击左下角的 + 号
然后在列表里面找到刚刚安装的
sogou(搜狗)输入法, 选择,确定
如果没有找到,注意不要勾选仅显示当前语言.

然后关闭退出,
就可以看到可以切换搜狗输入法了


#### 6.安装 Chrome 和 VSCode
这两个简单,因为我比较常用这两个软件,
所以我就把他们加进来了
下面放上他们两个的下载页面地址:
Chrome: https://www.google.cn/chrome/
VSCode: https://code.visualstudio.com/

下载时候,在下载文件夹打开终端
执行
``` shell
sudo dpkg -i 文件名
```
就好了


#### 7.安装 NVIDIA 驱动（非N卡不需要）
首先去 apt-cache 看一下最新的驱动是什么

``` shell
apt-cache search nvidia
```

然后会出现一大堆的列表,
在里面看一下,有哪些

当前最新的好像是 430 的版本了,
我为了稳一点,
还是安装的原来的 384
然后在终端输入安装就好了

``` shell
sudo apt-get install nvidia-384
```

如果遇到出错了
执行一下命令,修复依赖
``` shell
sudo apt install -f
```
再进行安装.

等他刷完,就好了.
然后重启,OK.


#### 8.美化 Ubuntu
以前安装好之后都会去美化一下,
后来随着重装的次数变多了,
就没继续.
下面推荐一个文章,
可以进去根据他的教程进行设置

[不美翻怎么开发!Ubuntu 16.04 LTS深度美化!](https://www.jianshu.com/p/4bd2d9b1af41)


#### 9.登录 QQ ，开始截图装比
登录QQ,开始截图,
然后发给小伙伴们,
让他们羡慕一下你这美轮美奂的系统吧~



PS：
如有遗漏，或者错误的地方，还请多多指出。

-- Nick
-- 2019/06/22
