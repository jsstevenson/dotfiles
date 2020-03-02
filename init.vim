"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
" https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')

" Theme & layout
Plug 'iCyMind/NeoSolarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" IDE-y things
Plug 'nicwest/vim-http'         " Make HTTP requests from within nvim
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
" Plug 'tpope/vim-fugitive', { 'tag': 'v2.3' }      " downgraded to 2.3 for compatibility with airline until there's a fix. Currently disabled bc interacting weird w/ neovim
Plug 'tpope/vim-obsession'      " for saving nvim sessions with tmux-resurrect
Plug 'mechatroner/rainbow_csv'  " easier csv highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'godlygeek/tabular'        " for lining up tables and whatnot. try https://github.com/junegunn/vim-easy-align as well?
"Plug 'tpope/vim-commentary'     " easier commenting
Plug 'tpope/vim-endwise'        " auto end hanging syntax
Plug 'tpope/vim-surround'
Plug 'jpalardy/vim-slime'

" Language-specific
Plug 'wlangstroth/vim-racket'
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex'
Plug 'motus/pig.vim'            " for CSE6200
Plug 'jparise/hive.vim'         " for CSE6200

" Misc
call plug#end()                 " Initialize plugin system

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Layout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Colors/theme
set termguicolors                               " For solarized theme
syntax enable                                   " Enable syntax. https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript
let g:neosolarized_contrast = "high"            " set high contrast (default = normal)
colorscheme NeoSolarized
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1               " Enable font for Powerline 
let g:airline#extensions#tabline#enabled = 1    " List buffers in tabline when no other tabs are open

" Layout
set number relativenumber	                " Show line numbers
set showmatch			                " Show matching brackets
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
set cc=80			                " 80 character column border
set cursorline                                  " Draw horizontal line on cursor
set lazyredraw                                  " Lazy redraw; for better performance

" Swap light/dark mode based on shell environment variable
if $DARKMODE == 1
    set background=dark
elseif $DARKMODE == 0
    set background=light
else
    echo "Alert - color swap broken?"
    set background=dark
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Productivity
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set visualbell                                  " errors flash screen instead of bell
set clipboard=unnamedplus                       " use system clipboard
set ignorecase			                " Case-insensitive matching
set hlsearch			                " Highlight search results
set scrolloff=2                                 " Scroll window down
set shell=/bin/zsh                              " Fix the shell to zsh
filetype plugin indent on                       " Filetype behavior - should be on by default but (shrug emoji)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab                                   " spaces instead of tabs
set encoding=utf-8
set fenc=utf-8
set wildmode=longest,list	                " Bash-like tab complete
set shiftwidth=4
set softtabstop=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Brace completion/indenting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap {<CR> {<CR>}<Esc><Up>o
inoremap {;<CR> {<CR>};<Esc><Up>o
inoremap {,<CR> {<CR>},<Esc><Up>o
inoremap (<CR> (<CR>)<Esc><Up>o
inoremap (;<CR> (<CR>);<Esc><Up>o
inoremap (,<CR> (<CR>),<Esc><Up>o
inoremap [<CR> [<CR>]<Esc><Up>o
inoremap [;<CR> [<CR>];<Esc><Up>o
inoremap [,<CR> [<CR>],<Esc><Up>o

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim things
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab/shift-tab to navigate autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

" comment highlighting on coc config https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file
autocmd FileType json syntax match Comment +\/\/.\+$+

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-slime
" remember to prefix target pane with window number, eg 0.1 for window 0, pane 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:slime_target = "tmux"                 " target tmux for REPL with vim-slime
let g:slime_python_ipython = 1              " ipython cpaste fix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType markdown setlocal tw=80    " set specific wrapping for better readability/note-taking

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType tex nmap <leader>b :CocCommand latex.Build<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" commands

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>sv :source $MYVIMRC<CR>




