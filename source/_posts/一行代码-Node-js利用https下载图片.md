---
title: 一行代码-Node.js利用https下载图片
id: article20190709041522
date: 2019-07-09 12:15:22
categories: 学习记录
tags: 
  - JavaScript
  - 一行代码
  - Node.js
---

### # 背景
在练习使用 https 模块进行请求页面的时候,
突然想到除了下载页面,
应该还可以下载图片.

<!--more-->

### # 开始编写

#### 用到的模块

> https
> fs


#### Node.js 代码
其中的图片url,
保存路径需要自己设置一下.
很简单就没有加注释了

``` Node.js
const https = require('https');
const fs = require('fs');

var url = 'https://www.baidu.com/img/bd_logo1.png';

https.get(url, (res) => {

    var imgData = "";
    res.setEncoding("binary");  // 下载图片需要设置为 binary, 否则图片会打不开

    res.on('data', (chunk) => {
       imgData+=chunk;
    });

    res.on('end', () => {
        fs.writeFileSync("./download.png", imgData, "binary");
        console.log('ok');
    });
});
```


PS:
  如有错误,还请多多指出来~

-- Nick
-- 2019/07/09



