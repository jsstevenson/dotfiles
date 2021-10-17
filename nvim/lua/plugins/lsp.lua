local cmd = vim.cmd

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

cmd('set completeopt=menuone,noinsert,noselect')
cmd('set shortmess+=c')

-- installs
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

