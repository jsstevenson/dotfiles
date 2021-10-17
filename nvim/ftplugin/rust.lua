vim.g.rustfmt_autosave = 0
vim.g.syntastic_rust_checkers = {}

-- LSP https://sharksforarms.dev/posts/neovim-rust/
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

