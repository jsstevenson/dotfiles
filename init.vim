"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
" https://github.com/junegunn/vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')

" Theme & layout
Plug 'iCyMind/NeoSolarized'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'crusoexia/vim-monokai'
Plug 'NLKNguyen/papercolor-theme'
Plug 'voldikss/vim-floaterm'
Plug 'mechatroner/rainbow_csv'                  " easier csv highlighting

" Text object & formatting
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'godlygeek/tabular'                        " for lining up tables and whatnot. try https://github.com/junegunn/vim-easy-align as well?
Plug 'tpope/vim-commentary'                     " easier commenting
Plug 'tpope/vim-endwise'                        " auto end hanging syntax
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Other tools
Plug 'nicwest/vim-http'                         " Make HTTP requests from within nvim
Plug 'tpope/vim-obsession'                      " for saving nvim sessions with tmux-resurrect
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jpalardy/vim-slime'
Plug 'itchyny/vim-gitbranch'                    " until I feel better about vim-fugitive

" Language-specific
Plug 'vim-python/python-syntax'
Plug 'wlangstroth/vim-racket'
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Layout
set number relativenumber	                " Show line numbers
set showmatch			                " Show matching brackets
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
set cc=80			                " 80 character column border
set cursorline                                  " Draw horizontal line on cursor
" set lazyredraw                                  " Lazy redraw; for better performance

" Colors
syntax enable                                   " Enable syntax. https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript
set noshowmode                                  " (since mode already shows in statusline)

" Set up correct background, colorscheme
function! SetBackground()                       " Set bg to light or dark depending on parent env values
    if $TMUX != ""                              " if in tmux
        let darkmode_setting = system("tmux show-environment | grep \"^DARKMODE\"")
        let darkmode_val = strcharpart(darkmode_setting, 9, 9)
        if darkmode_val == 1
            set background=dark
        elseif darkmode_val == 0
            set background=light
        else
            echom "Error - couldn't get darkmode val from tmux"
        endif
    else                                        " presumably running straight from shell
        if $DARKMODE == 1
            set background=dark
        elseif $DARKMODE == 0
            set background=light
        else
            echo "Alert - color swap broken?"
            set background=dark
        endif
    endif
endfunction

" Lightline
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
    \ 'active': {
    \   'left': [   [ 'mode', 'paste' ],
    \               [ 'gitbranch' ],
    \               [ 'cocstatus', 'currentfunction', 'readonly', 'modified' ] ],
    \   'right': [  [ 'lineinfo' ],
    \               [ 'fileformat', 'fileencoding', 'filetype' ]]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'currentfunction': 'CocCurrentFunction',
    \   'gitbranch': 'gitbranch#name'
    \ },
    \ 'tabline': {'left': [['buffers']]},
    \ 'component_expand': {'buffers': 'lightline#bufferline#buffers'},
    \ 'component_type': {'buffers': 'tabsel'}
    \ }
set showtabline=2                               " force show tabline for buffers

" terminal emulator-specific
if $TERM_PROGRAM == "iTerm.app"
    set termguicolors                               " For solarized theme
    call SetBackground()
    colorscheme NeoSolarized
    let g:neosolarized_contrast = "high"            " set high contrast (default = normal)
    let g:lightline.colorscheme = "solarized"
    " Update lightline color when bg color changes
    augroup setbg
        autocmd!
        autocmd OptionSet background
              \ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/solarized.vim')
              \ | call lightline#colorscheme() | call lightline#update()
    augroup END
elseif $TERM_PROGRAM == "Apple_Terminal"
    colorscheme PaperColor
    set background=light
    let g:lightline.colorscheme = "PaperColor"
    " Update lightline color when bg color changes
    augroup setbg
        autocmd!
        autocmd OptionSet background
              \ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/papercolor.vim')
              \ | call lightline#colorscheme() | call lightline#update()
    augroup END
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
set inccommand=nosplit                          " live substitute

" https://vim.fandom.com/wiki/Map_semicolon_to_colon
map ; :
noremap ;; ;

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab                                   " spaces instead of tabs
set encoding=utf-8
set fenc=utf-8
set wildmode=longest,list	                " Bash-like tab complete
set shiftwidth=4
set softtabstop=4
augroup clean_trailing_spaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e               " Remove trailing whitespace on save
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-slime
" remember to prefix target pane with window number, eg 0.1 for window 0, pane 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:slime_target = "tmux"                     " target tmux for REPL with vim-slime
let g:slime_python_ipython = 1                  " ipython cpaste fix


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" start terminal in insert
augroup floaterm_open
    autocmd TermOpen * startinsert
augroup END
tnoremap <Esc> <C-\><C-n>

" Floaterm
" some functionality relies on nvr [https://github.com/mhinz/neovim-remote]
let g:floaterm_width=0.8
let g:floaterm_height=0.85

nnoremap <C-S> :FloatermToggle<cr>
nnoremap <C-H> :FloatermNew fzf<cr>
tnoremap <C-S> <C-\><C-n>:FloatermToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" easy edit init.vim
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" trying out buffer movement shortcuts
nnoremap <leader>d :bp<CR>
nnoremap <leader>f :bn<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
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
augroup coc_config_cmt_hl
    autocmd!
    autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

" show doc in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" filetype blacklist. rewrite this as a function call to iterate thru the list
let blacklist = ['*.md']
augroup ft_backlist
    autocmd!
    autocmd BufNew,BufEnter blacklist execute "silent! CocDisable"
    autocmd BufLeave blacklist execute "silent! CocEnable"
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype-specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tex
augroup tex_compile
    autocmd!
    autocmd FileType tex nnoremap <leader>b :CocCommand latex.Build<CR>
    au FileType tex let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '"""':'"""'}
    let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
augroup END

" rust
" let g:rustfmt_autosave = 1
augroup rust_tools
    autocmd!
    autocmd FileType rust nnoremap <leader>r :FloatermToggle<CR>cargo run<CR>
    autocmd FileType rust nnoremap <leader>b :FloatermToggle<CR>cargo build<CR>
    autocmd FileType rust nnoremap <leader>c :FloatermToggle<CR>cargo check<CR>
    autocmd FileType rust nnoremap <leader>t :FloatermToggle<CR>cargo test<CR>
    autocmd Filetype rust nnoremap <leader>z :RustFmt<CR>
augroup END
