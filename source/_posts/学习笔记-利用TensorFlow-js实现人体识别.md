---
title: 学习记录-利用TensorFlow.js实现人体识别
id: article20190722030503
date: 2019-07-22 11:05:03
categories: 学习记录
tags:
  - JavaScript
  - TensorFlow.js
  - 机器视觉
---

### # 背景
一直在弄机器视觉,
关于人体识别方面的东西,
偶然发现 TensorFlow.js 的一个模型
PoseNet Model
有趣的事情就从此开始了

<!--more-->
### # 环境信息
首先将我的开发环境介绍一下
摄像头: RGB摄像头就可以
系统: Ubuntu 16.04
浏览器: Chrome Version 75.0.3770.100 (Official Build) (64-bit)
~~Node.js: 10.16.0~~
~~yarn: 1.17.3~~
~~npm: 6.9.0~~

我好像直接是写在HTML里面,所以不需要Nodejs环境

### # 码代码

发现在官方的仓库已经有完整的代码和教程,
我就不放了
这是地址: https://github.com/tensorflow/tfjs-models/tree/master/posenet

### # 参考资料: 
用TensorFlow.js实现人体姿态估计模型（上）:https://www.jianshu.com/p/b0bcedd88a8e

### # 我的代码
任何不能复现的技术博客都是扯淡,
我把我的代码放一下吧,
也可以直接加群: 492781269
群文件里有
![20190722113903.png](https://i.loli.net/2019/07/22/5d352fd84b8b024659.png)

然后下面放全部的代码:
``` HTML

<html>
    <head>
      <!-- Load TensorFlow.js -->
      <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs"></script>
      <!-- Load Posenet -->
      <script src="https://cdn.jsdelivr.net/npm/@tensorflow-models/posenet"></script>
      <style>
            
            #videoBox {
                min-width: 100%;
                min-height: 100%;
                position: absolute;
                top: 0;
                left: 0;
            }
            #myVideo {
                min-width: 100%;
                min-height: 100%;
                position: absolute;
                transform: scaleX(-1);
                
            }
            #output {
                position: absolute;
                z-index: 3;
            }
      </style>
    </head>
  
    <body>
        <div id="videoBox">
            <video src="" id="myVideo" autoplay="autoplay"></video>
            <canvas id="output" ></canvas>
        </div>
        
        <h1 id="myTitle">loading model......</h1>
    </body>

    <script>

        const myVideo =  document.querySelector("#myVideo");
        const myCanvas = document.querySelector("#output");
        const ctx = myCanvas.getContext('2d');
        var net = {};

        posenet.load()
        .then((net1) => {
            document.querySelector("#myTitle").style.display = "none";
            net = net1;
            setupCamera();
        })

        function poseDetectionFrame() {

            net.estimateSinglePose(myVideo, {
                flipHorizontal: true  // 目前单人模式,多人模式的设置 参考官方例程
            })
            .then((pose) => {
                let score = pose.score;
                let keypoints = pose.keypoints;
                if (score >= 0.2) {
                    ctx.clearRect(0, 0, myCanvas.width, myCanvas.height);
                    for (let i = 0; i < keypoints.length; i++) {
                        const keypoint = keypoints[i];
                        
                        if(keypoint.score > 0.1) {
                            
                            const {y, x} = keypoint.position;
                            drawPoint(ctx, y, x, 10, "red");
                        }
                    }
                }
            });
  
            requestAnimationFrame(poseDetectionFrame);

        }

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
                        poseDetectionFrame();
                    };
                    
                })
                .catch(err => {
                    // 捕获错误
                    console.log
                });
            });
        }
        
        function drawPoint(ctx, y, x, r, color) {
            ctx.beginPath();
            ctx.arc(x, y, r, 0, 2 * Math.PI);
            ctx.fillStyle = color;
            ctx.fill();
        }
  
    </script>
  </html>
```


PS:
  如有错误,还请多多指出来~

-- Nick
-- 2019/07/22
