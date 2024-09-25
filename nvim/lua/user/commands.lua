local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

-- reload config
-- vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

-- delete trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", { command = "%s/\\s\\+$//e", group = group })

-- convert tabs to spaces for certain filetypes (opt in)
