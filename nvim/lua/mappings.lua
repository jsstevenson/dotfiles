-- local mapx = require("mapx")

-- https://vim.fandom.com/wiki/Map_semicolon_to_colon
vim.keymap.set("", ";", ":")
vim.keymap.set("", ";;", ":")  -- TODO fix?

-- map esc to clear
vim.keymap.set("", "<esc>", ":noh<cr>")

-- easy edit config files
vim.keymap.set("", "<leader>ev", ":edit $MYVIMRC<CR>", { silent = true })
vim.keymap.set("", "<leader>sv", ":luafile $MYVIMRC<CR>", { silent = true })

-- buffer movement
vim.keymap.set("", "<C-h>", ":bp<CR>", { silent = true })
vim.keymap.set("", "<C-l>", ":bn<CR>", { silent = true })

-- comment.nvim
vim.keymap.set("v", "<C-_>", "gc", { silent = true })

-- telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "ff", function()
  telescope.find_files()
end, { silent = true })
vim.keymap.set("n", "fg", function()
  telescope.live_grep()
end, { silent = true })
vim.keymap.set("n", "gr", function()
  telescope.lsp_references()
end, { silent = true })
vim.keymap.set("n", "fh", function()
  telescope.help_tags()
end, { silent = true })

-- floaterm
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-S>", ":FloatermToggle<cr>")
vim.keymap.set("t", "<C-S>", "<C-\\><C-n>:FloatermToggle<cr>")

-- misc
vim.keymap.set("n", "<C-o>", "<C-o>zz", { silent = true })
