local Plugins = {
  -- {'tpope/vim-fugitive'},
  -- {'wellle/targets.vim'},
  -- {'tpope/vim-repeat'},
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "Vimjas/vim-python-pep8-indent" },
  { "jsstevenson/nvim-tmux", opts = {} },
  { "kylechui/nvim-surround", opts = {} },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "rhysd/conflict-marker.vim" },
  {
    "mistweaverco/kulala.nvim",
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
  },
}

return Plugins
