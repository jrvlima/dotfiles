#!/usr/bin/env bash
# Link these dotfiles into $HOME and fetch the plugin managers they expect.
# Safe to rerun: clones are skipped when present, and an existing file that is
# not already our link is moved aside to <name>.pre-dotfiles.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$here/$1" dst="$HOME/$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ "$(readlink "$dst")" != "$src" ]; then
    mv "$dst" "$dst.pre-dotfiles"
  fi
  ln -sfn "$src" "$dst"
}

clone() {
  [ -d "$2" ] || git clone --depth 1 --quiet "$1" "$2"
}

link zsh/.zshrc .zshrc
link tmux/.tmux.conf .tmux.conf
link vim/.vimrc .vimrc

clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
custom="$HOME/.oh-my-zsh/custom/plugins"
clone https://github.com/zsh-users/zsh-autosuggestions.git "$custom/zsh-autosuggestions"
clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom/zsh-syntax-highlighting"

clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"
clone https://github.com/catppuccin/tmux.git "$HOME/.config/tmux/plugins/catppuccin/tmux"
"$HOME/.tmux/plugins/tpm/bin/install_plugins" >/dev/null

clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
# .vimrc uses both managers: Vundle for most plugins, vim-plug for coc.nvim
# and a few others (coc builds itself with npm).
plug="$HOME/.vim/autoload/plug.vim"
[ -f "$plug" ] || curl -fsSLo "$plug" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -E -s -u "$HOME/.vimrc" +PluginInstall +PlugInstall +qall </dev/null || true

# A machine whose login shell cannot be changed (the EKS home: /etc/passwd
# comes from the image) still gets zsh for interactive logins.
if [ "${DOTFILES_BASH_TO_ZSH:-}" = 1 ] && [ ! -e "$HOME/.bash_profile" ]; then
  cat >"$HOME/.bash_profile" <<'EOF'
[ -f ~/.profile ] && . ~/.profile
case $- in *i*) command -v zsh >/dev/null && exec zsh -l ;; esac
EOF
fi

echo "dotfiles installed; machine-specific settings go in ~/.zshrc.local"
