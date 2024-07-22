#!/bin/bash

# 安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 确保 Homebrew 可用
if ! command -v brew &>/dev/null; then
  echo "Homebrew 安装失败"
  exit 1
fi

# 安装 zsh
brew install zsh

# 确保 zsh 可用
if ! command -v zsh &>/dev/null; then
  echo "zsh 安装失败"
  exit 1
fi

# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 安装 Powerlevel10k 主题
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 设置 Powerlevel10k 主题
sed -i '' 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# 安装 colorls
brew install ruby
gem install colorls

# 确保 colorls 可用
if ! command -v colorls &>/dev/null; then
  echo "colorls 安装失败"
  exit 1
fi

# 下载 Git 仓库
git clone git@github.com:haoqing-yan/.config.git

# 确保仓库下载成功
if [ ! -d ".config" ]; then
  echo "Git 仓库下载失败"
  exit 1
fi

echo "所有操作完成！请重新启动终端以应用更改。"
