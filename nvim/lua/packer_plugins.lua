return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- appearance
    use {
        'jsstevenson/tokyonight.nvim',
        branch = 'new-colors'
    }
    use {
        'hoob3rt/lualine.nvim',
        config = function() require'plugins.lualine' end
    }
    use {
        'akinsho/nvim-bufferline.lua',
        config = function() require'bufferline'.setup{} end,
    }
    use 'voldikss/vim-floaterm'
    use {
        'mechatroner/rainbow_csv',
        ft = {'csv', 'tsv'}
    }
    use {
        'rrethy/vim-hexokinase',
	run = 'cd ~/.local/share/nvim/site/pack/packer/start/vim-hexokinase && make hexokinase'
    }

    -- text objects & formatting
    use 'wellle/targets.vim'
    use 'michaeljsmith/vim-indent-object'
    use {
        'Vimjas/vim-python-pep8-indent',
        ft = {'python'}
    }
    -- try https://github.com/junegunn/vim-easy-align as well?
    use {
        'godlygeek/tabular',
        ft = {'tex'}
    }
    use 'tpope/vim-commentary'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'jiangmiao/auto-pairs'
    use {
        'jpalardy/vim-slime',
        -- ft = {'python', 'racket', 'javascript', 'javascriptreact'},
        config = function() require'plugins.slime' end,
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        -- config = function() require'treesitter' end
    }
    use {
        'mhartington/formatter.nvim',
        ft = {
            'json', 'html', 'javascript',  'javascriptreact', 'typescript',
            'typescriptreact'
        },
        config = function() require'plugins.formatter' end,
    }

    -- LSP things
    use {
        'neovim/nvim-lspconfig',
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/vim-vsnip'},
            {'hrsh7th/vim-vsnip-integ'},
        },
    }
    use {
        'williamboman/nvim-lsp-installer',
        config = function() require'plugins.lsp_installer' end,
    }

    -- misc
    use 'itchyny/vim-gitbranch' -- until I feel better about vim-fugitive

    -- language-specific
    use {
        'nicwest/vim-http',
        ft = {'http'}
    }
    use {
        'wlangstroth/vim-racket',
        ft = {'racket'}
    }
    use {
        'rust-lang/rust.vim',
        ft = {'rust'}
    }
    use {
        'lervag/vimtex',
        ft = {'tex'}
    }
end)