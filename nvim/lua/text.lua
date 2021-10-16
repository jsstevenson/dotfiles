local api, cmd, g = vim.api, vim.cmd, vim.g
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('b', 'expandtab', true)
opt('b', 'fileencoding', 'utf-8')
opt('o', 'wildmode', 'longest,list')
opt('b', 'shiftwidth', 4)
opt('b', 'softtabstop', 4)

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
    highlight = {enable = true, disable = { "tex", "html" } },
    indent = { enable = true, disable = { "rust", "lua", "python" } }
}

-- easy edit config files
map('', '<leader>ev', ':edit $MYVIMRC<CR>', {silent = true})
map('', '<leader>sv', ':luafile $MYVIMRC<CR>', {silent = true})

-- buffer movement
map('n', '<leader>d', ':bp<CR>', {silent = true})
map('n', '<leader>f', ':bn<CR>', {silent = true})
