""" vim-plug https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Theme & layout
Plug 'iCyMind/NeoSolarized'     " https://github.com/icymind/NeoSolarized
Plug 'vim-airline/vim-airline'  " https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline-themes'   " https://github.com/vim-airline/vim-airline-themes
"Plug 'tpope/vim-obsession'      " Save sessions//not currently using

" IDE-y things
Plug 'w0rp/ale'                 " https://github.com/w0rp/ale

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
set background=dark             " Set for dark colorschemes
colorscheme NeoSolarized        " https://github.com/icymind/NeoSolarized
let g:airline_theme='solarized' " https://github.com/vim-airline/vim-airline-themes/blob/master/autoload/airline/themes/solarized.vim
let g:airline_powerline_fonts = 1

" Productivity
set visualbell                  " errors flash screen instead of bell
set clipboard=unnamedplus       " use system clipboard
set ignorecase			" Case-insensitive matching
set hlsearch			" Highlight search results
set scrolloff=2                 " Scroll window down
set shell=bash                  " Fix the shell to bash
filetype plugin indent on       " Filetype behavior - should be on by default but (shrug emoji)
syntax on                       "

" Encoding
set expandtab                   " spaces instead of tabs
set encoding=utf-8
set fenc=utf-8
set wildmode=longest,list	" Bash-like tab complete
"set tabstop=4
set shiftwidth=4
set softtabstop=4

" ALE
let g:ale_linters = {
                        \ 'python': ['flake8'],
                        \}
let g:airline#extensions#ale#enabled = 1        " Enable ALE in Airline

" vim-slime (remember to prefix target pane with window #)
let g:slime_target = "tmux"     " target tmux for REPL with vim-slime
let g:slime_python_ipython = 1  " ipython cpaste fix

" netrw things
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 22

" CSE374 c editing
" autocmd Filetype make setlocal expandtab shiftwidth=4 softtabstop=4
