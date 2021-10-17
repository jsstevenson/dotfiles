local cmd = vim.cmd
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'termguicolors', true)
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('o', 'showmatch', true)
opt('w', 'cc', '80,100')
opt('w', 'cursorline', true)
opt('o', 'syntax', 'disable') -- theoretically treesitter covers this better
opt('o', 'showmode', false)  -- ????
cmd('set signcolumn=yes:1') -- for lsp issues?

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
