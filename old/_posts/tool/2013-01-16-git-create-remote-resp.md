---
layout: post
title: git创建远程库
category: 工具
tags: Git
description: git创建远程库
---

## cygwin配置github
{% highlight bash %}
cd /cygdrive/c/Documents/My\ Dropbox/Dropbox/Vimwiki/jeklly

git创建版本库及第一次提交

>1.配置当前用户的姓名和邮件地址

    $ git config --global user.name "yourname"
    $ git config --global user.email youremail address
>2.设置一些Git别名，以便可以使用更为简洁的子命令

**例如：用git ci 相当于git commit 用git st 相当于git status**

    git config --global alias.st status
    git config --global alias.ci commit
    git config --global alias.co checkout
    git config --global alias.br branch
>3.用git命令输出中开启颜色显示

    git config --global color.ui true
>4.进入一个工作目录，执行git init创建版本库

    cd /cygdrive/c/Documents/My\ Dropbox/Dropbox/Vimwiki/Default/_output
    git init
>5.在工作目录中增加文件，如目录中存在文件，执行`git add .`增加目录下所有文件,不
管新增文件还是修改文件这一步都是必须的，执行'git add (file)增加特定文件

>6.提交说明，**这一步是强制性的，而且说明里不能为空**

    $git ci -m "initializd"

>7.用ssh认证github方法如：

<https://help.github.com/articles/generating-ssh-keys>
~/.ssh/id_rsa' are too open解决办法
cd ~/.ssh 
chmod 700 id_rsa

多人开发版本有变动时，PUSH之前一定要git pull

>8.使用Github Pages存放并显示自己的网页.
如在在github上建一个vga1215/vga1215.github.io版本

    $git remote add vga1215 git@github.com:vga1215/vga1215.github.io.git
    $git push vga1215 master

>9.成功
<http://vga1215.github.io/>

当自己当前版本低于远程仓库版本

有如下几种解决方法：

1.使用强制push的方法：

 git push -u vga1215 master -f

这样会使远程修改丢失，一般是不可取的，尤其是多人协作开发的时候。

2.push前先将远程repository修改pull下来

git pull vga1215 master

git push -u vga1215 master

3.若不想merge远程和本地修改，可以先创建新的分支：

git branch [name]

然后push


{% endhighlight %}
<div class="note">
<h5>已删除文件但这还在commit前存在,用下面命令一次删除deleted状态的</h5>
<p>
Update: If you only want to add deleted files, try:
</p>
<p>
<b>git ls-files --deleted | xargs git rm git commit</b>
</p>
</div>

<http://gitref.org/index.html>

