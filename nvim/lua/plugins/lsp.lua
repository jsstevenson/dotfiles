-- TODO
-- * figure out format
local Plugin = { "neovim/nvim-lspconfig" }

Plugin.dependencies = {
  { "mason-org/mason.nvim",           opts = {} },
  { "mason-org/mason-lspconfig.nvim", opts = {} },
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
  require("mason").setup({
    ui = {
      border = "single",
    },
  })
  require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "rust_analyzer", "lua_ls", "ruff", "biome", "ruby_lsp", "harper_ls" },
    -- handlers = {
    --   function(server_name)
    --     require("lspconfig")[server_name].setup({})
    --   end,
    -- },
  })

  require("inc_rename").setup({ preview_empty_name = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    group = vim.api.nvim_create_augroup("lsp.config", {}),
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      local opts = { buffer = args.buf }
      -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      if client:supports_method("textDocument/formatting") then
        vim.keymap.set({ 'n', 'x' }, '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      end
      -- vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      vim.keymap.set("n", "<leader>r", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end})

    vim.lsp.config("harper_ls", {
      settings = {
        ["harper-ls"] = {
          linters = {
            SpellCheck = true,
            SpelledNumbers = false,
            AnA = false,
            SentenceCapitalization = false,
            UnclosedQuotes = false,
            WrongQuotes = false,
            LongSentences = false,
            RepeatedWords = false,
            Spaces = false,
            Matcher = false,
            CorrectNumberSuffix = true
          }
        }
      }
    })
end

return Plugin
