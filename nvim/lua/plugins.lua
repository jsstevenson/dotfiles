return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- appearance
    use {
        'jsstevenson/tokyonight.nvim',
        branch = 'new-colors'
    }
    use 'hoob3rt/lualine.nvim'
    use 'akinsho/nvim-bufferline.lua'
    use 'voldikss/vim-floaterm'
    use 'mechatroner/rainbow_csv'
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
    use 'godlygeek/tabular'
    use 'tpope/vim-commentary'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'jiangmiao/auto-pairs'
    use {
        'jpalardy/vim-slime',
        ft = {'python', 'racket', 'javascript', 'javascriptreact'}
    }
    use 'nvim-treesitter/nvim-treesitter'
    use 'mhartington/formatter.nvim'

    -- LSP things
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

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
