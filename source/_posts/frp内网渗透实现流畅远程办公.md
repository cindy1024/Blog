---
title: frp内网渗透实现流畅远程办公
copyright: true
date: 2020-04-30 16:33:34
tags: 搜索
categories: 工具
---

疫情在家，需要远程连接机器，奈何家里网速不快，在笔记本上使用向日葵和teamviewer延迟严重，于是尝试了Windows自带的远程桌面（Microsoft Remote Desktop），配置较麻烦，但使用流畅。

<!-- more -->

Windows远程桌面依靠分发指令，Teamviewer依靠图像传输。Windows桌面通过RDP协议进行远程控制，不需要额外安装。RDP（Remote Desktop Protocol）是微软开发的基于连接远程计算机的协议。局域网内远程桌面较简单，见参考\[1][2]。外网远程桌面需要借助一个公网IP使用frp进行内网渗透。

## frp

[frp](<https://github.com/fatedier/frp>) 是一个可用于内网穿透的高性能的反向代理应用，支持 tcp, udp 协议，为 http 和 https 应用协议提供了额外的能力，且尝试性支持了点对点穿透。

### 部署架构

![](https://cdn.jsdelivr.net/gh/cindy1024/ImgBlog/img/architecture.png)
可以看出，我们需要在具有公网IP的机器上部署frps，在位于内网环境的被操控机器上部署frpc。

**个人部署环境**

- 具有公网IP的机器：一台阿里云学生机 Ubuntu
- 位于内网的物理机：一台或多台被远程操控的机器 Win10
- 用户机：一台笔记本 Win10

## 步骤

#### 在公网机器上

- 安装wget

  ```shell
  apt-get install -y wget
  ```

- 下载frp，解压并重命名

  ```shell
  wget https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_amd64.tar.gz
  tar -zxvf frp_0.33.0_linux_amd64.tar.gz
  mv frp_0.33.0_linux_amd64 frp
  ```

- 进入frp，修改配置frps.ini

  ```shell
  cd frp
  vim frps.ini
  ```

  frps.ini文件如下配置：

  ```ini
  [common]
  # 要绑定的端口
  bind_port = 7000
  # 安全授权 token，防止端口被扫描到后可以被任意客户端连接，可自己设置
  token = 12345678
   
  # 控制台的用户名
  dashboard_user = user
  # 控制台的密码
  dashboard_pwd = password
  # 控制台的端口
  dashboard_port = 7500
  ```

- 配置防火墙端口（阿里云ECS安全组规则）【注意】！！

  - 配置公网机器与被远程机器通信的bind_port端口
  - 配置公网机器与用户客户端机器通信的remote_port端口

  ![](https://cdn.jsdelivr.net/gh/cindy1024/ImgBlog/img/20200430160957.PNG)

- 给frp提权，运行frp

  ```shell
  sudo chmod -R 777 ~/frp 
  ./frps -c ./frps.ini
  ```

  运行成功会显示`Start frps success`，不要结束命令。如需进行其他操作，可使用screen命令创建多个会话。

#### 在物理机上

-  下载win10对应版本frp并解压

  https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_windows_amd64.zip

- 修改frpc.ini

  ```ini
  [common]
  # 公网IP
  server_addr = xxx.xxx.xxx.xxx
  # 服务器上设置的服务绑定端口(frps.ini 中的 bind_port)
  server_port = 7000
  # 安全授权 token，需与服务端设置一致（可自定义，可删去）
  token = 12345678
   
  [RDP] # 反向代理名称，可以随意设置，若设置多台物理机，此处需区别命名
  type = tcp
  local_ip = 127.0.0.1
  local_port = 3389
  # 外网访问的端口
  remote_port = 6000
  ```

  若设置多台机器，第二台机器可把`[RDP]`改为`[RDP1]`，把外网访问端口由`6000`改为`6001`。

- 开启远程桌面：“控制面板”——“系统”——“远程设置”——“允许远程连接至此电脑”。

  ![](https://cdn.jsdelivr.net/gh/cindy1024/ImgBlog/img/20200430155516.PNG)

- cmd命令进入frp文件夹，运行如下命令：

  ```
  frpc.exe -c frpc.ini
  ```

  运行成功会显示`start proxy success`，不要结束cmd命令窗口。

#### 在用户机上

- 设置打开远程桌面：“设置”——“远程桌面”——“开“

  ![](https://cdn.jsdelivr.net/gh/cindy1024/ImgBlog/img/20200430160135.PNG)

- 连接远程桌面

  输入`公网IP:外网访问的端口`，输入被远程控制机器的系统用户名和密码。若远程操作多台机器，登录时需改变端口和用户名密码。

![](https://cdn.jsdelivr.net/gh/cindy1024/ImgBlog/img/捕获.PNG)

​	

## 使用感受

- 日常操作速度：Windows远程桌面>TeamViewer
- 传文件使用Teamviewer的file transfer更方便

- Windows远程桌面打开Matlab报错：`MATLAB cannot be started through terminal services`，可修改license，见[6]。
- 对于CloudCompare软件，Windows远程桌面无法打开，可用teamviewer。

## Reference

[1] [WIN10远程控制（局域网）](<https://blog.csdn.net/weixin_43210530/article/details/92837975>)

\[2] [怎样远程控制局域网的另一台电脑（远程桌面）windows10](<http://blog.sina.com.cn/s/blog_c54883470102vzwy.html>)

\[3] [使用 FRP 实现在家远程桌面到公司内网进行远程办公](<https://lzw.me/a/frp-windows-mstsc.html>)

\[4] [windows下基于frp的内网穿透部署](<https://zhuanlan.zhihu.com/p/55306067>)

\[5] [FRP内网穿透转发Windows远程桌面端口 详细教程](<https://www.atsurak.com/frp-windows-rdp/>)

[6] [如何远程登录Windows服务器或者主机，并使用主机上的Matlab？](<https://www.zhihu.com/question/273691032>)