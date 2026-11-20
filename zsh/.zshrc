# Portable zsh setup: Mac, Linux workstations and the EKS developer home.
# Anything that belongs to one machine (paths, accounts, tokens) goes in
# ~/.zshrc.local, which is sourced last and never committed.

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git z fzf vi-mode zsh-autosuggestions zsh-syntax-highlighting)
command -v asdf >/dev/null 2>&1 && plugins+=(asdf)
source "$ZSH/oh-my-zsh.sh"

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export EDITOR='vim'

# An API key in the environment beats the OAuth login in Claude Code.
unset ANTHROPIC_API_KEY

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window=down:3:hidden:wrap --bind='ctrl-/:toggle-preview'"
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

autoload -Uz compinit
compinit

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
