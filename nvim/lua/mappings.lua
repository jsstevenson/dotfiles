local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- https://vim.fandom.com/wiki/Map_semicolon_to_colon
map('', ';', ':')
map('', ';;', ';') -- TODO fix

-- map esc to clear
map('', '<esc>', ':noh<cr>')

-- easy edit config files
map('', '<leader>ev', ':edit $MYVIMRC<CR>', {silent = true})
map('', '<leader>sv', ':luafile $MYVIMRC<CR>', {silent = true})

-- buffer movement
map('n', '<leader>d', ':bp<CR>', {silent = true})
map('n', '<leader>f', ':bn<CR>', {silent = true})

-- misc
map('n', '<C-o>', '<C-o>zz', {silent = true})
