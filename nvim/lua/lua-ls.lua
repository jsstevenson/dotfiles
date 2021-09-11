USER = vim.fn.expand('$USER')

local sumneko_root_path = "/Users/" .. USER .. "/.local/share/nvim/lspinstall/lua/sumneko-lua"
local sumneko_binary = "/Users/" .. USER .. "/.local/share/nvim/lspinstall/lua/sumneko-lua-language-server"

local on_attach = function(client)
    require'completion'.on_attach(client)
end

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = on_attach,
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
