""" vim-plug https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Theme & layout
Plug 'iCyMind/NeoSolarized'     " https://github.com/icymind/NeoSolarized
Plug 'vim-airline/vim-airline'  " https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline-themes'   " https://github.com/vim-airline/vim-airline-themes
"Plug 'tpope/vim-obsession'      " Save sessions//not currently using

" IDE-y things
"Plug 'dense-analysis/ale'       "https://github.com/w0rp/ale
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

" Layout
set termguicolors               " For solarized theme https://github.com/icymind/NeoSolarized
syntax enable                   " Enable syntax. https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript
set number relativenumber	" Show line numbers
set showmatch			" Show matching brackets
set cc=80			" 80 character column border
set cursorline                  " Draw horizontal line on cursor
set lazyredraw                  " Lazy redraw; for better performance
set background=dark             " Set for dark colorschemes
let g:neosolarized_contrast = "high"    " set high contrast (default = normal)
colorscheme NeoSolarized        " https://github.com/icymind/NeoSolarized
let g:airline_theme='solarized' " https://github.com/vim-airline/vim-airline-themes/blob/master/autoload/airline/themes/solarized.vim
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1    " List buffers in tabline when no other tabs are open

" Productivity
set visualbell                  " errors flash screen instead of bell
set clipboard=unnamedplus       " use system clipboard
set ignorecase			" Case-insensitive matching
set hlsearch			" Highlight search results
set scrolloff=2                 " Scroll window down
set shell=bash                  " Fix the shell to bash
filetype plugin indent on       " Filetype behavior - should be on by default but (shrug emoji)

" Encoding
set expandtab                   " spaces instead of tabs
set encoding=utf-8
set fenc=utf-8
set wildmode=longest,list	" Bash-like tab complete
"set tabstop=4
set shiftwidth=4
set softtabstop=4

" ALE
" let g:ale_linters = {
"                         \ 'python': ['flake8'],
"                         \ 'javascript': ['eslint'],
"                         \}
" let g:airline#extensions#ale#enabled = 1        " Enable ALE in Airline
" " https://github.com/w0rp/ale#5ix-how-can-i-navigate-between-errors-quickly
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" vim-slime (remember to prefix target pane with window #)
let g:slime_target = "tmux"     " target tmux for REPL with vim-slime
let g:slime_python_ipython = 1  " ipython cpaste fix

" netrw things
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 22

" config editing
nnoremap <leader>sv :source $MYVIMRC<CR>
