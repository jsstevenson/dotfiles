local Plugin = {"mason-org/mason-lspconfig.nvim"}
Plugin.dependencies = {
  { "mason-org/mason.nvim", opts= {}},
  "neovim/nvim-lspconfig",
}
Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }
Plugin.event = { "BufReadPre", "BufNewFile" }

function Plugin.init()
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "✘",
        [vim.diagnostic.severity.WARN] = "▲",
        [vim.diagnostic.severity.HINT] = "⚑",
        [vim.diagnostic.severity.INFO] = "»",
      },
    },
  })
end

function Plugin.config()

  require("plugins.lsp.mason")


end
