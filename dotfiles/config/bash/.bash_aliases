# Configuration
#
# - If not exist, add the following lines to the `~/.bashrc file`:
#   ```bash
#   # Alias definitions.
#   # You may want to put all your additions into a separate file like
#   # ~/.bash_aliases, instead of adding them here directly.
#   # See /usr/share/doc/bash-doc/examples in the bash-doc package.
#
#   if [ -f ~/.bash_aliases ]; then
#       . ~/.bash_aliases
#   fi
#   ```
#
# - Copy this file to `~`:
#   ```bash
#   cp bash_aliases ~
#   ```
#
# - Reload `.bashrc`:
#   ```bash
#   source ~/.bashrc
#   ```

# Backlight
# https://wiki.archlinux.org/title/Backlight#Backlight_utilities
alias b='xrandr --output eDP-1 --brightness $1'
# Clipboard
# https://stackoverflow.com/questions/5130968/how-can-i-copy-the-output-of-a-command-directly-into-my-clipboard
alias c='xclip' # Example: pwd | c
alias v='xclip -o' # Example: cd `v`
# Git
alias ga='git add'
alias gb='git branch'
alias gc='git commit -m'
alias gd='git diff'
alias gl='git log'
alias gs='git status -s'
# Open files/folders
alias o='xdg-open'
# Python programs
alias toc='python ~/Software/toc-markdown/src/main.py'
# Tmux
alias t='tmux'
# Trash-cli
alias rm='echo "This is not the command you are looking for."; false'
alias tp='trash-put'
# Vi
alias vi='~/Software/neovim/nvim.appimage'

