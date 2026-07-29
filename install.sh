#!/usr/bin/env bash

set -Eeuo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/haoqing-yan/.config.git}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m警告:\033[0m %s\n' "$*" >&2; }
die() { printf '\033[1;31m错误:\033[0m %s\n' "$*" >&2; exit 1; }

run() {
  if ((DRY_RUN)); then
    printf '[dry-run]'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

usage() {
  printf '%s\n' \
    '用法: ./install.sh [--dry-run]' \
    '' \
    '一键安装并配置 macOS / Linux 的终端环境。' \
    '  --dry-run    只显示将执行的操作' \
    '  -h, --help   显示帮助'
}

while (($#)); do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    -h|--help) usage; exit 0 ;;
    *) die "未知参数: $1" ;;
  esac
  shift
done

command_exists() { command -v "$1" >/dev/null 2>&1; }

sudo_run() {
  if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
    run "$@"
  elif command_exists sudo; then
    run sudo "$@"
  else
    die "安装软件需要 root 权限，但系统中没有 sudo"
  fi
}

install_packages() {
  case "$1" in
    macos)
      if ! command_exists brew; then
        if ((DRY_RUN)); then
          log "将安装 Homebrew"
          return
        fi
        log "安装 Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [[ -x /opt/homebrew/bin/brew ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -x /usr/local/bin/brew ]]; then
          eval "$(/usr/local/bin/brew shellenv)"
        fi
      fi
      command_exists brew || die "Homebrew 不可用"
      run brew install zsh git curl htop ranger lazygit
      ;;
    linux)
      if command_exists apt-get; then
        sudo_run apt-get update
        sudo_run apt-get install -y zsh git curl htop ranger
      elif command_exists dnf; then
        sudo_run dnf install -y zsh git curl htop ranger
      elif command_exists pacman; then
        sudo_run pacman -Syu --needed --noconfirm zsh git curl htop ranger lazygit
      elif command_exists zypper; then
        sudo_run zypper --non-interactive install zsh git curl htop ranger
      else
        die "未找到受支持的包管理器（apt、dnf、pacman 或 zypper）"
      fi
      ;;
  esac
}

backup_and_link() {
  local source=$1 target=$2
  [[ -e "$source" ]] || return 0

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    return 0
  fi
  if [[ -e "$target" || -L "$target" ]]; then
    run mkdir -p "$BACKUP_DIR"
    log "备份 $target 到 $BACKUP_DIR/"
    run mv "$target" "$BACKUP_DIR/"
  fi
  run mkdir -p "$(dirname "$target")"
  run ln -s "$source" "$target"
}

case "$(uname -s)" in
  Darwin) OS=macos ;;
  Linux) OS=linux ;;
  *) die "暂不支持的系统: $(uname -s)" ;;
esac

log "检测到系统: $OS"
install_packages "$OS"

# 在仓库内执行时直接使用当前仓库；独立下载脚本时自动克隆。
if [[ ! -f "$SCRIPT_DIR/zsh-config/.zshrc" ]]; then
  if [[ -e "$CONFIG_DIR" && -n "$(ls -A "$CONFIG_DIR" 2>/dev/null)" ]]; then
    die "$CONFIG_DIR 已存在且不是本仓库，请在仓库目录中运行本脚本"
  fi
  log "克隆配置仓库到 $CONFIG_DIR"
  run git clone "$REPO_URL" "$CONFIG_DIR"
  SCRIPT_DIR="$CONFIG_DIR"
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log "安装 Oh My Zsh"
  if ((DRY_RUN)); then
    printf '[dry-run] 安装 Oh My Zsh（无人值守模式）\n'
  else
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
fi

ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
P10K_DIR="$ZSH_CUSTOM_DIR/themes/powerlevel10k"
if [[ ! -d "$P10K_DIR/.git" ]]; then
  log "安装 Powerlevel10k"
  run git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

log "链接 Zsh 配置"
backup_and_link "$SCRIPT_DIR/zsh-config/.zshrc" "$HOME/.zshrc"
backup_and_link "$SCRIPT_DIR/zsh-config/.p10k.zsh" "$HOME/.p10k.zsh"

if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  warn "当前默认 Shell 不是 zsh。如需切换，请运行: chsh -s \"$(command -v zsh)\""
fi

log "配置完成。重新打开终端，或运行: exec zsh"
