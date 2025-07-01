-- TODO
-- * figure out autoimport
-- * reload LSP command
-- * figure out snippets
-- * would be nice to see if there's a way to identify configs being used
local Plugin = { "neovim/nvim-lspconfig" }

Plugin.dependencies = {
  { "mason-org/mason.nvim", opts = {}, cmd = { "Mason" } },
  { "mason-org/mason-lspconfig.nvim", opts = {} },
  { "stevearc/conform.nvim", opts = {} },
  { "smjonas/inc-rename.nvim" }, -- not working?
  { "stevearc/conform.nvim" },
  { "zapling/mason-conform.nvim" },
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
  require("mason").setup({
    ui = {
      border = "single",
    },
  })
  require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "ruff", "biome", "ruby_lsp", "rust_analyzer", "lua_ls" },
  })

  require("plugins.lsp.format")

  vim.lsp.config("luals", {
    settings = {
      ["luals"] = {
        capabilities = {
          textDocument = {
            formatting = false,
          },
        },
      },
    },
  })

  require("inc_rename").setup({ preview_empty_name = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    group = vim.api.nvim_create_augroup("lsp.config", {}),
    callback = function(args)
      local opts = { buffer = args.buf }
      vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
      vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
      vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
      vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
      vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
      vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
      vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      vim.keymap.set("n", "<leader>r", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
  })
end

return Plugin
