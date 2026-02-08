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
# Color output: https://wiki.archlinux.org/title/Color_output_in_console
alias grep='grep --color=auto'
exclude_dirs={.angular,.eggs,.git,.idea,.pytest_cache,.ruff_cache,.tox,__pycache__,build,env,env_*,htmlcov,node_modules}
function gre() {
    eval "grep $@ --color=auto --exclude-dir=$exclude_dirs"
}
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
alias pull='git pull origin $(gbc)'
alias push='git push origin $(gbc)'
alias gs='git status -s'
alias gsh='git show'
alias k='keepassxc > /dev/null 2>&1 &'
# Open files/folders
alias o='xdg-open'
# Replace. Replace all files recursively from the current directory.
function replace() {
    is_whole_word_match=false
    if [ "$1" == "-w" ]; then
        is_whole_word_match=true
        shift  # Remove the first argument
    fi
    if [ $# -eq 2 ]; then
        old_term="${@:$#-1:1}"  # Second to last argument
        new_term="${!#}"   # Last argument
    else
        echo "[ERROR] At least two arguments are required"
        return 1
    fi
    sed_command="sed -i"
    sed_pattern="$old_term"
    sed_replacement="$new_term"
    case $(uname) in
        Darwin)  # MacOS
            sed_command="$sed_command ''"
            ;;
    esac
    if [ "$is_whole_word_match" == true ]; then
        sed_command="$sed_command -E"
        case $(uname) in
            Darwin)  # MacOS
                sed_pattern="(^|[^[:alnum:]_])$sed_pattern([^[:alnum:]_]|$)"
                sed_replacement="\1$sed_replacement\2"  # \1 and \2 are required to not lose word boundaries.
                ;;
            *)  # Linux.
                sed_pattern="\<$sed_pattern\>"
                ;;
        esac
    fi
    for file_path in $(eval "grep -rl $old_term --exclude-dir=$exclude_dirs ."); do
        echo "[DEBUG] Replacing $file_path"
        #echo "$sed_command 's/$sed_pattern/$sed_replacement/g' $file_path"
        eval "$sed_command 's/$sed_pattern/$sed_replacement/g' $file_path"
    done
    echo "[DEBUG] Done. Replaced '$old_term' with '$new_term'"
}
# Screen
# https://unix.stackexchange.com/questions/3773/how-to-pass-parameters-to-an-alias
#alias screen='f(){ xrandr --output eDP-1 --auto && xrandr --output $1 --auto && xrandr --output eDP-1 --left-of $1;  unset -f f; }; f'
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
    case $(uname) in
      # https://stackoverflow.com/questions/29081799/sed-1-invalid-command-code-f
      *BSD*|Darwin)  SED_INPLACE=(-i '') ;;  # BSD or MacOS.
      *)             SED_INPLACE=(-i)    ;;
    esac
    sed "${SED_INPLACE[@]}" "s/set spelllang=.*/set spelllang=${1}/g" $HOME/.config/nvim/init.vim
}
# Change current user session state
alias off='systemctl poweroff' # Linux
alias offb='sudo poweroff' # FreeBSD

###########################
# Exports
###########################
case $(uname) in
  Darwin)
    # Docker using colima (https://stackoverflow.com/a/72560928)
    export DOCKER_HOST=unix://$HOME/.colima/docker.sock
    ;;
  *)
    # Docker rootless
    export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
    ;;
esac
# https://stackoverflow.com/questions/18088372/how-to-npm-install-global-not-as-root
export PATH=~/.local/bin/:$PATH
export PATH=~/.local/pipx/venvs/poetry/bin/poetry:$PATH
export PATH=$PATH:~/.local/bin/go/bin

###########################
# Source
###########################
[ -f ~/.bashrc-job ] && source ~/.bashrc-job
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

###########################
# Terminal configuration
###########################
get_short_dir() {
    local dir_name=$(basename "$PWD")
    if [ ${#dir_name} -gt 10 ]; then
        echo "${dir_name:0:3}...${dir_name: -3}"
    else
        echo "$dir_name"
    fi
}
# https://wiki.archlinux.org/title/Bash/Prompt_customization
#PS1='[\u@\h \W]\$ '
# To call get_short_dir each time the path changes, we escape the '$' (https://wiki.archlinux.org/title/Bash/Prompt_customization)
PS1="[\$(get_short_dir)]\$ "
# https://www.reddit.com/r/linuxquestions/comments/18x2vjw/is_it_possible_to_change_ps1_color_when_in_a_ssh/?rdt=57427
if [ -n "$SSH_TTY" ]; then
    PS1="[ssh@${PS1:1}"
fi

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

# https://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
# command -v tmux &> /dev/null: check command existence
# [ -n "$PS1" ]: check for interactive shell
# [[ ! "$TERM" =~ screen ]]: check if does not contain `screen`
# [[ ! "$TERM" =~ tmux ]]: check if does not contain `tmux`
# [ -z "$TMUX" ]: check if it is empty
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#fi

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
[ -f ~/.config/nvm/nvm.sh ] && source ~/.config/nvm/nvm.sh
[ -f ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
