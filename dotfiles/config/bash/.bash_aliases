# If not exist, add the following lines to the `~/.bashrc file`:
# ```bash
# # Alias definitions.
# # You may want to put all your additions into a separate file like
# # ~/.bash_aliases, instead of adding them here directly.
# # See /usr/share/doc/bash-doc/examples in the bash-doc package.
#
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi
# ```

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
# Trash-cli
alias rm='echo "This is not the command you are looking for."; false'
alias tp='trash-put'
# Vi
alias vi='~/Software/neovim/nvim.appimage'

