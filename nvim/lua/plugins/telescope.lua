local previewers = require("telescope.previewers")
local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = " >",
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<esc>"] = actions.close,
      },
    },
    layout_strategy = "vertical",
    file_ignore_patterns = {
      "node_modules",
      "site-packages",
      "build",
    },
  },
  -- pickers = {
  --     builtin.treesitter
  -- }
})

require("telescope").load_extension("fzf")
