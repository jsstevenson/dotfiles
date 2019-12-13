""" vim-plug https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Theme & layout
Plug 'iCyMind/NeoSolarized'     " https://github.com/icymind/NeoSolarized
Plug 'vim-airline/vim-airline'  " https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline-themes'   " https://github.com/vim-airline/vim-airline-themes
"Plug 'tpope/vim-obsession'      " Save sessions//not currently using

" IDE-y things
Plug 'nicwest/vim-http'         " https://github.com/nicwest/vim-http
Plug 'wellle/targets.vim'       " https://github.com/wellle/targets.vim
Plug 'michaeljsmith/vim-indent-object'  " https://github.com/michaeljsmith/vim-indent-object
Plug 'tpope/vim-fugitive', { 'tag': 'v2.3' }      " https://github.com/tpope/vim-fugitive, downgraded to 2.3 for compatibility with airline until there's a fix

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'} " https://github.com/neoclide/coc.nvim

" Racket
Plug 'tpope/vim-surround'       " https://github.com/tpope/vim-surround
Plug 'jpalardy/vim-slime'       " vim-slime
Plug 'wlangstroth/vim-racket'   " vim-racket
call plug#end()                 " Initialize plugin system

""" Visual
" Colors/theme
set termguicolors               " For solarized theme https://github.com/icymind/NeoSolarized
syntax enable                   " Enable syntax. https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript
set background=dark             " Set for dark colorschemes
let g:neosolarized_contrast = "high"    " set high contrast (default = normal)
colorscheme NeoSolarized        " https://github.com/icymind/NeoSolarized
let g:airline_theme='solarized' " https://github.com/vim-airline/vim-airline-themes/blob/master/autoload/airline/themes/solarized.vim
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1    " List buffers in tabline when no other tabs are open

"Layout
set number relativenumber	" Show line numbers
set showmatch			" Show matching brackets
set cc=80			" 80 character column border
set cursorline                  " Draw horizontal line on cursor
set lazyredraw                  " Lazy redraw; for better performance

""" Productivity
set visualbell                  " errors flash screen instead of bell
set clipboard=unnamedplus       " use system clipboard
set ignorecase			" Case-insensitive matching
set hlsearch			" Highlight search results
set scrolloff=2                 " Scroll window down
set shell=bash                  " Fix the shell to bash
filetype plugin indent on       " Filetype behavior - should be on by default but (shrug emoji)

""" Encoding
set expandtab                   " spaces instead of tabs
set encoding=utf-8
set fenc=utf-8
set wildmode=longest,list	" Bash-like tab complete
"set tabstop=4
set shiftwidth=4
set softtabstop=4

""" coc.nvim
" tab/shift-tab to navigate autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" format on enter (TODO not working?)
" inoremap <silent><expr> <c-space> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" recommended by readme
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" navigate diagnostics
nmap <silent> <c-j> <Plug>(coc-diagnostic-next)
nmap <silent> <c-k> <Plug>(coc-diagnostic-prev)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Linting message highlight colors
hi! CocWarningSign guifg=#b58900
hi! CocErrorSign guifg=#cb4b16

"""" vim-slime (remember to prefix target pane with window #)
let g:slime_target = "tmux"     " target tmux for REPL with vim-slime
let g:slime_python_ipython = 1  " ipython cpaste fix

""" misc
" config editing
nnoremap <leader>sv :source $MYVIMRC<CR>
