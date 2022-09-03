local mapx = require("mapx")

-- https://vim.fandom.com/wiki/Map_semicolon_to_colon
mapx.noremap(";", ":")
mapx.noremap(";;", ";") -- TODO fix

-- map esc to clear
mapx.noremap("<esc>", ":noh<cr>")

-- easy edit config files
mapx.noremap("<leader>ev", ":edit $MYVIMRC<CR>", "silent")
mapx.noremap("<leader>sv", ":luafile $MYVIMRC<CR>", "silent")

-- buffer movement
mapx.nnoremap("<C-h>", ":bp<CR>", "silent")
mapx.nnoremap("<C-l>", ":bn<CR>", "silent")

-- comment
mapx.vnoremap("<C-_>", "gc", "silent")

-- telescope
local telescope = require("telescope.builtin")
mapx.nnoremap("ff", function()
  telescope.find_files()
end, "silent")
mapx.nnoremap("fg", function()
  telescope.live_grep()
end, "silent")
mapx.nnoremap("gr", function()
  telescope.lsp_references()
end, "silent")
mapx.nnoremap("fh", function()
  telescope.help_tags()
end, "silent")

-- terminal
mapx.tnoremap("<Esc>", "<C-\\><C-n>")
mapx.noremap("<C-S>", ":FloatermToggle<cr>")
mapx.tnoremap("<C-S>", "<C-\\><C-n>:FloatermToggle<cr>")

-- misc
mapx.nnoremap("<C-o>", "<C-o>zz", "silent")
