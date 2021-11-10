---
layout: post
title: Ubuntu-18.4修改IP地址方法
category: 工具
tags: Ubuntu
keywords: Ubuntu
---
## 最新发布的ubuntu18.04 server，启用了新的网络工具netplan，对于命令行配置网络参数跟之前的版本有比较大的差别，现在介绍如下：

1. 其网络配置文件是放在/etc/netplan/50-cloud-init.yaml, 缺省是用dhcp方式，如果要配置静态地址，则需要修改此文件的想关内容，
见如下的例子：

        network:
        ethernets:
        ens33:
        addresses: [192.168.1.20/24]
        dhcp4: false
        gateway4: 192.168.1.1
        optional: true
        version: 2
        
2. 使其生效的方法：

        sudo netplan apply
        
如果配置有问题会报错，如果没问题，则会新的配置会立即生效。

 **注意**  本帖子只是**针对ubuntu18.04 Server**版，对于18.04 desktop它缺省是使用NetworkManger来进行管理，可使用图形界面进行配置，
其网络配置文件是保存在：/etc/NetworkManager/system-connections目录下的，跟Server版区别还是比较大的。

netplan 工具还有其它比较丰富的功能，详细可参见其的说明文档，man netplan.