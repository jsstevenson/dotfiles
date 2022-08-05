local cmd = vim.cmd
local api, g = vim.api, vim.g

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- terminal
map('t', '<Esc>', '<C-\\><C-n>')
map('', '<C-S>', ':FloatermToggle<cr>')
map('n', '<C-H>', ':w<cr>:FloatermNew fzf<cr>')
map('t', '<C-S>', '<C-\\><C-n>:FloatermToggle<cr>')

g.floaterm_width = 0.8
g.floaterm_height = 0.85
g.floaterm_autoclose = 1

-- delete trailing whitespace on save
cmd([[
augroup clean_trailing_spaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
]])
