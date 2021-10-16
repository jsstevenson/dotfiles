return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- appearance
    use {
        'jsstevenson/tokyonight.nvim',
        branch='new-colors'
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
    use 'Vimjas/vim-python-pep8-indent'
    -- try https://github.com/junegunn/vim-easy-align as well?
    use 'godlygeek/tabular'
    use 'tpope/vim-commentary'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'jiangmiao/auto-pairs'
    use 'jpalardy/vim-slime'
    use 'nvim-treesitter/nvim-treesitter'
    use 'mhartington/formatter.nvim'

    -- LSP things
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'nvim-lua/completion-nvim'

    -- misc
    use 'itchyny/vim-gitbranch' -- until I feel better about vim-fugitive

    -- language-specific
    use 'nicwest/vim-http'
    use 'wlangstroth/vim-racket'
    use 'rust-lang/rust.vim'
    use 'lervag/vimtex'
end)
