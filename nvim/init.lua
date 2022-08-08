--------------------------------------------------------------------------------
-- TODO
--------------------------------------------------------------------------------
-- light theme
-- hot reload colors
--   breaks statusline?
-- filetype autocmds
-- nvim-lsp
--   individual LSPs: js, tex
--   key mapping updates
--   set root_dir = lspconfig.util.root_pattern('.git') as global default for lsps
--------------------------------------------------------------------------------
-- utilities
--------------------------------------------------------------------------------
-- https://oroques.dev/notes/neovim-init

require("packer_plugins")
require("lsp")
require("treesitter")
require("options")
require("mappings")
require("theme")
require("utils")

--------------------------------------------------------------------------------
-- TeX ftplugin?
--------------------------------------------------------------------------------
-- TODO:
-- compile shortcut
-- au FileType tex let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '"""':'"""'}
-- let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
-- aucmd to re-enable syntax highlighting
