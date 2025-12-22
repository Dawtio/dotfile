#!/bin/bash

## Dawtio OS Installer
## Script based on original by Keyitdev https://github.com/Keyitdev/sddm-astronaut-theme
## Copyright (C) 2022-2025 Keyitdev

# Script works in Arch. Didn't tried in Ubuntu yet.

set -euo pipefail

readonly DOTFILE_REPO="https://github.com/Dawtio/dotfiles.git"
readonly PATH_TO_GIT_CLONE="$HOME/projects/dotfiles"
readonly BRANCH="feat/arch"

# TODO: replace these local path by remote one. Will be good for one-line installation.
bash_dir="$(dirname "$0")"
source "$bash_dir/utils.sh"
source "$bash_dir/packages.sh"

# Install dependencies

spicetify_install() {
  curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
  sudo chmod a+wr /opt/spotify
  sudo chmod a+wr /opt/spotify/Apps -R
}

install_deps() {
  local mgr=$(for m in yay pacman apt; do command -v $m &>/dev/null && {
    echo $m
    break
  }; done)
  info "Package manager: $mgr"

  case $mgr in
  yay) yay -S --needed ${PACKAGES[@]} && spicetify_install ;;
  pacman) sudo pacman --needed -S ${PACKAGES[@]} && spicetify_install ;;
  # apt) sudo apt update && sudo apt install -y xxx ;;
  *)
    error "Unsupported package manager"
    return 1
    ;;
  esac
  info "Dependencies installed"
}

arch_post_install() {
  sudo pacman -S --needed git curl neovim reflector

  # backup mirrorlist.
  sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
  # generate new one with chaotic.
  sudo reflector --save /etc/pacman.d/mirrorlist --sort rate --sort age --country "France" --country "Worldwide"

  # set AUR helper.
  git clone https://aur.archlinux.org/yay-bin
  cd yay-bin/
  makepkg -si
  cd ../
  rm -rf yay-bin/

  # Setup Chaotic AUR.
  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf

  # System update
  sudo pacman -Syu
}

install_config() {
  cp -r themes ~/.themes

  cp -r config/hypr/ ~/.config/
  cp -r config/zsh/ ~/.config/
  cp -r config/nvim/ ~/.config/
  cp -r config/colorschemes/ ~/.config/
  cp -r config/gtk-* ~/.config/
  cp -r config/kitty/ ~/.config/
  cp -r config/rofi/ ~/.config/
  cp -r config/swaync/ ~/.config/
  cp -r config/vesktop/ ~/.config/
  cp -r config/waybar/ ~/.config/
  cp -r config/wlogout/ ~/.config/
}

# Main menu
main() {
  [[ $EUID -eq 0 ]] && {
    error "Don't run as root"
    exit 1
  }
  command -v git &>/dev/null || {
    error "git required"
    exit 1
  }

  check_gum
  clear
  while true; do
    if command -v gum &>/dev/null; then
      gum style --bold --padding "0 2" --border double --border-foreground 12 "🚀 Dawtio OS Installer"
    else
      echo -e "\e[36m🚀 Dawtio OS Installer\e[0m"
    fi

    local choice=$(choose \
      "🚀 Complete Installation (recommended)" \
      "🔧 Arch Linux Post Installation steps" \
      "📦 Install Dependencies" \
      "📂 Install Configurations" \
      "📥 Clone Repository" \
      "❌ Exit")

    case "$choice" in
    "🚀 Complete Installation (recommended)") arch_post_install && clone_repo $DOTFILE_REPO $BRANCH $PATH_TO_GIT_CLONE && install_deps && install_config && info "Everything done!" && exit 0 ;;
    "🔧 Arch Linux Post Installation steps") arch_post_install ;;
    "📦 Install Dependencies") install_deps ;;
    "📂 Install Configurations") install_config ;;
    "📥 Clone Repository") clone_repo $DOTFILE_REPO $BRANCH $PATH_TO_GIT_CLONE ;;
    "❌ Exit")
      info "Goodbye!"
      exit 0
      ;;
    esac

    echo
    if command -v gum &>/dev/null; then
      gum input --placeholder="Press Enter to continue..."
    else
      echo -n "Press Enter to continue..."
      read -r
    fi
  done
}

main "$@"
