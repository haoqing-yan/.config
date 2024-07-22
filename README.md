# 配置文件仓库

这个仓库包含了多个工具和应用程序的配置文件。以下是各个文件和目录的说明：

## 目录结构

```plaintext
.
├── README.md
├── filezilla
│   ├── filezilla.xml
│   ├── layout.xml
│   ├── lockfile
│   ├── queue.sqlite3
│   └── recentservers.xml
├── github-copilot
│   └── versions.json
├── htop
│   └── htoprc
├── install.sh
├── iterm2
│   ├── AppSupport -> /Users/yanhaoqing/Library/Application Support/iTerm2
│   ├── com.googlecode.iterm2.plist
│   └── sockets
├── lazygit
│   └── config.yml
├── ranger
│   ├── rc.conf
│   ├── rifle.conf
│   └── scope.sh
├── thefuck
│   ├── __pycache__
│   ├── rules
│   └── settings.py
└── zsh-config
```

## 文件说明

### `filezilla`

- `filezilla.xml` - FileZilla 配置文件
- `layout.xml` - FileZilla 界面布局配置
- `lockfile` - FileZilla 锁文件
- `queue.sqlite3` - FileZilla 队列文件
- `recentservers.xml` - 最近连接的服务器列表

### `github-copilot`

- `versions.json` - GitHub Copilot 版本信息

### `htop`

- `htoprc` - htop 配置文件

### `install.sh`

- 一键安装脚本，用于安装 Homebrew、zsh、Oh My Zsh、Powerlevel10k 和 colorls，并下载配置文件仓库

### `iterm2`

- `AppSupport` - iTerm2 应用支持目录的符号链接
- `com.googlecode.iterm2.plist` - iTerm2 配置文件
- `sockets` - iTerm2 套接字文件

### `lazygit`

- `config.yml` - lazygit 配置文件

### `ranger`

- `rc.conf` - ranger 主配置文件
- `rifle.conf` - ranger 文件关联配置
- `scope.sh` - ranger 预览脚本

### `thefuck`

- `__pycache__` - thefuck 缓存目录
- `rules` - thefuck 规则目录
- `settings.py` - thefuck 设置文件

### `zsh-config`

- zsh 配置文件目录

## 使用说明

1. 克隆此仓库：

    ```sh
    git clone git@github.com:haoqing-yan/.config.git
    cd .config
    ```

2. 运行安装脚本：

    ```sh
    chmod +x install.sh
    ./install.sh
    ```

    该脚本将安装 Homebrew、zsh、Oh My Zsh、Powerlevel10k 和 colorls，并下载此配置文件仓库。

3. 重新启动终端以应用更改。

## 贡献

欢迎提交 pull requests 来改善这个项目。对于重大更改，请先打开一个 issue 以讨论您想要的更改。

## 许可

本项目采用 MIT 许可。


