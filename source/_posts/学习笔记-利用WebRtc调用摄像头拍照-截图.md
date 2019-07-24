---
title: 学习笔记-利用WebRTC调用摄像头拍照(截图)
id: article20190724040422
date: 2019-07-24 12:04:22
categories: 学习记录
tags:
  - JavaScript
  - WebRTC
  - canvas
---

### # 背景
在写浏览器调用摄像头进行人脸识别的时候,
需要获取关键帧进行扫描解析,
刚好,写了一个获取摄像头图像的Demo,
放上来一起分享

<!--more-->

### # 运行原理
过程比较简单,
我就直接简单概述一下

流程:
  - 1. 利用 **WebRTC** 调用摄像头
  - 2. 将 WebRTC 获取到的 视频流 传送到 **video** 标签
  - 3. 利用 **requestAnimationFrame** 方法,定时将画面同步到 **canvas** 标签
  - 4. 点击按钮的时候,直接从 canvas 元素获取当前画面的 **base64** 数据,利用方法 **toDataURL**
  - 5. 将 base64 数据展示到 **img** 标签

### # 代码
我直接将代码文件放到我群里: 492781269
可以加群下载

![20190724121621.png](https://i.loli.net/2019/07/24/5d37db9667ec566159.png)

下面还是贴一下完整的代码吧:

``` HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>调用摄像头截图拍照(WebRtc-video-canvas-img)</title>
</head>
<body>
    <div id="videoBox">
        <video src="" id="myVideo" autoplay="autoplay"></video>
        <canvas id="output" style="display: none"></canvas>
        <button id="myButton">截图(拍照)</button>
        <img id="myImg" src="" alt="">
    </div>

    <script>
    
        const myVideo =  document.querySelector("#myVideo");
        const myCanvas = document.querySelector("#output");
        const ctx = myCanvas.getContext("2d");
        const myButton = document.querySelector("#myButton");
        const myImg = document.querySelector("#myImg");


        // 获取canvas当前画面的base64
        function getCanvasBase64() {
            return myCanvas.toDataURL("image/jpeg", 1); 
        }

        // canvas 实时刷新显示
        function canvasFrame() {
            ctx.drawImage(myVideo, 0, 0, myCanvas.width, myCanvas.height);

            requestAnimationFrame(canvasFrame);
        }

        // 调用摄像头
        function setupCamera() {
                
            let exArray = [];
            //web rtc 调用摄像头(兼容性写法(谷歌、火狐、ie))
            navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
            
            //遍历摄像头
            navigator.mediaDevices.enumerateDevices()
            .then(function (sourceInfos) {
                for (var i = 0; i < sourceInfos.length; ++i) {
                    if (sourceInfos[i].kind == 'videoinput') {
                        exArray.push(sourceInfos[i].deviceId);
                    }
                }
            })
            .then(() => {
                // 因为我这里是有三个摄像头,我需要取最后一个摄像头
                let deviceId = exArray[exArray.length - 1];  // 取最后一个摄像头,(深度,灰度,RGB)

                navigator.mediaDevices.getUserMedia({
                    audio: false, 
                    video: { 
                        deviceId: deviceId
                    } 
                }) 
                .then(stream => {  // 参数表示需要同时获取到音频和视频
                    // 获取到优化后的媒体流
                    myVideo.srcObject = stream;
                    myVideo.onloadedmetadata = () => {
                        myVideo.width = myVideo.offsetWidth;
                        myVideo.height = myVideo.offsetHeight;
                        myCanvas.width = myVideo.width;
                        myCanvas.height = myVideo.height;
                        canvasFrame();
                    };
                    
                })
                .catch(err => {
                    // 捕获错误
                    console.log
                });
            });
        }

        // 点击按钮截图(拍照)
        myButton.addEventListener('click', () => {
            let imageBase64 = getCanvasBase64();
            myImg.src = imageBase64;
        });

        // 载入之后就开始调用一下摄像头
        window.addEventListener('load', () => {
            setupCamera();
        });

    </script>
</body>
</html>

```



PS:
  如有错误,还请多多指出来~

-- Nick
-- 2019/07/22

