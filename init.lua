--------------------------------------------------------------------------------
-- TODO
--------------------------------------------------------------------------------
-- delete whitespace on save
-- light theme
-- hot reload colors
--   breaks statusline?
-- filetype autocmds
-- nvim-lsp
-- treesitter
--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local fmt = string.format

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

--------------------------------------------------------------------------------
-- paq-nvim
--------------------------------------------------------------------------------
cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt = true}

paq {'folke/tokyonight.nvim'}
paq {'hoob3rt/lualine.nvim'}
paq {'akinsho/nvim-bufferline.lua'}
paq {'voldikss/vim-floaterm'}
paq {'mechatroner/rainbow_csv'}
-- Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } -- ????

-- text objects & formatting
paq {'wellle/targets.vim'}
paq {'michaeljsmith/vim-indent-object'}
-- for lining up tables and whatnot. try https://github.com/junegunn/vim-easy-align as well?
paq {'godlygeek/tabular'}
paq {'tpope/vim-commentary'}
paq {'tpope/vim-endwise'}
paq {'tpope/vim-surround'}
paq {'jiangmiao/auto-pairs'}

-- misc
paq {'nicwest/vim-http'}
paq {'tpope/vim-obsession'}
paq {'jpalardy/vim-slime'}
-- until I feel better about vim-fugitive
paq {'itchyny/vim-gitbranch'}

-- language-specific
paq {'vim-python/python-syntax'}
paq {'wlangstroth/vim-racket'}
paq {'rust-lang/rust.vim'}
paq {'lervag/vimtex'}


--------------------------------------------------------------------------------
-- APPEARANCE
--------------------------------------------------------------------------------
opt('o', 'termguicolors', true)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('o', 'showmatch', true)
opt('w', 'cc', '80')
opt('w', 'cursorline', true)
opt('o', 'syntax', 'enable')  -- ????
opt('o', 'showmode', false)  -- ????
-- cmd 'hi MatchParen cterm=bold ctermbg=none ctermfg=magenta' -- ???

cmd 'colorscheme tokyonight'
g.tokyonight_style = 'storm'

local function environment_name() 
    ps1 = os.getenv('PS1')
    if ps1 then
        return string.match(ps1, "%((.+)%) ")
    else
        return nil
    end
end

require('lualine').setup{
    options = {
        theme = 'tokyonight'
    },
    sections = {
        lualine_c = {environment_name},
        lualine_x = {'encoding'},
        lualine_y = {'filetype'},
        lualine_z = {'filename'}
    }
}


require('bufferline').setup{}

--------------------------------------------------------------------------------
-- TEXT
--------------------------------------------------------------------------------
opt('b', 'expandtab', true)
opt('b', 'fileencoding', 'utf-8')
opt('o', 'wildmode', 'longest,list')
opt('b', 'shiftwidth', 4)
opt('b', 'softtabstop', 4)


-- TODO clean_trailing spaces

--------------------------------------------------------------------------------
-- PRODUCTIVITY
--------------------------------------------------------------------------------
opt('o', 'visualbell', true)
opt('o', 'clipboard', 'unnamedplus')
opt('o', 'ignorecase', true)
opt('o', 'hlsearch', true)
opt('o', 'scrolloff', 2)
opt('o', 'inccommand', 'nosplit')

-- https://vim.fandom.com/wiki/Map_semicolon_to_colon
map('', ';', ':')
map('', ';;', ';') -- TODO fix

-- map esc to clear
map('', '<esc>', ':noh<cr>')

--------------------------------------------------------------------------------
-- MISC
--------------------------------------------------------------------------------

map('t', '<Esc>', '<C-\\><C-n>')
map('', '<C-S>', ':FloatermToggle<cr>')
map('n', '<C-H>', ':w<cr>:FloatermNew fzf<cr>')
map('t', '<C-S>', '<C-\\><C-n>:FloatermToggle<cr>') -- TODO not fully working???

-- " let g:floaterm_keymap_toggle = '<C-S>'
-- " let g:floaterm_keymap_new = '<C-N>'
-- " let g:floaterm_keymap_prev = '<Leader>d'
-- " let g:floaterm_keymap_next = '<Leader>f'
-- 
-- cmd('hi FloatermBorder guibg=red guifg=brwhite')

g.floaterm_width = 0.8
g.floaterm_height = 0.85
g.floaterm_autoclose = 1

--------------------------------------------------------------------------------
-- MISC
--------------------------------------------------------------------------------
-- easy edit config files
map('', '<leader>ev', ':edit $MYVIMRC<CR>')
map('', '<leader>sv', ':luafile $MYVIMRC<CR>')

-- buffer movement
map('n', '<leader>d', ':bp<CR>')
map('n', '<leader>f', ':bn<CR>')

--------------------------------------------------------------------------------
-- PYTHON
--------------------------------------------------------------------------------
g.python_highlight_all = 1

--------------------------------------------------------------------------------
-- TeX
--------------------------------------------------------------------------------
-- TODO:
-- compile shortcut
-- au FileType tex let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '"""':'"""'}
-- let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

--------------------------------------------------------------------------------
-- JS
--------------------------------------------------------------------------------
-- augroup js
--     autocmd!
--     autocmd Filetype js,json nnoremap <leader>p :CocCommand prettier.formatFile<CR>
-- augroup END

--------------------------------------------------------------------------------
-- C/C++
--------------------------------------------------------------------------------
-- augroup c_and_cpp
--     autocmd!
--     autocmd Filetype c,cpp set tabstop=2
--     autocmd Filetype c,cpp set softtabstop=2
--     autocmd Filetype c,cpp set shiftwidth=2
-- augroup END

--------------------------------------------------------------------------------
-- RUST
--------------------------------------------------------------------------------
-- cargo run/build/check/test shortcuts

--------------------------------------------------------------------------------
-- HTML
--------------------------------------------------------------------------------
g.html_indent_inctags = "html,body,head,tbody,div"
g.html_indent_script1 = "inc"
