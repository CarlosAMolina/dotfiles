# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_config ]; then
    . ~/.bash_config
fi

if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
