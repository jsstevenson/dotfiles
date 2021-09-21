--------------------------------------------------------------------------------
-- TODO
--------------------------------------------------------------------------------
-- light theme
-- hot reload colors
--   breaks statusline?
-- filetype autocmds
-- nvim-lsp
--   individual LSPs: python, js/prettier, tex, lua, rust, ruby
--   formatting for js/json!!!
--   key mapping updates
--   use treesitter for indent in python?
--   set root_dir = lspconfig.util.root_pattern('.git') as global default for lsps
--------------------------------------------------------------------------------
-- utilities
--------------------------------------------------------------------------------
-- https://oroques.dev/notes/neovim-init
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
local paq = require("paq")

paq {
    "savq/paq-nvim";
    -- appearance
    {'jsstevenson/tokyonight.nvim', branch='new-colors'};
    'hoob3rt/lualine.nvim';
    'akinsho/nvim-bufferline.lua';
    'voldikss/vim-floaterm';
    'mechatroner/rainbow_csv';
    {
        'rrethy/vim-hexokinase',
        run = 'cd ~/.local/share/nvim/site/pack/paqs/start/vim-hexokinase && make hexokinase'
    };

    -- text objects & formatting
    'wellle/targets.vim';
    'michaeljsmith/vim-indent-object';
    'Vimjas/vim-python-pep8-indent';
    -- try https://github.com/junegunn/vim-easy-align as well?
    'godlygeek/tabular';
    'tpope/vim-commentary';
    'tpope/vim-endwise';
    'tpope/vim-surround';
    'jiangmiao/auto-pairs';
    'jpalardy/vim-slime';
    'nvim-treesitter/nvim-treesitter';
    'mhartington/formatter.nvim';

    -- LSP things
    'neovim/nvim-lspconfig';
    'nvim-lua/completion-nvim';

    -- misc
    'itchyny/vim-gitbranch'; -- until I feel better about vim-fugitive

    -- language-specific
    'nicwest/vim-http';
    'wlangstroth/vim-racket';
    'rust-lang/rust.vim';
    'lervag/vimtex';
}

--------------------------------------------------------------------------------
-- appearance
--------------------------------------------------------------------------------
opt('o', 'termguicolors', true)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('o', 'showmatch', true)
opt('w', 'cc', '80,100')
opt('w', 'cursorline', true)
opt('o', 'syntax', 'disable') -- theoretically treesitter covers this better
opt('o', 'showmode', false)  -- ????
cmd([[ let g:Hexokinase_optOutPatterns = [ 'colour_names' ] ]]) -- ?? why won't this work in lua
cmd('set signcolumn=yes:1')

g.tokyonight_style = 'storm'
g.tokyonight_dark_float = false
g.tokyonight_colors = {}
cmd 'colorscheme tokyonight'

local function environment_name()
    local ps1 = os.getenv('PS1')
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
-- text
--------------------------------------------------------------------------------
opt('b', 'expandtab', true)
opt('b', 'fileencoding', 'utf-8')
opt('o', 'wildmode', 'longest,list')
opt('b', 'shiftwidth', 4)
opt('b', 'softtabstop', 4)

-- delete trailing whitespace on save
cmd([[
augroup clean_trailing_spaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
]])

-- vim-slime
g.slime_target = "tmux"
g.slime_python_ipython = 1

-- treesitter
local ts = require 'nvim-treesitter.configs'
ts.setup {
    ensure_installed = {
        'bash', 'bibtex', 'c', 'cpp', 'graphql',  'html', 'java', 'javascript',
        'jsdoc', 'json', 'jsonc', 'julia', 'lua', 'python', 'ruby', 'rust',
        'sparql', 'toml', 'tsx', 'typescript', 'yaml'
    },
    highlight = {enable = true, disable = { "tex" } },
    indent = { enable = true, disable = { "rust", "lua", "python" } }
}

--------------------------------------------------------------------------------
-- productivity
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
-- terminal
--------------------------------------------------------------------------------

map('t', '<Esc>', '<C-\\><C-n>')
map('', '<C-S>', ':FloatermToggle<cr>')
map('n', '<C-H>', ':w<cr>:FloatermNew fzf<cr>')
map('t', '<C-S>', '<C-\\><C-n>:FloatermToggle<cr>')

g.floaterm_width = 0.8
g.floaterm_height = 0.85
g.floaterm_autoclose = 1

--------------------------------------------------------------------------------
-- misc
--------------------------------------------------------------------------------
-- easy edit config files
map('', '<leader>ev', ':edit $MYVIMRC<CR>', {silent = true})
map('', '<leader>sv', ':luafile $MYVIMRC<CR>', {silent = true})

-- buffer movement
map('n', '<leader>d', ':bp<CR>', {silent = true})
map('n', '<leader>f', ':bn<CR>', {silent = true})

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------
cmd('set completeopt=menuone,noinsert,noselect')
cmd('set shortmess+=c')

local nvim_lsp = require'lspconfig'

-- hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "single" }
)

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = true,
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = "single" }
)

-- tab completion
map('i', '<Tab>', '<Plug>(completion_smart_tab)', {noremap = false, silent = true})
map('i', '<S-Tab>', '<Plug>(completion_smart_s_tab)', {noremap = false, silent = true})
map('i', '<Tab>', 'pumvisible() ? \"\\<C-n>" : \"\\<Tab>"', {expr = true})
map('i', '<S-Tab>', 'pumvisible() ? \"\\<C-p>" : \"\\<S-Tab>"', {expr = true})

-- other shortcuts
-- map('n', 'K', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent = true})  -- wtf isn't this working
cmd('nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {silent = true})
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {silent = true})
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {silent = true})
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent = true})
map('n', '<c-j>', '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', {silent = true})
map('n', '<c-k>', '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', {silent = true})

--------------------------------------------------------------------------------
-- Python
--------------------------------------------------------------------------------

nvim_lsp.pyright.setup{
    on_attach=require'completion'.on_attach
}

--------------------------------------------------------------------------------
-- TeX
--------------------------------------------------------------------------------
-- TODO:
-- compile shortcut
-- au FileType tex let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '"""':'"""'}
-- let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
-- aucmd to re-enable syntax highlighting

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
-- rust
--------------------------------------------------------------------------------

g.rustfmt_autosave = 0
g.syntastic_rust_checkers = {}

-- LSP https://sharksforarms.dev/posts/neovim-rust/
nvim_lsp.rust_analyzer.setup({
    on_attach=require'completion'.on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = 'last',
                importPrefix = 'by_self',
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

--------------------------------------------------------------------------------
-- lua
--------------------------------------------------------------------------------

require'lua-ls'

--------------------------------------------------------------------------------
-- HTML
--------------------------------------------------------------------------------

g.html_indent_inctags = 'html,body,head,tbody,div'
g.html_indent_script1 = 'inc'
require'lspconfig'.html.setup{}

--------------------------------------------------------------------------------
-- JSON
--------------------------------------------------------------------------------

require'lspconfig'.jsonls.setup{}

function format_prettier()
   return {
     exe = "npx",
     args = {"prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0)},
     stdin = true
   }
end

--------------------------------------------------------------------------------
-- formatter
--------------------------------------------------------------------------------

require('formatter').setup {
  logging = true,
  filetype = {
    json = { format_prettier },
  }
}

map('n', '<leader>p', ':Format<cr>:w<cr>')