[Git 多人协作开发的过程](https://www.cnblogs.com/onelikeone/p/6857910.html)

##查看、添加、提交、删除、找回，重置修改文件

{% highlight bash %}

git help <command> # 显示command的help

git show # 显示某次提交的内容 git show $id

git co -- <file> # 抛弃工作区修改

git co . # 抛弃工作区修改

git add <file> # 将工作文件修改提交到本地暂存区

git add . # 将所有修改过的工作文件提交暂存区

git rm <file> # 从版本库中删除文件

git rm <file> --cached # 从版本库中删除文件，但不删除文件

git reset <file> # 从暂存区恢复到工作文件

git reset -- . # 从暂存区恢复到工作文件

git reset --hard # 恢复最近一次提交过的状态，即放弃上次提交后的所有本次修改

git ci <file> git ci . git ci -a # 将git add, git rm和git ci等操作都合并在一起做　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　git ci -am "some comments"

git ci --amend # 修改最后一次提交记录

git revert <$id> # 恢复某次提交的状态，恢复动作本身也创建次提交对象

git revert HEAD # 恢复最后一次提交的状态

{% endhighlight %}

##查看文件diff

{% highlight bash %}

git diff <file> # 比较当前文件和暂存区文件差异 git diff

git diff <$id1> <$id2> # 比较两次提交之间的差异

git diff <branch1>..<branch2> # 在两个分支之间比较

git diff --staged # 比较暂存区和版本库差异

git diff --cached # 比较暂存区和版本库差异

git diff --stat # 仅仅比较统计信息

{% endhighlight %}

##查看提交记录
{% highlight bash %}
git log -p <file> # 查看每次详细修改内容的diff

git log -p -2 # 查看最近两次详细修改内容的diff

git log --stat #查看提交统计信息

tig
{% endhighlight %}
*Mac上可以使用tig代替diff和log，brew install tig*

##Git 本地分支管理

###查看、切换、创建和删除分支
{% highlight bash %}
git br -r # 查看远程分支

git br <new_branch> # 创建新的分支

git br -v # 查看各个分支最后提交信息

git br --merged # 查看已经被合并到当前分支的分支

git br --no-merged # 查看尚未被合并到当前分支的分支

git co <branch> # 切换到某个分支

git co -b <new_branch> # 创建新的分支，并且切换过去

git co -b <new_branch> <branch> # 基于branch创建新的new_branch

git co $id # 把某次历史提交记录checkout出来，但无分支信息，切换到其他分支会自动删除

git co $id -b <new_branch> # 把某次历史提交记录checkout出来，创建成一个分支

git br -d <branch> # 删除某个分支

git br -D <branch> # 强制删除某个分支 (未被合并的分支被删除的时候需要强制)

 分支合并和rebase

git merge <branch> # 将branch分支合并到当前分支

git merge origin/master --no-ff # 不要Fast-Foward合并，这样可以生成merge提交

git rebase master <branch> # 将master rebase到branch，相当于： git co <branch> && git rebase master && git co master && git merge <branch>
{% endhighlight %}
## Git补丁管理(方便在多台机器上开发同步时用)
{% highlight bash %}
git diff > ../sync.patch # 生成补丁

git apply ../sync.patch # 打补丁

git apply --check ../sync.patch #测试补丁能否成功
{% endhighlight %}
## Git暂存管理
{% highlight bash %}
git stash # 暂存

git stash list # 列所有stash

git stash apply # 恢复暂存的内容

git stash drop # 删除暂存区
{% endhighlight %}
## Git远程分支管理
{% highlight bash %}
git pull # 抓取远程仓库所有分支更新并合并到本地

git pull --no-ff # 抓取远程仓库所有分支更新并合并到本地，不要快进合并

git fetch origin # 抓取远程仓库更新

git merge origin/master # 将远程主分支合并到本地当前分支

git co --track origin/branch # 跟踪某个远程分支创建相应的本地分支

git co -b <local_branch> origin/<remote_branch> # 基于远程分支创建本地分支，功能同上

git push # push所有分支

git push origin master # 将本地主分支推到远程主分支

git push -u origin master # 将本地主分支推到远程(如无远程主分支则创建，用于初始化远程仓库)

git push origin <local_branch> # 创建远程分支， origin是远程仓库名

git push origin <local_branch>:<remote_branch> # 创建远程分支

git push origin :<remote_branch> #先删除本地分支(git br -d <branch>)，然后再push删除远程分支
{% endhighlight %}
## Git远程仓库管理
{% highlight bash %}
GitHub

git remote -v # 查看远程服务器地址和仓库名称

git remote show origin # 查看远程服务器仓库状态

git remote add origin git@ github:robbin/robbin_site.git # 添加远程仓库地址

git remote set-url origin git@ github.com:robbin/robbin_site.git # 设置远程仓库地址(用于修改远程仓库地址) git remote rm <repository> # 删除远程仓库

创建远程仓库

git clone --bare robbin_site robbin_site.git # 用带版本的项目创建纯版本仓库

scp -r my_project.git git@ git.csdn.net:~ # 将纯仓库上传到服务器上

mkdir robbin_site.git && cd robbin_site.git && git --bare init # 在服务器创建纯仓库

git remote add origin git@ github.com:robbin/robbin_site.git # 设置远程仓库地址

git push -u origin master # 客户端首次提交

git push -u origin develop # 首次将本地develop分支提交到远程develop分支，并且track

git remote set-head origin master # 设置远程仓库的HEAD指向master分支

也可以命令设置跟踪远程库和本地库

git branch --set-upstream master origin/master

git branch --set-upstream develop origin/develop
{% endhighlight %}
---------------------------------------------
## > Git reset revert 回退回滚取消提交返回上一版本

总有一天你会遇到下面的问题.

(1)改完代码匆忙提交,上线发现有问题,怎么办? 赶紧回滚.

(2)改完代码测试也没有问题,但是上线发现你的修改影响了之前运行正常的代码报错,必须回滚.



这些开发中很常见的问题,所以git的取消提交,回退甚至返回上一版本都是特别重要的.

大致分为下面2种情况:



1.没有push

这种情况发生在你的本地代码仓库,可能你add ,commit
以后发现代码有点问题,准备取消提交,用到下面命令

reset
git reset [--soft | --mixed | --hard


上面常见三种类型



--mixed

会保留源码,只是将git commit和index 信息回退到了某个版本.

git reset 默认是 --mixed 模式 
git reset --mixed  等价于  git reset


--soft

保留源码,只回退到commit
信息到某个版本.不涉及index的回退,如果还需要提交,直接commit即可.



--hard

源码也会回退到某个版本,commit和index
都回回退到某个版本.(注意,这种方式是改变本地代码仓库源码)

当然有人在push代码以后,也使用 reset --hard <commit...>
回退代码到某个版本之前,但是这样会有一个问题,你线上的代码没有变,线上commit,index都没有变,当你把本地代码修改完提交的时候你会发现权是冲突.....

所以,这种情况你要使用下面的方式





2.已经push

对于已经把代码push到线上仓库,你回退本地代码其实也想同时回退线上代码,回滚到某个指定的版本,线上,线下代码保持一致.你要用到下面的命令



revert

git revert用于反转提交,执行evert命令时要求工作树必须是干净的.

git revert用一个新提交来消除一个历史提交所做的任何修改.

revert 之后你的本地代码会回滚到指定的历史版本,这时你再 git push
既可以把线上的代码更新.(这里不会像reset造成冲突的问题)



revert 使用,需要先找到你想回滚版本唯一的commit标识代码,可以用 git log
或者在adgit搭建的web环境历史提交记录里查看.

git revert c011eb3c20ba6fb38cc94fe5a8dda366a3990c61
通常,前几位即可

git revert c011eb3


git revert是用一次新的commit来回滚之前的commit，git reset是直接删除指定的commit

看似达到的效果是一样的,其实完全不同.

第一:

上面我们说的如果你已经push到线上代码库, reset 删除指定commit以后,你git
push可能导致一大堆冲突.但是revert 并不会.

第二:

如果在日后现有分支和历史分支需要合并的时候,reset
恢复部分的代码依然会出现在历史分支里.但是revert 方向提交的commit
并不会出现在历史分支里.

第三:

reset 是在正常的commit历史中,删除了指定的commit,这时 HEAD 是向后移动了,而 revert
是在正常的commit历史中再commit一次,只不过是反向提交,他的 HEAD 是一直向前的.]

# git创建远程库

>git中一般使用 git init 创建的库不允许同一分支多个work tree直接提交，如果这么做有可能会出现以下问题：

>remote: error: refusing to update checked out branch: refs/heads/master

>要解决这个问题可以有以下四种方式

## 创建共享库（推荐）

    # 创建共享库(bare)
    $ mkdir /git/repo.git && cd /git/repo.git && git init --bare

    # 本地库
    $ mkdir ~/repo && cd ~/repo && git init
    # 创建一个文件
    $ vi foo
    # 增加新增文件到库管理
    $ git add .
    # 提交
    $ git commit
    # 增加共享库位置
    $ git remote add origin file:///git/repo.git
    # 提交更改
    $ git push origin master

## 不工作在同一库下（推荐）

    # 创建库
    $ mkdir /git/repo  && cd /git/repo && git init
    # 创建一个文件
    $ vi foo
    # 增加新增文件到库管理
    $ git add .
    # 提交
    $ git commit 
    # 新建一个分支
    $ git branch test

    # 本地库
    $ git clone file:///git/repo && cd repo
    # 切换到分支test
    $ git checkout test
    # 修改文件
    $ echo "foo">foo
    # 提交
    $ git commit 
    # 增加远程库位置
    $ git remote add origin flie:///git/repo
    # 提交更改
    $ git push origin test

## 忽略冲突1
修改远程库.git/config添加下面代码

    [receive]
        denyCurrentBranch = ignore

这种方式不能直接显示在结果的work tree上，如果要显示，需要使用

    git reset --hard才能看到

## 忽略冲突2
在远程库上

    git config -bool core.bare true
