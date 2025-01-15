source ~/dotfile/zsh/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Useful bundles.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply

# some env
eval "$(direnv hook zsh)"
export PATH="/usr/local/sbin:$PATH"

# some configuration
export EDITOR=nvim
export TERM=xterm-256color

# GPG configuration
export GPG_TTY=$(tty)

# Aliases
alias ls="exa --tree --classify --all --level=1"
alias ls2="exa --tree --classify --all --level=2"
alias ls3="exa --tree --classify --all --level=3"
source ~/dotfile/zsh/k8s_aliases
source ~/dotfile/zsh/oc_aliases
## K8s
function decode_kubernetes_secret {
  kubectl get secret $@ -o json | jq '.data | map_values(@base64d)'
}
alias gksec="decode_kubernetes_secret"

# Powerlevel10k configuration
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/dotfile/zsh/.p10k.zsh ]] || source ~/dotfile/zsh/.p10k.zsh

# Autocompletion for oc
if [ $command[oc] ]; then
	source <(oc completion zsh)
	compdef _oc oc
fi
