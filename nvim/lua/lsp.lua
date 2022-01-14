--------------------------------------------------------------------------------
-- top-level
--------------------------------------------------------------------------------
local cmd = vim.cmd

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


--------------------------------------------------------------------------------
-- basic functions
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- mappings
--------------------------------------------------------------------------------
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
map('n', '<c-j>', '<cmd>lua vim.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', {silent = true})
map('n', '<c-k>', '<cmd>lua vim.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', {silent = true})

--------------------------------------------------------------------------------
-- completion
--------------------------------------------------------------------------------

cmd('set completeopt=menuone,noinsert,noselect')
cmd('set shortmess+=c')

local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
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
        { name = 'vsnip' },
        { name = 'buffer' },
    },
    documentation = {
        maxheight = 50,
    }
})


--------------------------------------------------------------------------------
-- json
--------------------------------------------------------------------------------
require'lspconfig'.jsonls.setup{
    capabilities = capabilities
}

--------------------------------------------------------------------------------
-- html
--------------------------------------------------------------------------------
require'lspconfig'.html.setup{
    capabilities = capabilities
}

--------------------------------------------------------------------------------
-- python
--------------------------------------------------------------------------------
require'lspconfig'.pyright.setup{
    capabilities = capabilities
}
-- require'lspconfig'.pylsp.setup{
--     capabilities = capabilities
-- }

--------------------------------------------------------------------------------
-- rust
--------------------------------------------------------------------------------
-- https://sharksforarms.dev/posts/neovim-rust/
require'lspconfig'.rust_analyzer.setup({
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
USER = vim.fn.expand('$USER')

local sumneko_binary = "/Users/" .. USER .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"
local sumneko_root_path = "/Users/" .. USER .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server"

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            },
        }
    }
}
