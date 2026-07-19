" https://unix.stackexchange.com/questions/595256/creating-vimrc-breaks-vim#597550
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" Indentation
" https://vim.fandom.com/wiki/Indenting_source_code
set expandtab           " Indent with spaces 
set shiftwidth=4        " Indent with 4 spaces 
set softtabstop=4       " Indent with 4 spaces

" Paste
" Prevents Vim from auto-indenting the pasted code.
" https://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x/7053522#7053522
" Not use `set paste` because produces errors.
if &term =~ "screen"
  let &t_BE = "\e[?2004h"
  let &t_BD = "\e[?2004l"
  exec "set t_PS=\e[200~"
  exec "set t_PE=\e[201~"
endif
set clipboard=unnamed   " Using the clipboard as the default register.
                        " if vim -version | grep clibpboard == -clipboard and
                        " -xterm_clipboard -> apt-get install vim-gtk

" Screen information.
set laststatus=2        " Displaying status line always.
set nu                  " Show line numbers.
set rnu                 " Line numbers relative to the current line.

" Tmux
" https://unix.stackexchange.com/questions/348771/why-do-vim-colors-look-different-inside-and-outside-of-tmux
set bg=dark             " Avoid color errors with tmux.
