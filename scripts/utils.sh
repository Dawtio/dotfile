#!/bin/bash

## Dawtio OS Installer
## Script based on original by Keyitdev https://github.com/Keyitdev/sddm-astronaut-theme
## Copyright (C) 2022-2025 Keyitdev

# Script works in Arch. Didn't tried in Ubuntu yet.

# Logging with gum fallback
info() {
  if command -v gum &>/dev/null; then
    gum style --foreground 10 "✅ $*"
  else
    echo -e "\e[32m✅ $*\e[0m"
  fi
}

warn() {
  if command -v gum &>/dev/null; then
    gum style --foreground 11 "⚠  $*"
  else
    echo -e "\e[33m⚠  $*\e[0m"
  fi
}

error() {
  if command -v gum &>/dev/null; then
    gum style --foreground 9 "❌ $*" >&2
  else
    echo -e "\e[31m❌ $*\e[0m" >&2
  fi
}

# UI functions
confirm() {
  if command -v gum &>/dev/null; then
    gum confirm "$1"
  else
    echo -n "$1 (y/n): "
    read -r r
    [[ "$r" =~ ^[Yy]$ ]]
  fi
}

choose() {
  if command -v gum &>/dev/null; then
    gum choose --cursor.foreground 12 --header="" --header.foreground 12 "$@"
  else
    select opt in "$@"; do [[ -n "$opt" ]] && {
      echo "$opt"
      break
    }; done
  fi
}

spin() {
  local title="$1"
  shift
  if command -v gum &>/dev/null; then
    gum spin --spinner="dot" --title="$title" -- "$@"
  else
    echo "$title"
    "$@"
  fi
}

# Install gum if missing
install_gum() {
  local mgr=$(for m in pacman apt; do command -v $m &>/dev/null && {
    echo $m
    break
  }; done)

  case $mgr in
  pacman) sudo pacman -S gum ;;
  apt)
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update && sudo apt install gum
    ;;
  *)
    error "Cannot install gum automatically"
    return 1
    ;;
  esac
}

# Check and install gum
check_gum() {
  if ! command -v gum &>/dev/null; then
    warn "Gum was not found - provides better UI experience"
    if confirm "Install gum?"; then
      install_gum && {
        info "Restarting with gum..."
        main
      } || warn "Using fallback UI"
    fi
  fi
}

# Clone repository
clone_repo() {
  local repo="$1"
  local branch="$2"
  local path="$3"
  [[ -d "$path" ]] && mv "$path" "${path}_$(date +%s)"
  spin "Cloning repository..." git clone -b $branch --depth 1 "$DOTFILE_REPO" "$path"
  info "Repository cloned to $path"
}
