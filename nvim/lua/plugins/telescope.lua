local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.dependencies = {
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

Plugin.cmd = { "Telescope" }

function Plugin.init()
  vim.keymap.set("n", "ff", "<cmd>Telescope find_files<cr>", { silent = true })
  vim.keymap.set("n", "fg", "<cmd>Telescope live_grep<cr>", { silent = true })
  vim.keymap.set("n", "fd", "<cmd>Telescope diagnostics<cr>", { silent = true })
  vim.keymap.set("n", "fh", "<cmd>Telescope help_tags<cr>", { silent = true })
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { silent = true })
  -- vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
  -- vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
  vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
  -- vim.keymap.set('n', 'fh', '<cmd>Telescope help_tags')
end

function Plugin.config()
  local telescope = require("telescope")
  telescope.load_extension("fzf")

  local previewers = require("telescope.previewers")
  local actions = require("telescope.actions")
  telescope.setup({
    defaults = {
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
    },
    file_ignore_patterns = {
      "node_modules",
      "site-packages",
      "build",
      "dist",
      ".venv",
    },
  })
end

return Plugin
