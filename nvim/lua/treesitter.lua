local ts = require 'nvim-treesitter.configs'
ts.setup {
    ensure_installed = {
        'bash', 'bibtex', 'c', 'cpp', 'graphql',  'html', 'java', 'javascript',
        'jsdoc', 'json', 'jsonc', 'julia', 'lua', 'python', 'ruby', 'rust',
        'sparql', 'toml', 'tsx', 'typescript', 'yaml'
    },
    highlight = {enable = true, disable = { "tex", "html" } },
    indent = { enable = true, disable = { "rust", "lua", "python" } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        }
    },
    endwise = {
        enable = true,
    }
}

