# If not running interactively, don't do anything
[[ $- != *i* ]] && return

###########################
# Alias
###########################
# Backlight
# https://wiki.archlinux.org/title/Backlight#Backlight_utilities
#alias b='xrandr --output eDP-1 --brightness $1'
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
# https://stackoverflow.com/questions/70349068/shell-remove-space-before-variable-in-alias
# Run example: gclone CarlosAMolina/cmoli.es
gclone () {
    git clone git@github.com:"$1"
}
# Commmit without running pre-commit
alias gcn='git commit -nm'
alias gca='git commit --amend'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gpull='git pull origin $(gbc)'
alias gpush='git push origin $(gbc)'
alias gs='git status -s'
alias k='keepassxc > /dev/null 2>&1 &'
# Open files/folders
alias o='xdg-open'
# Replace
# Replaces all files recursively from the current directory.
alias replace='f(){ grep -rlZe "$1" --exclude-dir={env,.git,node_modules,__pycache__} . | xargs -0 sed -i \''s/$1/$2/g\'' && echo Done. Replaced -$1- with -$2-;  unset -f f; }; f'
# Screen
# https://unix.stackexchange.com/questions/3773/how-to-pass-parameters-to-an-alias
alias screen='f(){ xrandr --output eDP-1 --auto && xrandr --output $1 --auto && xrandr --output eDP-1 --left-of $1;  unset -f f; }; f'
# Screenshot
alias screenshot='flameshot &'
# Python programs
alias toc='python ~/Software/toc-markdown/src/main.py'
# Tmux
#alias t='tmux'
# Trash-cli
alias rm='echo "This is not the command you are looking for."; false'
alias tp='trash-put'
# Vi
alias vi='nvim'
# Change nvim spell check language
# Run example: vispell en
# Run example: vispell es
vispell () {
    sed -i 's/set spelllang=.*/set spelllang='"$1"'/g' ~/.config/nvim/init.vim
}
# Change current user session state
alias off='systemctl poweroff'

###########################
# Terminal configuration
###########################
# https://wiki.archlinux.org/title/Bash/Prompt_customization
PS1='[\u@\h \W]\$ '

# https://stackoverflow.com/questions/15121181/terminal-emulator-or-shell-with-vim-like-commands
set -o vi

# https://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
log () {
    TMUX_LOGS=false;
    if "$TMUX_LOGS";
    then
        echo "$1"
    fi
}

log "1) Check tmux command availability: command -v tmux &> /dev/null"
if command -v tmux &> /dev/null;
then
    log ok
    log
    log "2) Check if it is the desired terminal TERM=$TERM"
    if [[ "$TERM" == "st-256color" ]] || [[ "$TERM" == "xterm-256color" ]];
    then
        log ok
        log
        log "3) Check if it is empty: -z TMUX. TMUX=$TMUX"
        if [ -z "$TMUX" ];
        then
            log ok
            log
            # https://stackoverflow.com/questions/10475599/what-does-n-mean-in-bash
            log "4) Check for interactive shell (PS1 is not empty): [ -n PS1 ]. PS1=$PS1"
            if [ -n "$PS1" ];
            then
                log ok, this shell is interactive
                exec tmux
            else
                log ko, this shell is not interactive
            fi
        else
            log ko
        fi
    else
        log ko
    fi
else
    log ko
fi

# https://stackoverflow.com/questions/16904658/node-version-manager-install-nvm-command-not-found#17707224
source ~/.nvm/nvm.sh

if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
