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
cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt = true}

-- appearance
paq {'jsstevenson/tokyonight.nvim', branch = 'new-colors'}
paq {'hoob3rt/lualine.nvim'}
paq {'akinsho/nvim-bufferline.lua'}
paq {'voldikss/vim-floaterm'}
paq {'mechatroner/rainbow_csv'}
paq {'rrethy/vim-hexokinase', run = 'make hexokinase'}
-- Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } -- ????

-- text objects & formatting
paq {'wellle/targets.vim'}
paq {'michaeljsmith/vim-indent-object'}
-- try https://github.com/junegunn/vim-easy-align as well?
paq {'godlygeek/tabular'}
paq {'tpope/vim-commentary'}
paq {'tpope/vim-endwise'}
paq {'tpope/vim-surround'}
paq {'jiangmiao/auto-pairs'}
paq {'jpalardy/vim-slime'}
paq {'nvim-treesitter/nvim-treesitter'}

-- LSP things
paq {'neovim/nvim-lspconfig'}
paq {'nvim-lua/completion-nvim'}
paq {'kabouzeid/nvim-lspinstall'}

-- misc
-- until I feel better about vim-fugitive
paq {'itchyny/vim-gitbranch'}

-- language-specific
paq {'nicwest/vim-http'}
paq {'wlangstroth/vim-racket'}
paq {'rust-lang/rust.vim'}
-- https://github.com/simrat39/rust-tools.nvim/
paq {'lervag/vimtex'}

--------------------------------------------------------------------------------
-- appearance
--------------------------------------------------------------------------------
opt('o', 'termguicolors', true)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('o', 'showmatch', true)
opt('w', 'cc', '80')
opt('w', 'cursorline', true)
opt('o', 'syntax', 'disable') -- theoretically treesitter covers this better
opt('o', 'showmode', false)  -- ????
cmd([[ let g:Hexokinase_optOutPatterns = [ 'colour_names' ] ]]) -- ?? why won't this work in lua

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
    highlight = {enable = true},
    indent = { enable = true, disable = { "rust", "lua" } }
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
map('t', '<C-S>', '<C-\\><C-n>:FloatermToggle<cr>') -- TODO not fully working???

-- " let g:floaterm_keymap_new = '<C-N>'
-- " let g:floaterm_keymap_prev = '<Leader>d'
-- " let g:floaterm_keymap_next = '<Leader>f'

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

-- completion
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "single" }
)

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- set defaults
local lspconfig = require'lspconfig'
lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
        handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false
            }
            )
        }
    }
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
map('n', '<c-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {silent = true})
map('n', '<c-k>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {silent = true})

-- nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
-- nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
-- nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>  -- treesitter maybe does this better?

-- lspinstall
local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

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
-- rust
--------------------------------------------------------------------------------

-- TODO: cargo run/build/check/test shortcuts

g.rustfmt_autosave = 0

-- LSP https://sharksforarms.dev/posts/neovim-rust/
nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
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
-- HTML
--------------------------------------------------------------------------------
g.html_indent_inctags = "html,body,head,tbody,div"
g.html_indent_script1 = "inc"

--------------------------------------------------------------------------------
-- lua
--------------------------------------------------------------------------------
require('lua-ls')
