" To apply changes you can close and open this file or execute:
" :so %
" :so = source, % = current buffer file.

" Vim-plug configuration
" https://github.com/junegunn/vim-plug#neovim
call plug#begin()
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" nvim-tree
Plug 'nvim-tree/nvim-tree.lua'
" nightfox
Plug 'EdenEast/nightfox.nvim'
" telescope
" After installation run `:checkhealth telescope`
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" Neovim configuration
set clipboard+=unnamedplus
" View
" Number of lines to start scrolling before reaching the top or bottom of the page.
set scrolloff=8
set number
set relativenumber
"https://vi.stackexchange.com/questions/6950/how-to-enable-spell-check-for-certain-file-types
augroup markdownSpell
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md,*.txt setlocal spell
augroup END
set spelllang=es
" Indentation
" https://stackoverflow.com/questions/51995128/setting-autoindentation-to-spaces-in-neovim
" https://vi.stackexchange.com/questions/5818/what-is-the-difference-between-autoindent-and-smartindent-in-vimrc
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
" Color
" https://github.com/EdenEast/nightfox.nvim
colorscheme nightfox

" Remaps
" mapleader: expected key to press when `<leader>` is used.
" Default mapleader is ctrl + \
let mapleader = " "
" How to remap:
" First character indicates when the remap must be executed:
" n: the current mode you are in
" i: insert mode
" v: visual mode
" c: command mode
" t: terminal mode
" Other characters:
" nore: no recursive execution. To avoid the remap can execute more remaps.
" map: the map command.
" Table of key notation: type `:help keycodes`

" Source vimrc
" <CR> = enter
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
" Close other vim windows
nnoremap <leader>o :only<CR>
" Split
nnoremap <leader>s :split<CR>
nnoremap <leader>vs :vsplit<CR>
" Sort
nnoremap <leader>so <C-v>G:sort<CR>
" Sort and unique
nnoremap <leader>u <C-v>G:sort u<CR>

" Coc configuration
" https://github.com/neoclide/coc.nvim#example-vim-configuration
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

" Telescope configuration
" https://github.com/nvim-telescope/telescope.nvim
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" nvim-tree configuration
nnoremap <leader>t <cmd>NvimTreeToggle<cr>

lua require'nvim-tree'.setup {}
