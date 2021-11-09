---
layout: post
title: FreeBSD系统命令
category: 工具
tags: FreeBSD
keywords: FreeBSD
description: FreeBSD
---

###FreeBSD系统命令类###
显示端口状态

{% highlight bash %}
sockstat -l4       
{% endhighlight %}

###FreeNAS相关类###
- 删除后缀为exe文件 
{% highlight bash %}
find /mnt/CIFS/Public/ENG/Drawing -name '*.exe' -print -exec rm -rf {} \;
{% endhighlight %}
- 禁止后缀为exe文件写入，修改gui中cifs共享中文件夹属性：Auxiliary Parameters
{% highlight bash %}
veto files = /*.exe/ 
{% endhighlight %}
------------
ZFS(Zettabyte File System)作为一个全新的文件系统，全面抛弃传统File System +
Volume Manager + Storage(文件系统+卷管理+存储)的架构，所有的存储设备是通过ZFS
池进行管理，只要把各种存储设备加 入同一个ZFS 池，大家就可以轻松的在这个ZFS
池管理配置文件系统。

　　ZFS
包括一系列具有分层结构的存储元素，其中既有物理存储元素，又有逻辑存储元素。所有这些元素都以有助于方便管理的方式相关联。如下图，是ZFS文件系统与传统文件系统的对比。


图1 ZFS文件系统与传统文件系统的对比图

　　一、为Linux服务器配置安装ZFS文件系统

　　(1) 为rhel 配置EPEL repo

　　如果既想获得 RHEL
的高质量、高性能、高可靠性，又需要方便易用(关键是免费)的软件包更新功能，那么
Fedora Project 推出的 EPEL(Extra Packages for Enterprise
Linux)正好适合你。EPEL(http://fedoraproject.org/wiki/EPEL) 是由 Fedora
社区打造，为 RHEL 及衍生发行版如 CentOS、Scientific Linux
等提供高质量软件包的项目。装上了 EPEL，就像在 Fedora 上一样，可以通过 yum
install package-name，随意安装软件。安装 EPEL 非常简单：

　　RHEL 6 系列使用：

　　# rpm -Uvh
http://download.fedora.redhat.com/pub/epel/beta/6/i386/epel-release-6-1.noarch.rpm

　　RHEL 5 系列使用：

　　#rpm -Uvh
http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-3.noarch.rpm

　　(2)安装zfs-fuse模块

　　# yum install zfs-fuse

　　(3)从源代码安装

　　如果要源代码安装首先安装如下模块：

　　su -c "yum install -y fuse-devel libattr-devel libaio-devel libacl-devel
zlib-devel fuse-devel scons openssl-devel"

　　然后下载http://zfs-fuse.net/releases/0.6.9/zfs-fuse-0.6.9.tar.bz2

　　#/configure;make;make install

　　加载zfs内核模块

　　#modprobe zfs

　　二、 在Linux服务器上使用ZFS文件系统

　　1了解zfs管理命令

　　Zfs命令包括一组子命令主要如下：

　　create 创建zfs文件系统

　　destroy 摧毁一个ZFS文件系统

　　snapshot 建立一个文件系统的快照

　　rollback 从一个文件系统的快照中恢复

　　clone 建立一个文件系统的克隆

　　promote 从一个克隆创建一个文件系统

　　upgrade 升级 ZFS 文集系统

　　list查看和询问数据集的信息

　　allow 将用于执行 ZFS 管理任务的细粒度权限委托给非特权用户

　　unallow 将用于执行 ZFS 管理任务的细粒度权限删除

　　share 共享zfs文件系统

　　unshared 取消共享zfs文件系统

　　rename 重命名 ZFS 快照

　　mount 挂载zfs文件系统

　　umount 卸载zfs文件系统

　　set 可以设置或修改数据集的属性

　　get 得到文件系统的一个专门属性

　　zpool命令包括一组子命令如下：

　　create 使用指定的实际设备建立存储池

　　destroy摧毁一个ZFS存储池，但是不删除设备中数据

　　add 在存储池中添加虚拟设备

　　remove 在存储池中删除虚拟设备，但是不删除设备中数据

　　list 显示所有存储池

　　iostat查看存储池I/O状况

　　status 查看存储池健康状况

　　online把存储池状态设置为在线

　　offline把存储池状态设置为离线

　　clear 消除存储池设备错误计数

　　attach 固定一个设备在存储池中

　　detach 从存储池中分离设备

　　replace 替换存储池中的设备

　　scrub 校验存储池

　　import 导入存储池

　　export 导出存储池

　　upgrade 升级存储池

　　history 显示所有存储池操作命令

　　get 找回和列出存储池的设备

　　set 设置一个或者多个设备在一个存储池

　　2 zfs使用实例：

　　(1) 使用 losetup 建立虛擬磁盘

　　$ mkdir zfstest

　　$ cd zfstest

　　$ dd if=/dev/zero of=disk1.img bs=64M count=1

　　$ dd if=/dev/zero of=disk2.img bs=64M count=1

　　$ dd if=/dev/zero of=disk3.img bs=64M count=1

　　$ dd if=/dev/zero of=disk4.img bs=64M count=1

　　$ dd if=/dev/zero of=disk5.img bs=64M count=1

　　(2)建立简单存储池

　　#zpool create -f zfstest1 /dev/loop0

　　使用-f选项强行创建存储池和文件系统。

　　(3)创建RAID-Z池。

　　RAID-Z：类似RAID-5，是个存储数据及在多个磁盘上进行校验的虚拟设备。RAID(Redundant
Array of Inexpensive (or Independent)
Disks，廉价(独立)磁盘冗余阵列)指的是称为阵列的一组磁盘。依据不同的配置，此阵列可以改善可靠性、响应时间或存储容量。ZFS
使用 RAID-Z，RAID-Z 类似于
RAID-5，因为它将数据和奇偶校验信息都置于三个或更多驱动器上。但是，与 RAID-5
不同的是，RAID-Z 始终执行完全条带化 (full-stripe)
写操作。将会对所有数据都执行校验和操作。Snapshot：在某个时间，文件系统或卷的映像。快照是文件系统或卷的只读的拷贝。快照的创建快速而且容易。不过，快照的建立需要消耗存储池的空间。可以使用关键字raidz来创建RAID-Z存储池。

　　# zpool create cjhzpool -f raidz /dev/loop2 /dev/loop3 /dev/loop4 /dev/loop5

　　(4)删除存储池

　　当写在磁盘中的数据不再需要的时候，就可以使用zpool destroy命令删除存储池。

　　# zpool destroy zfstest1

　　注意：存储池被删除后，数据也同时会丢失。

　　(5) 实时监控存储池

　　 显示基本的 ZFS 存储池信息

　　可以使用 zpool list
命令显示有关池的基本信息。如果不使用参数，则此命令会显示系统中所有池的所有字段。如图2
。

zfs使用实例
图2显示基本的 ZFS 存储池信息

　　图2输出显示了以下信息：

　　NAME 池的名称。

　　SIZE 池的总大小，等于所有顶层虚拟设备大小的总和。

　　USED 由所有数据集和内部元数据分配的空间量。请

　　AVAILABLE 池中未分配的空间量。

　　CAPACITY (CAP) 已用空间量，以总空间的百分比表示。

　　HEALTH 池的当前运行状况。

　　ALTROOT 池的备用根(如果有)。

　　可以使用 -o
选项请求特定的统计信息。使用此选项可以生成自定义报告或快速列出相关信息。例如，要仅列出每个池的名称和大小，可使用以下语法：

　　# zpool list -o name,size

　　NAME SIZE

　　cjhzpool 238M

　　zfstest1 59.5M

　　(6)查看 ZFS 存储池 I/O 统计信息

　　要请求池或特定虚拟设备的 I/O 统计信息，请使用 zpool iostat 命令。它与 iostat
命令类似，此命令也可以显示目前为止所有 I/O
活动的静态快照，以及每个指定时间间隔的更新统计信息。如果不使用任何选项，则 zpool
iostat 命令会显示自引导以来系统中所有池的累积统计信息。如图3 。


图3查看 ZFS 存储池 I/O 统计信息

　　图3输出显示了以下信息：

　　USED CAPACITY
当前存储在池或设备中的数据量。由于具体的内部实现的原因，此数字与可供实际文件系统使用的空间量有少量差异。

　　AVAILABLE CAPACITY 池或设备中的可用空间量。与 used
统计信息一样，这与可供数据集使用的空间量也有少量差异。

　　READ OPERATIONS 发送到池或设备的读取 I/O 操作数，包括元数据请求。

　　WRITE OPERATIONS 发送到池或设备的写入 I/O 操作数。

　　READ BANDWIDTH 所有读取操作(包括元数据)的带宽，以每秒单位数表示。

　　WRITE BANDWIDTH 所有写入操作的带宽，以每秒单位数表示。

　　(7)确定 ZFS 存储池的运行状况

　　ZFS
提供了一种检查池和设备运行状况的集成方法。池的运行状况是根据其所有设备的状态确定的。使用
zpool status 命令可以显示如图4 信息。


图4确定 ZFS 存储池的运行状况

　　每个设备都可以处于以下状态之一：

　　ONLINE
设备处于正常工作状态。尽管仍然可能会出现一些瞬态错误，但是设备在其他方面处于正常工作状态。

　　DEGRADED 虚拟设备出现故障，但仍能够工作。此状态在镜像或 RAID-Z
设备缺少一个或多个组成设备时最为常见。池的容错能力可能会受到损害，因为另一个设备中的后续故障可能无法恢复。

　　FAULTED 虚拟设备完全无法访问。此状态通常表示设备出现全面故障，以致于 ZFS
无法向该设备发送数据或从该设备接收数据。如果顶层虚拟设备处于此状态，则完全无法访问池。

　　OFFLINE 管理员已将虚拟设备显式脱机。

　　UNAVAILABLE 无法打开设备或虚拟设备。在某些情况下，包含 UNAVAILABLE
设备的池会以 DEGRADED 模式显示。

　　REMOVED
系统正在运行时已物理移除了该设备。设备移除检测依赖于硬件，而且并非在所有平台上都受支持。

　　对系统中所有存储池进行健康查询，使用命令：

　　# zpool status -x

　　all pools are healthy

　　表示所有池运行状况良好。

　　显示一个存储池的详细情况

　　#zfs get all cjhzpool如图5 。

查看 ZFS 存储池 I/O 统计信息
图5显示一个存储池的详细情况

　　(8)ZFS文件系统快照管理

　　ZFS文件系统快照简介

　　ZFS 利用写复制 (copy-on-write, COW)
机制来存储数据，并且几乎可以作为数据存储的副效应来生成快照。COW
在将新数据写入磁盘前会读入旧数据。之后，COW
会将旧数据写入某个新位置以供快照使用。此读取和复制数据的过程同时适用于用户数据和文件系统的专用数据(元数据)。任何后续写入操作都将导致通过
COW 机制分配新块，因此永远不会修改组成快照的那些块。

　　从本质上而言，从某个备份进行恢复的步骤与从传统备份恢复的步骤是一样的：

　　重建文件系统。

　　恢复完整备份。

　　恢复每个增量备份。

　　可以创建某个特定快照的克隆(副本)。克隆指一个其初始内容与某个快照的内容相同的文件系统。正如可以修改其他文件系统属性一样，可以修改克隆的属性和内容。

　　使用命令创建和删除ZFS快照

　　我们使用zfs
snapshot命令来创建快照，这个命令只有一个变量就是快照的名字。快照名字如下所示：

　　filesystem@snapname

　　volume@snapname

　　创建快照

　　# zfs snapshot zfstest1@cjh

　　通过使用 -r 选项可为所有后代文件系统创建快照。

　　# zfs snapshot -r zfstest1@cjh

　　然后使用命令查看所有快照，如图6 。

ZFS文件系统快照管理
▲

　　# zfs list -t snapshot

　　图6 使用命令查看所有快照

　　说明：快照不能被修改属性，也不能使数据集的属性应用到快照上。

　　请使用zfs destroy命令删除快照。

　　删除快照

　　# zfs destroy zfstest1@cjh

　　在快照存在的情况下，数据集不能被删除。另外，如果存在快照的克隆，也不能删除数据集。

　　恢复到最初的快照

　　使用zfs
rollback命令能使快照放弃所有的改变，恢复到建立快照的最初状态。如果有些最近的快照的话，使用?-r选项能强制删除这些快照，而恢复到最初的快照。

　　恢复pool/home/ahrens文件系统的星期二的快照。

　　# zfs rollback pool/home/ahrens@tuesday

zfs rollback -r CIFS/PD_Daily_Report/QA@auto-20131227.1330-2w
查找特定的快照方法：zfs list -r -t snapshot -o name,creation,used,refer
/mnt/CIFS/Public/PMC

###文件共享自动递归###

在实际生产环境中，建一个自动任务，当一天内有新增文件是做一次递归权限

find /mnt/CIFS/Public/ENG/Drawing -mtime -1&&chmod -R 755 /mnt/CIFS/Public/ENG/Drawing
