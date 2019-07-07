---
title: 一行代码-Js简单消息弹框
id: article20190707094322
date: 2019-07-07 17:43:22
categories: 学习记录
tags: 
  - JavaScript
  - 一行代码
---

### # 背景
写页面的时候想要弄一个弹框，
因为懒得用layui那些组件框架，
所以自己刷刷刷，弄了一个，很简单。

<!--more-->

### # 开始编写

#### 显示效果

调用方法

``` JavaScript
showPopup("弹框");  /* 直接平常调用就好 */
```

![20190707182036.png](https://i.loli.net/2019/07/07/5d21c776f2c9821671.png)


#### 编写CSS代码

首先样式代码写上：

``` css
/* popupBox start */
#popupBox {
    position: fixed;
    top: calc(50% - 20px);
    left: calc(50% - 80px);
    height: 40px;
    width: 160px;
    background-color: rgba(0, 0, 0, 0.8);
    color: #fff;
    font-size: 16px;
    line-height: 40px;
    text-align: center;
    border-radius: 10px;
    transition: 0.5s;
    opacity: 0;
    z-index: 3;  /* 这里根据你的层级来改 */
}
/* popupBox end */
```


#### 编写 JavaScript 代码

然后写个方法调用

``` JavaScript
/**
 *
 * str： 用于显示的消息
 *
 */
function showPopup(str) {
    var popupBox = document.getElementById("popupBox");
    if(popupBox == null || popupBox == undefined) {
        popupBox = document.createElement("div");
        popupBox.id = "popupBox";
        document.body.appendChild(popupBox);
    }

    popupBox.innerText = str;
    popupBox.style.opacity = "1";
    setTimeout(function() {
        popupBox.style.opacity = "0";
    }, 1000);
}
```

#### 注意

我这里只是简单的设置了宽度，
所以应该最多只能显示5个汉字，
可以自己修改为根据字符宽度显示。


PS:
  如有错误,还请多多指出来~

-- Nick
-- 2019/07/03
