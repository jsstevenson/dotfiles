vim.keymap.set("n", "<leader>s", "<Plug>(tmux_source_file)", { silent = true, noremap = true })
vim.keymap.set("n", "K", "<Plug>(tmux_show_man_floatwin)", { silent = true, noremap = true })
vim.keymap.set("n", "g!!", "<Plug>(tmux_execute_cursorline)", { silent = true, noremap = true })
vim.keymap.set("n", "g!", "<Plug>(tmux_execute_selection)", { silent = true, noremap = true })

