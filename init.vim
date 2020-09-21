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
Plug 'mechatroner/rainbow_csv'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Text object & formatting
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
" for lining up tables and whatnot. try https://github.com/junegunn/vim-easy-align as well?
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Other tools
Plug 'nicwest/vim-http'
Plug 'tpope/vim-obsession'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jpalardy/vim-slime'
" until I feel better about vim-fugitive
Plug 'itchyny/vim-gitbranch'

" Language-specific
Plug 'vim-python/python-syntax'
Plug 'wlangstroth/vim-racket'
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set number relativenumber
set showmatch
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
set cc=80
set cursorline
" Enable syntax. https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript
syntax enable
set noshowmode

" set background colorscheme and update for light or dark mode
" does *not* update lightline colors
function! SetBackground()
    if $TMUX != ""
        let darkmode_setting = system("tmux show-environment | grep \"^DARKMODE\"")
        let darkmode_val = strcharpart(darkmode_setting, 9, 9)
        if darkmode_val == 1
            set background=dark
        elseif darkmode_val == 0
            set background=light
        else
            echom "Error - couldn't get darkmode val from tmux"
        endif
    else
        " if running from straight shell (no tmux)
        if $DARKMODE == 1
            set background=dark
        elseif $DARKMODE == 0
            set background=light
        else
            echom "Error: couldn't get darkmode val from shell"
            set background=dark
        endif
    endif
endfunction

" get current CoC fuction for Lightline
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
    \ 'active': {
    \   'left': [   [ 'mode', 'paste' ],
    \               [ 'gitbranch' ],
    \               [ 'cocstatus', 'currentfunction', 'readonly', 'modified' ] ],
    \   'right': []
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
" force show tabline for buffers
set showtabline=2

function! SetTheme()
    if ($TERM_PROGRAM == "iTerm.app") || ($TERM_PROGRAM == "alacritty")
        set termguicolors                               " For solarized theme
        call SetBackground()
        colorscheme NeoSolarized
        let g:neosolarized_contrast = "high"            " set high contrast (default = normal)
        let g:lightline.colorscheme = "solarized"
        " Update lightline color when bg color changes:
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
endfunction
call SetTheme()

" hexokinase
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'
let g:Hexokinase_ftOptInPatterns = {
            \   'css': 'full_hex,rgb,rgba,hsl,hsla,colour_names',
            \   'html': 'full_hex,rgb,rgba,hsl,hsla,colour_names',
            \   'javascript': 'full_hex,rgb,rgba,hsl,hsla'
            \ }
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'vim']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Productivity
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set visualbell
" use system clipboard
set clipboard=unnamedplus
" Case-insensitive matching
set ignorecase
set hlsearch
set scrolloff=2
set shell=/bin/zsh
" Filetype behavior - should be on by default but (shrug emoji)
filetype plugin indent on
" live substitute
set inccommand=nosplit

" https://vim.fandom.com/wiki/Map_semicolon_to_colon
map ; :
noremap ;; ;

" map esc to clear
map <esc> :noh<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" spaces instead of tabs
set expandtab
set encoding=utf-8
set fenc=utf-8
" bash-like tab complete
set wildmode=longest,list
set shiftwidth=4
set softtabstop=4
augroup clean_trailing_spaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-slime
" remember to prefix target pane with window number, eg 0.1 for window 0, pane 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:slime_target = "tmux"
" ipython copypaste fix
let g:slime_python_ipython = 1


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
let g:tex_flavor = 'latex'
augroup tex_compile
    autocmd!
    autocmd FileType tex nnoremap <leader>b :CocCommand latex.Build<CR>
    au FileType tex let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '"""':'"""'}
    let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
augroup END

" rust
" let g:rustfmt_autosave = 1
" change behavior based on whether tmux pane is zoomed?
" tmux list-panes -F '#F' | grep -q Z
" ^^ something to that effect --> autocmd to run in floaterm???
" not sure how to update on zoom in/out though
augroup rust_tools
    autocmd!
    autocmd FileType rust nnoremap <leader>r :FloatermToggle<CR>cargo run<CR>
    autocmd FileType rust nnoremap <leader>b :FloatermToggle<CR>cargo build<CR>
    autocmd FileType rust nnoremap <leader>c :FloatermToggle<CR>cargo check<CR>
    autocmd FileType rust nnoremap <leader>t :FloatermToggle<CR>cargo test<CR>
    autocmd Filetype rust nnoremap <leader>z :RustFmt<CR>
augroup END

" html
let g:html_indent_inctags = "html,body,head,tbody,div"
let g:html_indent_script1 = "inc"

" js
augroup js
    autocmd!
    autocmd Filetype js,json nnoremap <leader>p :CocCommand prettier.formatFile<CR>
augroup END
