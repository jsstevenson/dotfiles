local Plugin = { "VonHeikemen/lsp-zero.nvim" }

Plugin.dependencies = {
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/nvim-cmp" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "stevearc/conform.nvim" },
  { "zapling/mason-conform.nvim" },
}
Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }
Plugin.event = { "BufReadPre", "BufNewFile" }

function Plugin.init()
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
      border = "single",
      -- source = 'always',
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "✘",
        [vim.diagnostic.severity.WARN] = "▲",
        [vim.diagnostic.severity.HINT] = "⚑",
        [vim.diagnostic.severity.INFO] = "»",
      },
    },
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
end

function Plugin.config()
  local lsp_zero = require("lsp-zero")
  lsp_zero.ui({ float_border = "single" })
  local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities() -- TODO use for other lang servers

  lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })

    vim.keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = bufnr })
    vim.keymap.set("n", "<Leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = bufnr })

    vim.g.lsp_zero_ui_float_border = "single"
  end)

  require("lspconfig.ui.windows").default_options.border = "single"

  -- setup MUST go mason -> conform -> mason-conform
  require("plugins.lsp.mason")
  require("plugins.lsp.conform")

  vim.keymap.set("n", "<Leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end)
end

return Plugin
