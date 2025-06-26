require("mason").setup({
  ui = {
    border = "single",
  },
})
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "rust_analyzer", "lua_ls", "ruff", "biome", "ruby_lsp" },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
  },
})
