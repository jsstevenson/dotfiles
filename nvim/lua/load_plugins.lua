require("lazy").setup({
  -- theme
  {
    "folke/tokyonight.nvim"
  },
  -- {
  --   "jsstevenson/tokyonight.nvim",
  --   branch = "new-colors"
  -- },
  {
    "nvim-lualine/lualine.nvim", config = function()
      require("plugins.status_line")
    end,
  },
{
	"akinsho/nvim-bufferline.lua",
	dependencies = { { "kyazdani42/nvim-web-devicons" } },
	config = function()
		require("bufferline").setup({})
	end
},
{
	"mechatroner/rainbow_csv",
	ft = { "csv", "tsv" }
},
  -- https://github.com/akinsho/toggleterm.nvim
    -- {
    --   "voldikss/vim-floaterm",
    --   config = function()
    --     require("plugins.floaterm")
    --   end,
    -- },
    {
      "rrethy/vim-hexokinase",
      build = "make hexokinase",
    },

    -- telescope
    {
      "nvim-telescope/telescope.nvim",
      tag = '0.1.2',
      dependencies = {
        { "nvim-lua/plenary.nvim" }
      },
      config = function()
        require("plugins.telescope")
      end,
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    ---- text objects & formatting
    ---- use 'wellle/targets.vim'
    ---- use 'michaeljsmith/vim-indent-object'
    {
      "Vimjas/vim-python-pep8-indent",
      ft = { "python" },
    },
    ---- try https://github.com/junegunn/vim-easy-align as well?
    {
      "godlygeek/tabular",
      ft = { "tex", "markdown" },
    },
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    },
		{"tpope/vim-surround"},
    -- https://github.com/windwp/nvim-autopairs ?
		{"jiangmiao/auto-pairs"},
    {
      "jpalardy/vim-slime",
      ft = {'python', 'racket', 'javascript', 'javascriptreact'},
      config = function()
        require("plugins.slime")
      end,
    },

    ---- treesitter stuff
    {
      "nvim-treesitter/nvim-treesitter",
    },
    {
      "RRethy/nvim-treesitter-endwise",
    },
    {
      "windwp/nvim-ts-autotag",
    },
    {
      "nvim-treesitter/playground",
    },

    ---- LSP things
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/vim-vsnip" },
        { "hrsh7th/vim-vsnip-integ" },
        -- Plug 'hrsh7th/cmp-path'  # TODO look at
        -- Pug 'hrsh7th/cmp-cmdline'
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
      },
    },

    ---- git
    ---- vim-fugitive, someday?
    {
      "rhysd/conflict-marker.vim",
      config = function()
        require("plugins.conflict_marker")
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    },

    ---- language-specific
    {
      "nicwest/vim-http",
      ft = { "http" },
    },
    {
      "wlangstroth/vim-racket",
      ft = { "racket" },
    },
    {
      "rust-lang/rust.vim",
      ft = { "rust" },
    },
    {
      "lervag/vimtex",
      ft = { "tex" },
    },
    {
      "NTBBloodbath/rest.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("plugins.nvim-rest")
      end,
    },
    {
       -- "~/code/nvim-tmux/",
      "jsstevenson/nvim-tmux",
      ft = { "tmux" },
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("nvim_tmux").setup()
      end,
    },
})
