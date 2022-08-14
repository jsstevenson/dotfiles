local mapx = require("mapx")

mapx.nnoremap("<leader>s", "<Plug>(tmux_source_file)", { silent = true })
mapx.nnoremap("K", "<Plug>(tmux_show_man_floatwin)", { silent = true })
mapx.nnoremap("g!", "<Plug>(tmux_execute_selection)", { silent = true })
