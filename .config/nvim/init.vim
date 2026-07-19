" Other Neovim configurations:
" - File URL: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

" To apply changes you can close and open this file or execute:
" :so %
" :so = source, % = current buffer file.

" Vim-plug configuration
" https://github.com/junegunn/vim-plug#neovim
" Default path: ~/.local/share/nvim/plugged/
call plug#begin()
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" git
Plug 'https://github.com/tpope/vim-fugitive.git'
" js
" https://x-team.com/blog/neovim-javascript/
" these two plugins will add highlighting and indenting to JSX and TSX files.
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" nvim-tree
Plug 'nvim-tree/nvim-tree.lua'
" nightfox
Plug 'EdenEast/nightfox.nvim'
" telescope
" After installation run `:checkhealth telescope`
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': 'master' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" csv files
" https://github.com/mechatroner/rainbow_csv
Plug 'mechatroner/rainbow_csv'
call plug#end()

" Neovim configuration
lua << EOF
    -- Coc extensions
    -- Install automatically
    -- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#use-vims-plugin-manager-for-coc-extension
    -- coc-go
    -- - https://github.com/josa42/coc-go
    -- - https://pmihaylov.com/vim-for-go-development/
    vim.g.coc_global_extensions = {'coc-sql', 'coc-rust-analyzer', 'coc-pyright', 'coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-go'}
    -- Sync clipboard between OS and Neovim.
    --  Schedule the setting after `UiEnter` because it can increase startup-time.
    --  Remove this option if you want your OS clipboard to remain independent.
    --  See `:help 'clipboard'`
    vim.schedule(function()
      vim.opt.clipboard = 'unnamedplus'
    end)

    -- View
    -- Minimal number of screen lines to keep above and below the cursor.
    vim.opt.scrolloff = 8
    vim.opt.number = true
    vim.opt.relativenumber = true

    -- Coc configuration
    -- https://github.com/neoclide/coc.nvim#example-vim-configuration
    -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
    -- delays and poor user experience
    vim.opt.updatetime = 250

    -- Decrease mapped sequence wait time
    vim.opt.timeoutlen = 300

    -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    vim.opt.ignorecase = true
    vim.opt.smartcase = true

    -- Sets how neovim will display certain whitespace characters in the editor.
    --  See `:help 'list'`
    --  and `:help 'listchars'`
    vim.opt.list = true
    vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

    -- Preview substitutions live, as you type!
    vim.opt.inccommand = 'split'

    -- Show which line your cursor is on
    vim.opt.cursorline = true

    -- Clear highlights on search when pressing <Esc> in normal mode
    --  See `:help hlsearch`
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

    -- Keybinds to make split navigation easier.
    --  Use CTRL+<hjkl> to switch between windows
    --  See `:help wincmd` for a list of all window commands
    vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
    --vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
    --vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

    -- [[ Basic Autocommands ]]
    --  See `:help lua-guide-autocommands`

    -- Highlight when yanking (copying) text
    --  Try it with `yap` in normal mode
    --  See `:help vim.highlight.on_yank()`
    vim.api.nvim_create_autocmd('TextYankPost', {
      desc = 'Highlight when yanking (copying) text',
      group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
      callback = function()
        vim.highlight.on_yank()
      end,
    })
EOF
"https://vi.stackexchange.com/questions/6950/how-to-enable-spell-check-for-certain-file-types
augroup markdownSpell
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md,*.txt setlocal spell
augroup END
" Spell language check. Available options: en, es
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

