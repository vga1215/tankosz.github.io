---
layout: post
title: Gentoo系统安装
category: 工具
tags: Gentoo
keywords: Gentoo
description: Gentoo,面朝大海，春暖花开
---
###Gentoo,面朝大海，春暖花开###

#Handbook refence https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation

安装gentoo步骤：
装备工具：U盘，UltraISO，install-amd64-minimal-20160414.iso，
stage3-amd64-20160414.tar.bz2 后面两文件为64位最新版本

用UltrsISO把install.iso文件刻录进U盘，然后把stage3拷贝到U盘

用U盘启动系统,进入boot:gentoo-nofb,画面过后键盘选defualt
If no selection is made in 10 seconds the default (US keyboard)
b44 ssb0:0 eth0

livecd ~ modprobe 8139    #加载8139网上模块(可选）

livecd ~ passwd    #更改root密码

livecd ~ vi /etc/ssh/sshd_config   #修改权限可以用root有登入
修改文件 sshd_config  PermitRootLogin yes
livecd ~ /etc/init.d/sshd start

配置网络：
livecd ~ ifconfig  #查看网卡信息
#手动添加固定IP
livecd ~ ifconfig eth0 ${IP_ADDR} broadcast ${BROADCAST} netmask ${NETMASK} up  
#加路由
livecd ~ route add default gw ${GATEWAY}
#加DNS
livecd ~ vi /etc/resolv.conf
nameserver ${NAMESERVER1}
nameserver ${NAMESERVER2}
#上面步骤完成后，可以远程用SSH进入此电脑配置后面工作
bnx2.kobnx2x/bnx2x.ko cnic.ko ta3.ko
硬盘分区：
livecd ~ fdisk -l  #查看硬盘情况，一般看/dev/sda
livecd ~ parted -a optimal /dev/sda #用parted工具进行硬盘分区
(parted)mklabel gpt #用GPT卷进行分区列表管理，如装系统用fdisk分区用MBR卷
(parted)print  #查看分区情况
(parted)rm 2   #删除第2个分区，其它分区删除也可以用这个命令
(parted)unit mib  #设置分区单位MB
(parted)mkpart primary 1 3 #制作分区分配2MB
(parted)name 1 grub #设置序号和分区名
(parted)set 1 bios_grub on #设置flags标志名
(parted)mkpart primary 3 131
(parted)name 2 boot
(parted)mkpart primary 131 2179
(parted)name 3 swap
(parted)mkpart primary 2179 -1   #这行为2179至硬盘剩余的所有空间
(parted)name 4 rootfs
(parted)set 2 boot on #第二个分区也是on
(parted)print

Number  Start    End        Size       File system     Name    Flags
 1      1.00MiB  3.00MiB    2.00MiB                    grub    bios_grub
 2      3.00MiB  131MiB     128MiB     ext2            boot    boot, esp
 3      131MiB   2179MiB    2048MiB    linux-swap(v1)  swap
 4      2179MiB  305244MiB  303065MiB  btrfs           rootfs

创建分区文件系统：
livecd ~ mkfs.ext2 /dev/sda2
livecd ~ mkfs.btrfs /dev/sda4  #这里我用了btrfs文件系统
livecd ~ mkswap /dev/sda3  #创建swap分区
livecd ~ swapon /dev/sda3  #激活swap分区

挂载分区至文件系统:
livecd ~ mount /dev/sda4 /mnt/gentoo  #前面是硬件分区，后面是文件系统
livecd ~ mkdir /mnt/gentoo/boot
livecd ~ mount /dev/sda2 /mnt/gentoo/boot
livecd ~ mkdir /mnt/gentoo/usb     #下面三行是挂载U盘，然后把stage3文件
#拷贝到/mnt/gentoo目录下
livecd ~ mount /dev/sdb4 /mnt/gentoo/usb
livecd ~ cp /mnt/gentoo/usb/stage3-amd64-20160414.tar.bz2 /mnt/gentoo

安装基本系统包stage
livecd~ date 052141532016    #用MMDDhhmmYYYY(月日小时分钟年)语法设置
livecd~ cd /mnt/gentoo
livecd~ tar xvjpf stage3-*.tar.bz2 --xattrs #解压STAGE3至当前目录
#上面解压后有一个基本的根目录环境，但很有配置文件没有配置*****

