local mapx = require('mapx')

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
local telescope = require('telescope.builtin')
mapx.nnoremap('ff', function() telescope.find_files() end, 'silent')
mapx.nnoremap('fg', function() telescope.live_grep() end, 'silent')

-- misc
mapx.nnoremap('<C-o>', '<C-o>zz', 'silent')