lua << EOF
    -- Remaps
    -- How to remap:
    -- First character indicates when the remap must be executed:
    -- n: the current mode you are in
    -- i: insert mode
    -- v: visual mode
    -- c: command mode
    -- t: terminal mode
    -- Other characters:
    -- nore: no recursive execution. To avoid the remap can execute more remaps.
    -- map: the map command.
    -- Table of key notation: type `:help keycodes`

    -- mapleader: expected key to press when `<leader>` is used.
    -- Default mapleader is ctrl + \
    -- Set <space> as the leader key
    -- See `:help mapleader`
    --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    -- Quit
    vim.keymap.set('n', '<leader>q', ':quit<CR>')
    vim.keymap.set('n', '<leader>qa', ':qa<CR>')

    -- Source vimrc
    -- <CR> = enter
    -- TODO change to init.lua when migrated.
    vim.keymap.set('n', '<leader><CR>', ':so ~/.config/nvim/init.vim<CR>')

    -- Reload file
    vim.keymap.set('n', '<leader>e', ':e<CR>')

    -- Close other vim windows
    vim.keymap.set('n', '<leader>o', ':only<CR>')

    -- Move line(s)
    -- https://vimtricks.com/p/vimtrick-moving-lines/
    vim.keymap.set('n', '<c-j>', ':m .+1<CR>==')
    vim.keymap.set('n', '<c-k>', ':m .-2<CR>==')
    vim.keymap.set('v', '<c-j>', ':m \'>+1<CR>gv==gv')
    vim.keymap.set('v', '<c-k>', ':m \'<-2<CR>gv==gv')

    -- Split
    vim.keymap.set('n', '<leader>sh', ':split<CR>')
    vim.keymap.set('n', '<leader>sv', ':vsplit<CR>')

    -- Sort the selection.
    vim.keymap.set('v', '<leader>sos', ':sort<CR>')
    -- Sort all from current line to the end of the file.
    vim.keymap.set('n', '<leader>soa <C-v>G', ':sort<CR>')
    -- Sort and unique the selection.
    vim.keymap.set('v', '<leader>us', ':sort u<CR>')
    -- Sort and unique from current line to the end of the file.
    vim.keymap.set('n', '<leader>ua <C-v>G', ':sort u<CR>')
EOF

" Coc configuration
" https://github.com/neoclide/coc.nvim#example-vim-configuration
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

lua << EOF
  -- I have this problema in mac: https://stackoverflow.com/questions/65160481/neovim-on-windows-cant-find-python-provider
  -- Get the path of python3 using the 'which' command
  local handle = io.popen("which python3")
  local python3_path = handle:read("*a"):gsub("%s+", "") -- Read the output and trim whitespace
  handle:close()
  vim.g.python3_host_prog = python3_path
EOF

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" GoTo code navigation
nmap <silent> gde <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

lua << EOF
  -- coc-sql configuration
  -- https://github.com/fannheyward/coc-sql
  -- Format sql commands (they must be in a `.sql` file):
  vim.keymap.set('n', '<leader>f', ':CocCommand sql.Format<cr>')
EOF

" Fugitive Conflict Resolution
" https://medium.com/prodopsio/solving-git-merge-conflicts-with-vim-c8a8617e3633
" Open three-way split screen
nnoremap <leader>gdi :Gvdiffsplit!<CR>
" Get the changes from the buffer with //2 in its name (left screen).
nnoremap gdh :diffget //2<CR>
" Get the changes from the buffer with //2 in its name (right screen).
nnoremap gdl :diffget //3<CR>
" Go to previous conflict: [c
" Go to next conflict: ]c

lua << EOF
  -- Telescope configuration
  -- https://github.com/nvim-telescope/telescope.nvim
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
  vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
  vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
  vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

  -- nvim-tree configuration
  -- https://github.com/nvim-tree/nvim-tree.lua
  vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>')
  -- Open tree and focus on current file
  vim.keymap.set('n', '<leader>p', '<cmd>NvimTreeFindFile<cr>')
  -- https://neovim.io/doc/user/lua-guide.html
  -- https://www.reddit.com/r/neovim/comments/12a1a81/nvimtree_close_on_open_file_confused_on_how_to/?rdt=40062
  require('nvim-tree').setup({
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  })
  -- Show only text, clean other screen information
  vim.keymap.set('n', '<leader>0', function()
    -- https://stackoverflow.com/questions/7770413/remove-vim-bottom-line-with-mode-line-column-etc
    vim.opt.showmode = false
    vim.opt.ruler = false
    vim.opt.cmdheight = 0
    -- Remove status bar: https://github.com/neovim/neovim/issues/8059
    vim.opt.laststatus = 0
    -- Remove line numbers
    vim.opt.number = false
    vim.opt.relativenumber = false
    -- Not show which line your cursor is on
    vim.opt.cursorline = false
    -- Invisible cursor: https://github.com/neovim/neovim/issues/3688#issuecomment-574544618
    -- https://neovim.io/doc/user/lua-guide.html, search highlight
    vim.cmd.highlight({ 'Cursor', 'blend=100' })
    vim.o.guicursor = 'a:Cursor/lCursor'
  end)
EOF
