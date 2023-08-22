-- delete trailing whitespace on save
local group = vim.api.nvim_create_augroup("EraseWhitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", { command = "%s/\\s\\+$//e", group = group })
