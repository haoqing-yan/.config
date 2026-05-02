#!/bin/bash

set -euo pipefail

REPO_SSH_URL="git@github.com:haoqing-yan/.config.git"
REPO_HTTPS_URL="https://github.com/haoqing-yan/.config.git"
TARGET_DIR=".config"

# 安装 Homebrew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 确保 Homebrew 可用
if ! command -v brew &>/dev/null; then
  echo "Homebrew 安装失败"
  exit 1
fi

# 安装 zsh
brew list zsh &>/dev/null || brew install zsh

# 确保 zsh 可用
if ! command -v zsh &>/dev/null; then
  echo "zsh 安装失败"
  exit 1
fi

# 安装 Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# 安装 Powerlevel10k 主题
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# 设置 Powerlevel10k 主题
sed -i '' 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# 安装 colorls
brew list ruby &>/dev/null || brew install ruby
gem list -i colorls >/dev/null || gem install colorls

# 确保 colorls 可用
if ! command -v colorls &>/dev/null; then
  echo "colorls 安装失败"
  exit 1
fi

# 下载 Git 仓库
if [ ! -d "$TARGET_DIR" ]; then
  if ! git clone "$REPO_SSH_URL" "$TARGET_DIR"; then
    echo "SSH 克隆失败，尝试使用 HTTPS..."
    git clone "$REPO_HTTPS_URL" "$TARGET_DIR"
  fi
fi

# 确保仓库下载成功
if [ ! -d "$TARGET_DIR" ]; then
  echo "Git 仓库下载失败"
  exit 1
fi

echo "所有操作完成！请重新启动终端以应用更改。"
