---
layout: post
title: ngx_http_fastcgi_module 的那些事
category: 工具
tags: Nginx
keywords: Nginx
---

是什么？

顾名思义，是Nginx用来处理FastCGI的模块。FastCGI是什么？这个以后再讲，可以说的是现在LNMP架构里面，PHP一般是以PHP-CGI的形式在运行，它就是一种FastCGI，我们在进程中看到的PHP-FPM是PHP-CGI的管理调度器。
为什么要详解一下？

因为LNMP不像LAMP，且早期Nginx不支持path_info，导致网上有大量旧版本的Nginx教程干扰视线。

为了更加清晰准确使用LNMP，估需要深入了解一下整个ngx_http_fastcgi_module。
四个常见、重要的配置项
fastcgi_pass

    作用域：location, if in location

设置FastCGI服务，其值可以是一个域名、IP地址:端口、或者是一个Unix的Socket文件。

同时，它也只支持一个FastCGI服务集群。

# TCP形式传递
    fastcgi_pass localhost:9000;

# Socket形式传递
    fastcgi_pass unix:/tmp/fastcgi.socket;

# 传递给集群
    upstream cloud {
        server cgi_1.cloud.com;
        server cgi_2.cloud.com;
    }
    fastcgi_pass cloud;

upstream集群定义不在本次讨论范围，更多玩法请参考官方文档。
fastcgi_param

    作用域：http, server, location

设置一个传递给FastCGI服务的参数，可以是文本或者是变量。

# 例如在接入层Nginx上面传递如下5个参数
    fastcgi_param  REMOTE_ADDR        $remote_addr;
    fastcgi_param  REMOTE_PORT        $remote_port;
    fastcgi_param  SERVER_ADDR        $server_addr;
    fastcgi_param  SERVER_PORT        $server_port;
    fastcgi_param  SERVER_NAME        $server_name;

# 那么在FastCGI上面，例如PHP-CGI上面就可以通过$_SERVER这个超全局变量获取。
    $_SERVER['REMOTE_ADDR']
    $_SERVER['REMOTE_PORT']
    $_SERVER['SERVER_ADDR']
    $_SERVER['SERVER_PORT']
    $_SERVER['SERVER_NAME']

可传递的参数，遵循CGI/1.1规范定义。

可以从Github上面看到Nginx在3年前实现FastCGI的参数传递后，基本就没变过了。
fastcgi_index

    作用域：http, server, location

当请求以/结尾的时候，会将请求传递给所设置的index.php文件处理。

fastcgi_index index.php;
fastcgi_param SCRIPT_FILENAME /home/www/scripts/php$fastcgi_script_name;

fastcgi_split_path_info

    作用域：location

Nginx默认获取不到PATH_INFO的值，得通过fastcgi_split_path_info指定定义的正则表达式来给$fastcgi_path_info赋值。

其正则表达式必须要有两个捕获。

    第一个捕获的值会重新赋值给$fastcgi_script_name变量。
    第二个捕获到的值会重新赋值给$fastcgi_path_info变量。

例子：
~~~
location ~ ^(.+\.php)(.*)$ {
    fastcgi_split_path_info       ^(.+\.php)(.*)$;
    fastcgi_param SCRIPT_FILENAME /path/to/php$fastcgi_script_name;
    fastcgi_param PATH_INFO       $fastcgi_path_info;
}
~~~
原始请求是 /show.php/article/0001。

通过分割，FastCGI得到的结果是：

    SCRIPT_FILENAME: /path/to/php/show.php
    PATH_INFO: /article/0001

Nginx在0.7.31以前是没有fastcgi_split_path_info这个指令的，而0.7.x这个版本一直存活了好多年，后面才高歌猛进，导致网上存在大量旧版本通过正则自己设置PATH_INFO的方法。
踩了好多次依旧不记得怎么设置的ThinkPHP

为什么总是踩坑？因为我们都会通过重写来隐藏index.php文件，而ThinkPHP的教程，默认教的是旧版Nginx写法，且URL_MODE必须设置为3也说得很隐晦（URL_MODE默认为0）。

例如ThinkPHP的说明有一段旧版的Nginx设置指引。

     location / { // …..省略部分代码
       if (!-e $request_filename) {
       rewrite  ^(.*)$  /index.php?s=$1  last;
       break;
        }
     }

该规则是通过将请求rewrite给/index.php?s=来实现的，其ThinkPHP的URL_MODE配置必须为3，也就是兼容模式。

如果使用本文中的传递PATH_INFO方式，且隐藏index.php，则ThinkPHP的URL_MODE需要改为2。

如果使用本文中的传递PATH_INFO方式，但不隐藏index.php，则ThinkPHP的URL_MODE改为1。
还有个一个叫 cgi.fix_pathinfo

cgi.fix_pathinfo参数，藏在PHP-FPM的php.ini配置里面，其默认值为1。

这里存在一个安全风险，我也不通，详情不表，看鸟哥的文章：http://www.laruence.com/2010/05/20/1495.html

习惯性将其设置为0即可。
参考

http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html
http://wiki.nginx.org/PHPFcgiExample
  
