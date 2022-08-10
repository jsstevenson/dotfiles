-- terminal
local mapx = require("mapx")
mapx.tnoremap("<Esc>", "<C-\\><C-n>")
mapx.noremap("<C-S>", ":FloatermToggle<cr>")
mapx.tnoremap("<C-S>", "<C-\\><C-n>:FloatermToggle<cr>")

vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.85
vim.g.floaterm_autoclose = 1

-- delete trailing whitespace on save
local group = vim.api.nvim_create_augroup("EraseWhitespace", {clear = true})
vim.api.nvim_create_autocmd("BufWritePre", { command = "%s/\\s\\+$//e", group = group})
