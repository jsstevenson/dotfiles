USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

sumneko_binary = "/Users/" .. USER .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/macOS/lua-language-server"
sumneko_root_path = "/Users/" .. USER .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server"

-- local on_attach = function(client)
--     require'completion'.on_attach(client)
-- end

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
--    on_attach = on_attach,
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
