return require('packer').startup({function(use)
    use 'wbthomason/packer.nvim'

    -- appearance
    use {
        'jsstevenson/tokyonight.nvim',
        branch = 'new-colors'
    }
    use {
        'hoob3rt/lualine.nvim',
        config = function() require('plugins.status_line') end
    }
    use {
        'akinsho/nvim-bufferline.lua',
        config = function() require('bufferline').setup{} end,
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

    -- general
    use {
        'b0o/mapx.nvim',
        config = function() require('mapx').setup{} end
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make'
            }
        },
        config = function() require('plugins.telescope') end,
    }

    -- text objects & formatting
    -- use 'wellle/targets.vim'
    -- use 'michaeljsmith/vim-indent-object'
    use {
        'Vimjas/vim-python-pep8-indent',
        ft = {'python'}
    }
    -- try https://github.com/junegunn/vim-easy-align as well?
    use {
        'godlygeek/tabular',
        ft = {'tex', 'markdown'}
    }
    use {
        'numToStr/Comment.nvim',
        config = function ()
            require('Comment').setup()
        end
    }
    use 'tpope/vim-surround'
    use 'jiangmiao/auto-pairs'
    use {
        'jpalardy/vim-slime',
        -- ft = {'python', 'racket', 'javascript', 'javascriptreact'},
        config = function() require('plugins.slime') end,
    }

    -- treesitter stuff
    use {
        'nvim-treesitter/nvim-treesitter',
    }
    use {
        'RRethy/nvim-treesitter-endwise'
    }
    use {
        'windwp/nvim-ts-autotag'
    }
    use {
        'nvim-treesitter/playground'
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
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'}
        }
    }

    -- git
    use 'itchyny/vim-gitbranch' -- until I feel better about vim-fugitive
    use {
        'rhysd/conflict-marker.vim',
        config = function() require('plugins.conflict_marker') end,
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }

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
    use {
        'NTBBloodbath/rest.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('plugins.nvim-rest') end
    }
end,
config = {
    display = {
        open_fn = require('packer.util').float,
    }
}})
