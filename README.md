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

- 支持 macOS 和主流 Linux 发行版的一键安装脚本
- 自动识别 Homebrew、APT、DNF、Pacman 或 Zypper
- 安装 zsh、Git、常用终端工具、Oh My Zsh 和 Powerlevel10k
- 自动链接 Zsh 配置；已有文件会先备份到 `~/.dotfiles-backup`
- 可重复执行，并支持 `--dry-run` 预览操作

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

配置默认使用 iTerm2 图片协议，并通过仓库内的 `scope.sh` 提供文本、归档、图片、PDF
和视频预览。建议按需安装以下可选工具；缺少某个工具时，预览脚本会继续尝试其他后端：

```sh
brew install ranger bat highlight jq poppler ffmpegthumbnailer atool
```

常用快捷键：

- `zh`：显示或隐藏点文件
- `zi`：开启或关闭图片预览
- `zp`：开启或关闭文件预览
- `du`：显示当前目录下一级内容的大小
- `dU`：按大小排序显示当前目录下一级内容
- `dT`：将选中文件移到系统废纸篓（需要 ranger 的 `trash` 命令可用）

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
    ./install.sh
    ```

    脚本会自动识别 macOS 或 Linux，并使用当前系统的包管理器安装依赖。
    如需先查看将执行的命令：

    ```sh
    ./install.sh --dry-run
    ```

3. 重新启动终端以应用更改。

## 贡献

欢迎提交 pull requests 来改善这个项目。对于重大更改，请先打开一个 issue 以讨论您想要的更改。

## 许可

本项目采用 MIT 许可。
