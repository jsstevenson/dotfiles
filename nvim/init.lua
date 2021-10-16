--------------------------------------------------------------------------------
-- TODO
--------------------------------------------------------------------------------
-- light theme
-- hot reload colors
--   breaks statusline?
-- filetype autocmds
-- nvim-lsp
--   individual LSPs: js, tex, ruby
--   key mapping updates
--   set root_dir = lspconfig.util.root_pattern('.git') as global default for lsps
--------------------------------------------------------------------------------
-- utilities
--------------------------------------------------------------------------------
-- https://oroques.dev/notes/neovim-init
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

require('plugins');
require('appearance')
require('text')
require('terminal')

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------
cmd('set completeopt=menuone,noinsert,noselect')
cmd('set shortmess+=c')

local nvim_lsp = require'lspconfig'

-- installs
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}
    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- hover
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "single" }
)

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = true,
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = "single" }
)

-- tab completion
local cmp = require'cmp'

cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    }
})

-- map('i', '<Tab>', '<Plug>(completion_smart_tab)', {noremap = false, silent = true})
-- map('i', '<S-Tab>', '<Plug>(completion_smart_s_tab)', {noremap = false, silent = true})
-- map('i', '<Tab>', 'pumvisible() ? \"\\<C-n>" : \"\\<Tab>"', {expr = true})
-- map('i', '<S-Tab>', 'pumvisible() ? \"\\<C-p>" : \"\\<S-Tab>"', {expr = true})

-- other shortcuts
-- map('n', 'K', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent = true})  -- wtf isn't this working
cmd('nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {silent = true})
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {silent = true})
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {silent = true})
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent = true})
map('n', '<c-j>', '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', {silent = true})
map('n', '<c-k>', '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', {silent = true})


--------------------------------------------------------------------------------
-- Python
--------------------------------------------------------------------------------

nvim_lsp.pyright.setup{
    -- on_attach=require'completion'.on_attach
}

--------------------------------------------------------------------------------
-- TeX
--------------------------------------------------------------------------------
-- TODO:
-- compile shortcut
-- au FileType tex let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '"""':'"""'}
-- let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
-- aucmd to re-enable syntax highlighting

--------------------------------------------------------------------------------
-- C/C++
--------------------------------------------------------------------------------
-- augroup c_and_cpp
--     autocmd!
--     autocmd Filetype c,cpp set tabstop=2
--     autocmd Filetype c,cpp set softtabstop=2
--     autocmd Filetype c,cpp set shiftwidth=2
-- augroup END

--------------------------------------------------------------------------------
-- rust
--------------------------------------------------------------------------------

g.rustfmt_autosave = 0
g.syntastic_rust_checkers = {}

-- LSP https://sharksforarms.dev/posts/neovim-rust/
nvim_lsp.rust_analyzer.setup({
    -- on_attach=require'completion'.on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = 'last',
                importPrefix = 'by_self',
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

--------------------------------------------------------------------------------
-- lua
--------------------------------------------------------------------------------

require'lua-ls'

--------------------------------------------------------------------------------
-- HTML
--------------------------------------------------------------------------------

g.html_indent_inctags = 'html,body,head,tbody,div'
g.html_indent_script1 = 'inc'
nvim_lsp.html.setup{}

--------------------------------------------------------------------------------
-- JSON
--------------------------------------------------------------------------------

nvim_lsp.jsonls.setup{}

--------------------------------------------------------------------------------
-- formatter
--------------------------------------------------------------------------------

local function format_prettier()
   return {
     exe = "npx",
     args = {"prettier", "--stdin-filepath", vim.api.nvim_buf_get_name(0)},
     stdin = true
   }
end

require('formatter').setup {
  logging = true,
  filetype = {
    json = { format_prettier },
    html = { format_prettier },
    typescriptreact = { format_prettier },
  }
}

map('n', '<leader>p', ':Format<cr>:w<cr>')
