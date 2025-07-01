vim.g.mapleader = " "

-- https://vim.fandom.com/wiki/Map_semicolon_to_colon
vim.keymap.set("", ";", ":")
vim.keymap.set("", ";;", ":") -- TODO fix?

-- map esc to clear
vim.keymap.set("", "<esc>", ":noh<cr>")

-- buffer movement
vim.keymap.set("", "<C-h>", ":bp<CR>", { silent = true })
vim.keymap.set("", "<C-l>", ":bn<CR>", { silent = true })

-- center on jump
vim.keymap.set("n", "<C-o>", "<C-o>zz", { silent = true })

-- diagnostics
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
