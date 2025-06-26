-- TODO
-- * figure out format
local Plugin = {"neovim/nvim-lspconfig"}

Plugin.dependencies = {
  { "mason-org/mason.nvim", opts = {} },
  { "williamboman/mason-lspconfig.nvim", opts = {} },
  { "smjonas/inc-rename.nvim" },
}
Plugin.cmd = { "LspInfo", "LspInstall", "LspUnInstall", "Mason" }
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

  require("inc_rename").setup({ preview_empty_name = true })

--   -- setup MUST go mason -> conform -> mason-conform
--   require("plugins.lsp.mason")
--   require("plugins.lsp.format")
--
--   vim.keymap.set("n", "<Leader>f", function()
--     require("conform").format({ async = true, lsp_fallback = true })
--   end)
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    group = vim.api.nvim_create_augroup("lsp.config", {}),
    callback = function(args)
      local opts = { buffer = args.buf }
      -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      -- vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      -- vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      vim.keymap.set("n", "<leader>r", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })

    end
  })
end

return Plugin
