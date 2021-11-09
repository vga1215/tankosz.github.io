#关于tmux显示256色的问题：
#先测试终端色彩模式，命令如下：
#$ wget http://www.vim.org/scripts/download_script.php?src_id=4568 -O colortest
#$ perl colortest -w
#改变系统环境：
#export TERM="screen-256color"
#然后看tmux文档里有一个"-2"参数：Force tmux to assume the terminal supports 256 colours.
#然后再shell配置里 alias tmux="tmux -2"
#.tmux.conf文件 
#important tmux环境中鼠标复制粘贴
# shft+鼠标左键 复制
# shft+鼠标右键 粘贴
# 常用操作
# tmux new -s shawn    //新建会话shawn
# tmux ls              //显示当前正在运行的会话
# tmux attach -t session  //“连接（attaching）”指定的会话
# tmux kill-session -t session //可以在一个会话中使用 exit 命令来杀死这个会话，
#                           // 也可以使用 kill-session 命令杀死指定会话
# 会话（session)中操作：
# prefix + d           //会话“分离（detaching）”让 tmux 在后台运行
# prefix + c           //会话中新建窗口（new window)
# prefix + ,           //会话中重命名窗口 （rename window)
# prefix + n (下一个窗口）+p（前一个窗口) +数字键 (指定数字窗口)
# prefix + w 列出窗口列表(list-windows)
# prefix + & 或命令行输入exit  //退出当前窗口
# 创建和调整面板(panes)请查看下面的快捷键，退出面板请命令行输入 :exit
# 或prefix + X
# 会话中进入命令模式 prefix + : (例子new-window -n processes "top" )
# 上面processes 是窗口名，top是新窗口的命令行

# 把前缀键从 C-b 更改为 C-a
set -g prefix C-a

# 释放之前的 Ctrl-b 前缀快捷键
unbind C-b

# 设定前缀键和命令键之间的延时
set -sg escape-time 1

# 确保可以向其它程序发送 Ctrl-A
bind C-a send-prefix

# 把窗口的初始索引值从 0 改为 1
set -g base-index 1

# 把面板的初始索引值从 0 改为 1
setw -g pane-base-index 1

# 使用 Prefix r 重新加载配置文件
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# 分割面板
bind | split-window -h
bind - split-window -v

# 在面板之间移动
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# 快速选择面板
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# 调整面板大小
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# 鼠标支持 - 如果你想使用的话把 off 改为 on
#setw -g mode-mouse on
#set -g mouse-select-pane on
#set -g mouse-resize-pane on
#set -g mouse-select-window on

# 设置默认的终端模式为 256 色模式
set -g default-terminal "screen-256color"

# 开启活动通知
setw -g monitor-activity on
set -g visual-activity on

# 设置状态栏的颜色
set -g status-fg white
set -g status-bg black

# 设置窗口列表的颜色
setw -g window-status-fg cyan
setw -g window-status-bg default
setw -g window-status-attr dim

# 设置活动窗口的颜色
setw -g window-status-current-fg white
setw -g window-status-current-bg red
setw -g window-status-current-attr bright

# 设置面板和活动面板的颜色
set -g pane-border-fg green
set -g pane-border-bg black
set -g pane-active-border-fg white
set -g pane-active-border-bg yellow

# 设置命令行或消息的颜色
set -g message-fg white
set -g message-bg black
set -g message-attr bright

# 设置状态栏左侧的内容和颜色
set -g status-left-length 40
set -g status-left "#[fg=green]Session: #S #[fg=yellow]#I #[fg=cyan]#P"
set -g status-utf8 on

# 设置状态栏右侧的内容和颜色
# 15% | 28 Nov 18:15
set -g status-right "#(~/battery Discharging) | #[fg=cyan]%d %b %R"

# 每 60 秒更新一次状态栏
set -g status-interval 60

# 设置窗口列表居中显示
set -g status-justify centre

# 开启 vi 按键
setw -g mode-keys vi

 
# 在相同目录下使用 tmux-panes 脚本开启面板
unbind v
unbind n
bind v send-keys " ~/tmux-panes -h" C-m
bind n send-keys " ~/tmux-panes -v" C-m

# 临时最大化面板或恢复面板大小
unbind Up
bind Up new-window -d -n tmp \; swap-pane -s tmp.1 \; select-window -t tmp
unbind Down
bind Down last-window \; swap-pane -s tmp.1 \; kill-window -t tmp

# 把日志输出到指定文件
bind P pipe-pane -o "cat >>~/#W.log" \; display "Toggled logging to ~/#W.log"
