# dotfiles

zsh (oh-my-zsh), tmux (tpm) and vim (Vundle) settings shared by my Mac, Linux
workstation and EKS developer home.

```sh
git clone https://github.com/jrvlima/dotfiles ~/.dotfiles
~/.dotfiles/install.sh            # DOTFILES_BASH_TO_ZSH=1 on the developer home
```

`install.sh` links `.zshrc`, `.tmux.conf` and `.vimrc`, clones oh-my-zsh and its
two custom plugins, tpm, catppuccin and Vundle, then installs the tmux and vim
plugins. Existing files are moved aside to `<name>.pre-dotfiles`.

Plugins are fetched, not committed. Machine-specific settings (paths, accounts,
anything secret) belong in `~/.zshrc.local`, which is never committed.
