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
# Color output
# https://wiki.archlinux.org/title/Color_output_in_console
alias grep='grep --color=auto'
alias ls='ls --color=auto'
# Git
alias ga='git add'
alias gb='git branch'
alias gbc='git branch --show-current'
alias gc='git commit -m'
alias gd='git diff'
alias gl='git log'
alias gs='git status -s'
# Open files/folders
alias o='xdg-open'
# Screen
# https://unix.stackexchange.com/questions/3773/how-to-pass-parameters-to-an-alias
alias screen='f(){ xrandr --output eDP-1 --auto && xrandr --output $1 --auto && xrandr --output eDP-1 --left-of $1;  unset -f f; }; f'
# Python programs
alias toc='python ~/Software/toc-markdown/src/main.py'
# Tmux
alias t='tmux'
# Trash-cli
alias rm='echo "This is not the command you are looking for."; false'
alias tp='trash-put'
# Vi
alias vi='nvim'

