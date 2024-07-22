#!/bin/bash

# 安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 确保 Homebrew 可用
if ! command -v brew &>/dev/null; then
  echo "Homebrew 安装失败"
  exit 1
fi

# 安装 colorls
brew install ruby
gem install colorls

# 确保 colorls 可用
if ! command -v colorls &>/dev/null; then
  echo "colorls 安装失败"
  exit 1
fi

# 下载 Git 仓库
git clone git@github.com:haoqing-yan/.config.git ~/.config

# 确保仓库下载成功
if [ ! -d ".config" ]; then
  echo "Git 仓库下载失败"
  exit 1
fi

echo "所有操作完成！"
