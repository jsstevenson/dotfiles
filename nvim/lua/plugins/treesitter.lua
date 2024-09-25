local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.dependencies = {
  { "RRethy/nvim-treesitter-endwise" },
  { "nvim-treesitter/playground" },
}

-- Plugin.dependencies = {
--   {'nvim-treesitter/nvim-treesitter-textobjects'}
-- }

Plugin.opts = {
  highlight = {
    enable = true,
    disable = { "tex", "html" },
  },
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     lookahead = true,
  --     keymaps = {
  --       ['af'] = '@function.outer',
  --       ['if'] = '@function.inner',
  --       ['ac'] = '@class.outer',
  --       ['ic'] = '@class.inner',
  --     }
  --   },
  -- },
  ensure_installed = {
    "bash",
    "bibtex",
    "c",
    "cmake",
    "comment",
    "css",
    "graphql",
    "haskell",
    "html",
    "http",
    "javascript",
    "json",
    "julia",
    "julia",
    "lua",
    "make",
    "python",
    "query",
    "ruby",
    "rust",
    "scala",
    "scss",
    "sparql",
    "sql",
    "toml",
    "tsx",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  endwise = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python", "yaml" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
  autotag = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
}

function Plugin.config(name, opts)
  require("nvim-treesitter.configs").setup(opts)
end

return Plugin
