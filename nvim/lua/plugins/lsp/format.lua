local conform = require("conform")
conform.setup({
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
  formatters_by_ft = {
    lua = { "stylua", lsp_format = "never" },
    rust = { "rustfmt", lsp_format = "never" },
    json = { "biome", lsp_format = "never" },
    python = { "ruff_format", lsp_format = "never" },
    javascript = { "biome", lsp_format = "never" },
    typescriptreact = { "biome", lsp_format = "never" },
  },
  formatters = {
    biome = {
      append_args = { "--format-with-errors", "true" },
    },
  },
})
vim.keymap.set("n", "<Leader>f", function()
  conform.format({ async = true, lsp_fallback = true })
end)
require("mason-conform").setup({ ignore_install = { "ruff", "biome" } })
