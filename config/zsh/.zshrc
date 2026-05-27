#####################
#  PLUGIN MANAGER   #
#####################

# Clone antidote if necessary.
[[ -e ${ZDOTDIR:-$HOME}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote

# Source antidote.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh

# Initialize antidote's dynamic mode, which changes `antidote bundle`
# from static mode.
source <(antidote init)

antidote bundle zsh-users/zsh-autosuggestions
antidote bundle zsh-users/zsh-completions
antidote bundle zsh-users/zsh-syntax-highlighting
antidote bundle ohmyzsh/ohmyzsh path:plugins/dotenv

# Completions
autoload -Uz compinit
# Regenerate completion dump once a day; use cache otherwise
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C  # skip security check, use existing dump
fi

#################################
#     ENVIRONMENT VARIABLES     #
#################################
eval "$(direnv hook zsh)"
export PATH="/opt/homebrew/bin/:/opt/homebrew/sbin:$PATH" # Mac OS machine
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH" # Linux machine
export PATH="/usr/local/sbin:$PATH"
export EDITOR=nvim
export GPG_TTY=$(tty)
export STARSHIP_CONFIG=~/projects/dotfiles/config/starship.toml
export BAT_THEME="Catppuccin Frappe"

# Only export the following TERM for old terminal.
# export TERM=xterm-256color

#################
# LOAD PLUGINS  #
#################
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

###########
# ALIASES #
###########
alias ls="eza --color=always --all --long --git --icons=always"
alias cd="z"
alias cat="bat"

#######
# FZF #
#######

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# -- Theme --
export FZF_DEFAULT_OPTS="--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
  --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
  --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
  --layout=reverse --border"

# -- Previews --
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

#############
# FUNCTIONS #
#############

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}


