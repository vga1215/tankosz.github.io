---
layout: post
title: PostgreSQL数据库操作
category: 工具
tags: PostgreSQ
keywords: PostgreSQ
---
###PostgreSQL数据库操作###


[postgreSQl-for-gentoo](https://wiki.gentoo.org/wiki/PostgreSQL/QuickStart)
--------------------
## PostreSQL两种数据库创建方式:

**Note:**

```
1.用postgresql用户进入后运行命令创建:
createdb abc -O shawn

2.用psql命令进入后创建：
psql 帮助用\? \h
create database "abc" owner=shawn encoding='UTF8' 

alter user shawn with password '1234'    #修改role密码
#删除用户，先要删除与用户关联的数据库
alter database abc owner to postgres;
drop role shawn;

postgresql默认情况下，远程访问不能成功，如果需要允许远程访问，需要修改两个配置文件，说明如下：

1.postgresql.conf

将该文件中的listen_addresses项值设定为“*”，在9.0
Windows版中，该项配置已经是“*”无需修改。

2.pg_hba.conf

在该配置文件的host all all 127.0.0.1/32
md5行下添加以下配置，或者直接将这一行修改为以下配置

host    all    all    0.0.0.0/0    md5

如果不希望允许所有IP远程访问，则可以将上述配置项中的0.0.0.0设定为特定的IP值。
```
