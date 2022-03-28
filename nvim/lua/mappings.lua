local mapx = require('mapx').setup{}

-- https://vim.fandom.com/wiki/Map_semicolon_to_colon
mapx.noremap(';', ':')
mapx.noremap(';;', ';') -- TODO fix

-- map esc to clear
mapx.noremap('<esc>', ':noh<cr>')

-- easy edit config files
mapx.noremap('<leader>ev', ':edit $MYVIMRC<CR>', 'silent')
mapx.noremap('<leader>sv', ':luafile $MYVIMRC<CR>', 'silent')

-- buffer movement
mapx.nnoremap('<leader>d', ':bp<CR>', 'silent')
mapx.nnoremap('<leader>f', ':bn<CR>', 'silent')

-- comment
mapx.vnoremap('<C-_>', 'gc', 'silent')

-- telescope
mapx.nnoremap('ff', ':Telescope find_files<CR>', 'silent')
mapx.nnoremap('fg', ':Telescope live_grep<CR>', 'silent')

-- misc
mapx.nnoremap('<C-o>', '<C-o>zz', 'silent')
