---
layout: post
title: Linux下多个命令连续执行方法
category: 工具
tags: Linux
keywords: Linux,连续,命令
description: 
---
[VIM改造](https://zhuanlan.zhihu.com/p/22245538)
<p>
http://blog.csdn.net/yasi_xi/article/details/8660445
  </p>
  Putty配置方案
<div class="note warning">
  <h5>很久不用ＶＩＭ先看如下操作</h5>
  <p>先用命令vim
  ~/.vimrc查看配置文件，我的所有配置文件参照：https://github.com/joedicastro/dotfiles/tree/master/vim 
  本地开启主菜单键为空格，lead为('）空格＋Ｕ和空格＋Ｏ为常用　
 </p>
</div>
<div class="note info">
  <h5>vim7新特性tab标签页</h5>
  <p>
    vim7新增加tab标签特性，使用如下，帮助文档为<code>:h tabpage.txt</code>
  </p>
</div>
<div class="mobile-side-scroller">
<table>
  <thead>
    <tr>
      <th>命令</th>
      <th>描述</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <p><code>:tabe[dit] {file} </code>和<code> :tabnew </code> </p>
      </td>
      <td>
        <p>
         :tabe[dit]和：tabnew
         新建标签打开文档和新建标签

        </p>
      </td>
    </tr>
    <tr>
      <td>
        <p><code>:tabn</code>和<code>:tabp</code></p>
      </td>
      <td>
        <p>

           tab切换
           
           :tabn[ext] 下一个  快捷键Ctrl+PageDown
           
           :tabp[revious]  上一个  快捷键Ctrl+PageUp

        </p>
      </td>
    </tr>
    <tr>
      <td>
        <p><code>:tabm N </code></p>
      </td>
      <td>
        <p>

          tab移动
          
          :tabm[ove] N   其中N为数字，0为第一，1为第二

        </p>
      </td>
    </tr>
    <tr>
      <td>
        <p><code>:tabc</code>和<code>:tabo</code></p>
      </td>
      <td>
        <p>

         关闭tab
         
         :tabc[losed] 关闭当前tab页
         
         :tabo[nly] 关闭除当前的tab页

        </p>
      </td>
    </tr>
  </tbody>
</table>
</div>

<div class="note warning">
  <h5>分屏和分屏切换快捷键</h5>
  <p>分屏:split 上下分屏:vsplit 左右分屏切换 Ctrl+w.</p>
</div>

<div class="note info">
  <h5>How use vim74+lua5+py on debian6</h5>
  <p>These are for the extra tidbits sometimes necessary to understand
     Jekyll.</p>
</div>

*need python2.6++ lua5++*

lua安装步骤：   
官方下载源玛，解压缩并ＣＤ压缩目录    
修改目录中Ｍakefile文件：INSTALL_TOP= /usr/local/lua   
执行$make linux install 

-vim74安装步骤：
--完成后安装VIM的依赖库环境  
   {% highlight bash %}
    apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev \
    libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev\
    python-dev libperl-dev ruby-dev liblua5.1-0-dev
   {% endhighlight %}

--卸载老版本vim
{% highlight bash %}
apt-get remove vim vim-runtime gvimrc
{% endhighlight %}
--安装新版本用hg
    {% highlight bash %}
$ apt-get install Mercurial
$ hg clone https://code.google.com/p/vim/ vim
$ cd vim  
$ ./configure --prefix=/usr/share/vim/  \
        --with-features=huge  \
        --enable-gui=gnome2  \
        --enable-multibyte  \
        --enable-cscope  \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-pythoninterp=yes \
        --enable-rubyinterp=yes \
        --with-lua-prefix=/usr/local/lua \
        --with-python-config-dir=/usr/lib/python2.6/config 
$ make
$ make install
$ ln -s /usr/local/vim74/bin/vim /usr/bin/vim     #按此方法连接vim命令
$ vim --version    #查看如果有+lua和+python就成功编译完成。
{% endhighlight %}

--Installing vim 8.0.X with lua, python on Ubuntu 16.04
{% highlight bash %}
sudo apt-get remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
 
sudo apt-get install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev

sudo rm -rf /usr/local/share/vim

sudo rm /usr/bin/vim
 
sudo mkdir /usr/include/lua5.1/include
sudo cp /usr/include/lua5.1/*.h /usr/include/lua5.1/include/

cd /opt/
git clone https://github.com/vim/vim
git pull && git fetch
cd vim/src
make distclean # if vim was prev installed
./configure --with-features=huge \
            --enable-rubyinterp \
            --enable-largefile \
            --disable-netbeans \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-multibyte \
            --enable-perlinterp \
            --enable-luainterp \
            --with-luajit \
            --enable-fail-if-missing \
            --with-lua-prefix=/usr/include/lua5.1 \
            --enable-cscope
	    
make 
sudo make install

# alias vi="vim" in .zshrc / .bashrc
{% endhighlight %}

***Ubuntu18.04 安装使用 Vundle***

    Vundlde 是一个开源的vim插件管理工具
    源地址 https://github.com/VundleVim/Vundle.vim

安装步骤

    克隆项目到本地

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
    
    cd ~/.vim  
    mkdir colors
    cd colors
    增加molokai.vim
    配置vimrc文件
    .vimrc参考dotfile中文件

    开始安装：
    打开vim

    :PluginInstall

    如何使用

    安装插件
    使用的步骤非常简单。
    举个栗子，比如我们想安装xxx插件，现在github找到他，比如地址是
    https://github.com/author/xxx
    那么只需要在~/.vimrc文件添加一行

    Bundle 'author/xxx'

    退出并重新打开vim，执行

    :BundleInstall

    就可以了。


## 查看特定硬件信息,查看网卡信息
{% highlight bash %}
$ dmesg | grep 'eth'
{% endhighlight %}
## 正则表达式基础练习

>*文献参考鸟哥linux私房菜*

>1   须要注意的几点

>>1.1  正则表达式在资料中查询字符串时，是以‘整行’为单位来进行资料的查询的！

>>1.2      一个英文字母是一个字符，符号也是一个字符。如果是中文，一个中文算两个字符。

>>1.3       ^在中括号内表示反选，在中括号外表示行首

## 练习内容
http://linux.vbird.org/linux_basic/0330regularex/regular_express.txt

## example1.搜索特定字符串
    grep -n 'the' reg  ---正常搜索字符串
    
    grep -vn 'the' reg  ---反向搜索字符串

    grep -in 'the' reg   ---不区分大小写
    
    
## example2.利用中括号[]来搜索集合字元

>*attention: 不论[]里有多少个字元，它仅能代表[一个]字元*

>查找以a或e为字元的字符串

        #grep -n 't[ae]st' reg
>查找除了以g开头所有oo的字符串
       
        #grep -n '[^g]oo' reg
>查找除小字字母开头所有oo的字符串　

        ＃grep -n '[^a-z]oo' reg 
        还可以用
        #grep　-n'[^[:lower:]]oo' reg 表示 
>查找所有数字字符串　

    #grep -n '[0-9]' reg
    还可以用
    #grep -n '[[:digit:]]' reg

##example3.行首与行尾的字元^$
>查找一行字符串里有the的，只有出现在行首的the才显示，可以使用定位字元了 
    
    #grep -n '^the' reg
>查找以小写字母开头的行　
    
    #grep -n '^[a-z]' reg
>查找非字母开头的行　
    
    ＃grep -n '^[^a-zA-Z]' reg
>查找以小数点结尾的　

    #grep -n '\.$' reg

>先从reg里读取前１０行，然后在１０里读取后６行　

    #cat -An reg |head -n 10 |tail -n 6
>读取空白行　

    #grep -n '^$' reg
    #grep -v '^$' /etc/vim/gvimrc | grep -v '^#' 
    #第一个-v '^$' 代表所有非空行
    #第二个-v '^#' 不要以#开头的行显示

##example4.任间一个字元\. 与重复字元　\*    
在bash 中万用字符星号为任意（０或多个）字元，正规表达式不同     
*小数点：代表一定有一个任意字元的意思*      
*星星号：代表重复一个字元，０到无穷次，为组合形态*

{% highlight bash %}
$grep -n 'g*g' reg 
{% endhighlight %}
显示所有以g开头或者结尾的　　　　
##example5.限定连续字符范围 \{\}            
{% highlight bash %}
$ grep -n 'o\{2\}' reg     #查找连续两个o
$ grep -n 'go\{2,5\}g'     #查到连续２到５个o
$ grep -n 'go\{2,\}g' reg  #查找２个以上的o 
{% endhighlight %}
xargs命令实例
2013-03-12

xargs更象一个筛选器，将符合管道传递过来的内容进行处理，这是一个极度高效的方法。xargs reads items from the standard input.

1、查询包含string的文件
find . -name ‘*.html’| xargs grep string

2、删除符合条件的文件
ls|xargs -i rm -rf {}

find . -name ‘*.log’ -mtime +30| xargs rm -rf
find . -name ‘*.log’ -mtime +30 -exec rm -rf {} \;
注意”{} \;”是一起用的，可以用”{} +”代替。
find . -name “*.log” -exec ls -l {} +

3、-I{}替换串replace-str
cat ip.txt | xargs -I {} echo {}/24
-i[replace-str]可以替代-Ireplace-str
cat ip.txt | xargs -i{} echo {}
cat ip.txt | xargs -iIP echo IP

在远程服务器列表的执行命令
cat ip.txt | xargs -I{} ssh -p322 root@{} hostname

4、批量文件改名

增加字符
ls -1 | xargs -t -i mv {} {}.bak

删减字符

#!/bin/sh
for i in `ls ABCD*`
do
n=${i#”ABCD”}
mv $i $n
done

或者

ls -1 ABCD* |sed ‘s/ABCD//’|xargs -t -i mv ABCD{} {}

删除A字符
#!/bin/sh
for file in `ls *A.wav`;do
n=`echo $file| sed ‘s/A//g’`
/bin/mv $file $n
done

5、批量删除包含code.html的行
find ./ -name “*.html” -exec grep code.html ‘{}’ \; |xargs sed -i ‘/code.html/d’
find ./ -name “*.html” -exec grep code.html ‘{}’ \; -exec sed -i ‘/code.html/d’ {} \;

6、批量替换
find -name "*.php" -exec sed -i 's/abc/efg/g' {} \;    //当前目录以及子目录下查找以php为后后缀的文件，并把文件中的字符串abc替换成efg

7、单行显示所有用户名
cut -d: -f1 < /etc/passwd | sort | xargs echo
awk ‘{print $1}’ /etc/passwd | xargs echo

8、–verbose, -t
cat a
one two
three four
cat a |xargs
cat a |xargs –verbose
cat a |xargs –verbose –max-args=2

9、终止所有java进程
pgrep java|xargs kill -9
##sed工具    
     <code>sed [-nefr] [动作] </code>    
<code>-e:</code>直接在指令列模式上进行sed的动作编辑，不影响原文件　　　　
<code>-f:</code>把sed动作的结果写入一个文档内，用法-f filename    
<code>-i:</code>这个参数直接在文件上操作指令，会修改原文件,并不会在屏幕显示，请使用前备份。　

动作说明：    
      <code>[n1[n2]]function  </code>   
n1,n2:不一定会存在，一般代表进行动作的行数，如要在5到35行进行动作，则用'5,35+动作'来表示　　

functione有以下参数：　

a：新增,a后面接字符串，这些字符串会出现在当前行的下行

c: 取代,c后面接字符串，这些字符可以取代n1n2之间的行,以行为单位进行处理　

d: 删除，后面不接任何字符串

i:插入，i后面可以接字符串，新的字符串在当前行的前一行

p:打印到屏幕，通常与参数sed -n一起使用　

s:与前面c不同的是这个s可以搭配g使用正则表达式法！例如:1,20s/old/new/g以字符串为单位进行处理　　     
*ex1:删除2到6行并打印至屏幕*  

    nl reg | sed '2,5d'

如可只删除第二行就是2d,如果删除第二行到最后一行为2,$d    

*字符串查找并替换的功能*    
<code> sed 's/要取代的字符串/新的字符串/g'</code>

    /sbin/ifconfig eth0 |grep 'inet addr:' | sed 's/^.*addr://g'     //删除addr:前面的
    /sbin/ifconfig eth0 |grep 'inet addr:' | sed 's/^.*addr://g' |sed -f ip.txt 'Bcast.*$//g'
　           //删除Bcast到行结尾并显示到文件ip.txt里  (ip.txt必须先存在)

##  debian中软件版本的控制

当你安装 Debian Linux 时，安装过程有可能同时为你提供多个可用的 Python
版本，因此系统中会存在多个 Python 的可执行二进制文件。你可以按照以下方法使用 ls
命令来查看你的系统中都有那些 Python 的二进制文件可供使用。
$ ls /usr/bin/python*
/usr/bin/python  /usr/bin/python2  /usr/bin/python2.7  /usr/bin/python3
/usr/bin/python3.4  /usr/bin/python3.4m  /usr/bin/python3m
执行如下命令查看默认的 Python 版本信息:
$ python --version
Python 2.7.8
1、基于用户修改 Python 版本：
想要为某个特定用户修改 Python 版本，只需要在其 home 目录下创建一个 alias(别名)
即可。打开该用户的 ~/.bashrc 文件，添加新的别名信息来修改默认使用的 Python
版本。
alias python='/usr/bin/python3.4'
一旦完成以上操作，重新登录或者重新加载 .bashrc 文件，使操作生效。
$ . ~/.bashrc
检查当前的 Python 版本。
$ python --version
Python 3.4.2
2、 在系统级修改 Python 版本
我们可以使用 update-alternatives 来为整个系统更改 Python 版本。以 root
身份登录，首先罗列出所有可用的 python 替代版本信息：
# update-alternatives --list python
update-alternatives: error: no alternatives for python
如果出现以上所示的错误信息，则表示 Python 的替代版本尚未被 update-alternatives
命令识别。想解决这个问题，我们需要更新一下替代列表，将 python2.7 和 python3.4
放入其中。
# update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
update-alternatives: using /usr/bin/python2.7 to provide /usr/bin/python
(python) in auto mode
# update-alternatives --install /usr/bin/python python /usr/bin/python3.4 2
update-alternatives: using /usr/bin/python3.4 to provide /usr/bin/python
(python) in auto mode
--install
选项使用了多个参数用于创建符号链接。最后一个参数指定了此选项的优先级，如果我们没有手动来设置替代选项，那么具有最高优先级的选项就会被选中。这个例子中，我们为
/usr/bin/python3.4 设置的优先级为2，所以 update-alternatives
命令会自动将它设置为默认 Python 版本。
# python --version
Python 3.4.2
接下来，我们再次列出可用的 Python 替代版本。
# update-alternatives --list python
/usr/bin/python2.7
/usr/bin/python3.4
现在开始，我们就可以使用下方的命令随时在列出的 Python 替代版本中任意切换了。
# update-alternatives --config python

# python --version
Python 2.7.8
3、移除替代版本
一旦我们的系统中不再存在某个 Python 的替代版本时，我们可以将其从
update-alternatives 列表中删除掉。例如，我们可以将列表中的 python2.7
版本移除掉。
# update-alternatives --remove python /usr/bin/python2.7
update-alternatives: removing manually selected alternative - switching python
to auto mode
update-alternatives: using /usr/bin/python3.4 to provide /usr/bin/python
(python) in auto mode



>有的时候执行一些简单指令的时候总不想分好几次输入，利用以下方法可以方便的一次执行多个命令

### 连续不中断执行

用`;`可以让多个命令连续知行，中间出现错误并不会中断后面命令，如

    mkdir test; mkdir test; rmdir test;

虽然第二条指令会报错，但是不会影响后面的指令，最后test目录不存在

### 出错停止后面指令

用`&&`分割的命令，如果没有错误会一直执行下去，出现错误立即中止，如

    mkdir test && mkdir test && rmdir test

这回在第二个指令处就中止了

### 一次正确即停止

用`||`分割的命令，如果有错误就一直执行下去，直到一次正确立即中止，如

    mkdir test || mkdir test || rmdir test
    mkdir test || mkdir test || rmdir test || mkdir test

第一次执行第一条指令就正确，后面的不执行

第二次执行前两条都错误，直到最后一条才正确，最后一条不再执行