配置编译选项：
livecd~ vi /mnt/gentoo/etc/portage/make.conf
# These settings were set by the catalyst build script that automatically
# built this stage.
# Please consult /usr/share/portage/config/make.conf.example for a more
# detailed example.
CFLAGS="-march=native -O2 -pipe"
CXXFLAGS="${CFLAGS}"
# WARNING: Changing your CHOST is not something that should be done lightly.
# Please consult http://www.gentoo.org/doc/en/change-chost.xml before changing.
CHOST="x86_64-pc-linux-gnu"
MAKEOPTS="-j3"
# These are the USE flags that were used in addition to what is provided by the
# profile used for building.
USE="bindist mmx sse sse2 X consolekit dbus pam policykit udev udisks upower qt4
PORTDIR="/usr/portage"
DISTDIR="${PORTDIR}/distfiles"
PKGDIR="${PORTDIR}/packages"
IPUT_DEVICES="keyboard mouse synaptics"
VIDEO_CARDS="intel"
LINGUAS="zh_CN"
#上面为我64位系统配置

Chrooting（把ROOT的环境慢慢从U盘转到硬盘）
#选择gentoo镜像文件列表并写到make.conf文件中
livecd~ mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf
#第二步在上一步选择的镜像文件中配置gentoo版本库
#通过这个文件/etc/portage/repos.conf/gentoo.conf的说明去配置
livecd~ mkdir /mnt/gentoo/etc/portage/repos.conf
livecd~ cp /mnt/gentoo/usr/share/portage/config/repos.conf
/mnt/gentoo/etc/portage/repos.conf/gentoo.conf
#复制DNS信息
livecd~ cp -L /etc/resolv.conf /mnt/gentoo/etc/
#挂载必要的文件系统，这里开始root就要迁移到新的位置(硬盘sda4),在些之前
#要确保新的环境正确配置，一些文件系统在新环境下可用
livecd~ mount -t proc proc /mnt/gentoo/proc   #前面prco是文件类型
livecd~ mount --rbind /sys /mnt/gentoo/sys    #递归挂载
livecd~ mount --make-rslave /mnt/gentoo/sys
#递归的改变一个挂载点及其下的所有子挂载点的传播类型标记
livecd~ mount --rbind /dev /mnt/gentoo/dev
livecd~ mount --make-rslave /mnt/gentoo/dev

进入新的环境（三步）
livecd~ chroot /mnt/gentoo /bin/bash
livecd~ source /etc/profile
export PS1="(chroot) $PS1"

配置Portage
# emerge-webrsync
# emerge --sync
# eselect profile set 1   用默认系统配置文件OpenRC

更改时区
# echo "Asia/Shanghai" > /etc/timezone
# emerge --confg sys-libs/timezone-data

# emerge vim  

# vim /etc/env.d/02locale 

#env-update && source /etc/profile && export PS1="(chroot) $PS1"

手动开始编译内核
# emerge --ask sys-kernel/gentoo-sources
# ls -l /usr/src/linux       #显示内核版本

# emerge --ask sys-apps/pciutils     #安装 手动编译内核工具
# cd /usr/scr/linux
# make menuconfig    #手动选需要编译的模块（硬件驱动）
# make $$ make modules_install #开始编译内核（*****此过程十分漫长******）
# make install   #把编译好的软件复制到/boot/.下面

#emerge --ask sys-kenrnel/genkernel    #安装自动编译内核工具
#genkernel --install initramfs         #安装基于内存启动的文件系统


3945abg  b44
配置fstab自动挂载分区（硬件）到文件系统：

 虽然是3年前的问题的，但也许还是有别人不知道

操作流程如下

1、查看所有已安装的版本(带*的是当前默认版本)

eselect python list
Available Python interpreters:
  [1]   python2.7 *
  [2]   python3.3
  [3]   python3.4

2、更改成自己想要的版本，这个2就是上面python3.3的序号

eselect python set 2

3、再次执行以下命令，发现变了

eselect python list 

因为网卡问题折腾一天：网卡驱动能装好，开机系统识别不了，要手动，查了好多方法没解决
自己写了一个脚本开机运行：
1.ln -s /bin/ifconfig /sbin/ifconfig
2.ln -s /bin/route /sbin/route
3.cd /etc/local.d 建两个启动文件 eth0.start   和 route.start
eth0.start:
/sbin/ifconfig eth0 192.168.1.202 broadcast 192.168.1.255 netmask 255.255.254.0
up
route.start
/sbin/route add default gw 192.168.1.213
问题解决


)

--------------------

>**Note:**
