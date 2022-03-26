--------------------------------------------------------------------------------
-- top-level
--------------------------------------------------------------------------------
local present, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not present then
    return
end

local cmd = vim.cmd

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

local on_attach = function(_, bufnr)
    local fmap = function(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { silent = true, noremap = true })
    end
    fmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    fmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    fmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    fmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    fmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    fmap('n', '<c-j>', '<cmd>lua vim.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>')
    fmap('n', '<c-k>', '<cmd>lua vim.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>')
end

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
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
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
local options_json = {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

--------------------------------------------------------------------------------
-- html
--------------------------------------------------------------------------------
local options_html = {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}

--------------------------------------------------------------------------------
-- python
--------------------------------------------------------------------------------
-- local options_pyright = {
--     capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- }
--
local options_python = {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                yapf = { enabled = false },
                flake8 = { enabled = true }
            }
        }
    }
}

--------------------------------------------------------------------------------
-- rust
--------------------------------------------------------------------------------
-- https://sharksforarms.dev/posts/neovim-rust/
local options_rust = {
    on_attach = on_attach,
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

local options_lua = {
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
local options_ruby = {
    on_attach = on_attach,
    settings = {
        solargraph = {
            diagnostics = true
        }
    }
}

--------------------------------------------------------------------------------
-- initialize
--------------------------------------------------------------------------------
lsp_installer.on_server_ready(function(server)
    if server.name == 'pylsp' then server:setup(options_python)
    elseif server.name == 'solargraph' then server:setup(options_ruby)
    elseif server.name == 'sumneko_lua' then server:setup(options_lua)
    elseif server.name == 'html' then server:setup(options_html)
    elseif server.name == 'jsonls' then server:setup(options_json)
    elseif server.name == 'rust_analyzer' then server:setup(options_rust)
    else
        server:setup({})
    end
    vim.cmd [[ do User LspAttachBuffers ]]
end)
