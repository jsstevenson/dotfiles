--------------------------------------------------------------------------------
-- TODO
--------------------------------------------------------------------------------
-- light theme
-- hot reload colors
--   breaks statusline?
-- filetype autocmds
-- nvim-lsp
--   individual LSPs: js, tex, ruby
--   key mapping updates
--   set root_dir = lspconfig.util.root_pattern('.git') as global default for lsps
--------------------------------------------------------------------------------
-- utilities
--------------------------------------------------------------------------------
-- https://oroques.dev/notes/neovim-init
require('packer_plugins')
require('options')
require('mappings')
require('theme')
require('utils')
require('treesitter')

--------------------------------------------------------------------------------
-- TeX
--------------------------------------------------------------------------------
-- TODO:
-- compile shortcut
-- au FileType tex let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '"""':'"""'}
-- let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
-- aucmd to re-enable syntax highlighting

-- -- formatter
-- function format_prettier()
--    return {
--      exe = "npx",
--      args = {"prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0)},
--      stdin = true
--    }
-- end
--
--
-- require('formatter').setup {
--   logging = true,
--   filetype = {
--     json = { format_prettier },
--     html = { format_prettier },
--   }
-- }
--
-- map('n', '<leader>p', ':Format<cr>:w<cr>')
