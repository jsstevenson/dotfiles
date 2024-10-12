-- TODO
-- * biome for js
-- * something else for html, css, yaml
-- * some way to rely on local ruff/whatever install if available instead of mason-provided
require("conform").setup({
  default_format_opts = {
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua", lsp_format = "never" },
    rust = { "rustfmt", lsp_format = "never" },
  },
})
-- must be after require("conform")
require("mason-conform").setup({ ignore_install = { "ruff" } })
