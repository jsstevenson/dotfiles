local ts = require 'nvim-treesitter.configs'
ts.setup {
    ensure_installed = {
        'bash', 'bibtex', 'c', 'cpp', 'graphql',  'html', 'java', 'javascript',
        'jsdoc', 'json', 'jsonc', 'julia', 'lua', 'python', 'ruby', 'rust',
        'sparql', 'toml', 'tsx', 'typescript', 'yaml', 'query'
    },
    highlight = {enable = true, disable = { "tex", "html" } },
    indent = { enable = true, disable = { "rust", "lua", "python", "ruby" } },
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
    },
    autotag = {
        enable = true,
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
}

