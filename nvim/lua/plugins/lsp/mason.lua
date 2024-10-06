require("mason").setup({
  ui = {
    border = "single",
  },
})
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "rust_analyzer", "lua_ls", "ruff" },
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        on_init = function(client)
          require("lsp-zero").nvim_lua_settings(client, {})
        end,
      })
    end,
  },
})
