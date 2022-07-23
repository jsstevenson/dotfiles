--------------------------------------------------------------------------------
-- top-level
--------------------------------------------------------------------------------
require("nvim-lsp-installer").setup({
    ensure_installed = {
        "rust_analyzer", "sumneko_lua", "jsonls", "tsserver", "cssls",
        "graphql", "html", "pyright"
    },
    automatic_installation = true,
    ui = {
        border = "double"
    }
})
local lspconfig = require("lspconfig")

local cmd = vim.cmd

local capabilities_cmp = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
local mapx = require('mapx')

-- map('i', '<Tab>', '<Plug>(completion_smart_tab)', {noremap = false, silent = true})
-- map('i', '<S-Tab>', '<Plug>(completion_smart_s_tab)', {noremap = false, silent = true})
-- map('i', '<Tab>', 'pumvisible() ? \"\\<C-n>" : \"\\<Tab>"', {expr = true})
-- map('i', '<S-Tab>', 'pumvisible() ? \"\\<C-p>" : \"\\<S-Tab>"', {expr = true})

local on_attach = function(_, _)
    local options = { silent = true, buffer = true }

    mapx.nnoremap('K', function() vim.lsp.buf.hover() end, options)
    mapx.nnoremap('gD', function() vim.lsp.buf.declaration() end, options)
    mapx.nnoremap('gd', function() vim.lsp.buf.definition() end, options)
    mapx.nnoremap('gr', function() vim.lsp.buf.references() end, options)
    mapx.nnoremap('gi', function() vim.lsp.buf.implementation() end, options)
    mapx.nnoremap('<C-j>', function() vim.diagnostic.goto_next({ popup_opts = { border = "single" }}) end, options)
    mapx.nnoremap('<C-k>', function() vim.diagnostic.goto_prev({ popup_opts = { border = "single" }}) end, options)
end

--------------------------------------------------------------------------------
-- completion
--------------------------------------------------------------------------------

cmd('set completeopt=menuone,noinsert,noselect')
cmd('set shortmess+=c')

local cmp = require('cmp')

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
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
    },
    window = {
        documentation = {
            maxheight = 50,
        }
    }
})


--------------------------------------------------------------------------------
-- json
--------------------------------------------------------------------------------
lspconfig.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities_cmp
}

--------------------------------------------------------------------------------
-- html
--------------------------------------------------------------------------------
lspconfig.html.setup {
    on_attach = on_attach,
    capabilities = capabilities_cmp
}

--------------------------------------------------------------------------------
-- python
--------------------------------------------------------------------------------
lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities_cmp
}

-- local options_python = {
--     on_attach = on_attach,
--     capabilities = capabilities_cmp,
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = { enabled = false },
--                 pyflakes = { enabled = false },
--                 yapf = { enabled = false },
--                 flake8 = { enabled = true }
--             }
--         }
--     }
-- }

--------------------------------------------------------------------------------
-- rust
--------------------------------------------------------------------------------
-- https://sharksforarms.dev/posts/neovim-rust/
lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities_cmp,
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
}

--------------------------------------------------------------------------------
-- lua
--------------------------------------------------------------------------------
USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

sumneko_binary = "/Users/" .. USER .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"
sumneko_root_path = "/Users/" .. USER .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server"

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    capabilities = capabilities_cmp,
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

--------------------------------------------------------------------------------
-- ruby
--------------------------------------------------------------------------------
lspconfig.solargraph.setup {
    on_attach = on_attach,
    capabilities = capabilities_cmp,
    settings = {
        solargraph = {
            diagnostics = true
        }
    }
}
