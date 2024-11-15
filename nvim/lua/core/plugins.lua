require("lazy").setup({
  --- Colorsheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  --- Comment line easily
  "tpope/vim-commentary",
  --- File explorer for nvim
  "nvim-tree/nvim-tree.lua",
  --- Add icon to neovim
  "nvim-tree/nvim-web-devicons",
  --- Status bar
  "nvim-lualine/lualine.nvim",
  --- Parsing system
  "nvim-treesitter/nvim-treesitter",
  --- Git integration
  "tpope/vim-fugitive",
  --- Allow to change quickly " into '
  "tpope/vim-surround",
  --- Manage files/folder in nvim buffer
  "stevearc/oil.nvim",
  --- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  --- Snippet engine
  "L3MON4D3/LuaSnip",
  --- Completion luasnip engine
  "saadparwaiz1/cmp_luasnip",
  --- Collection of snippet
  "rafamadriz/friendly-snippets",
  --- Use Copilot AI from Github
  -- "github/copilot.vim",
  --- Package manager --> loading panes when start nvim
  "williamboman/mason.nvim",
  --- Completion for mason
  "williamboman/mason-lspconfig.nvim",
  --- Quickstart configs
  "neovim/nvim-lspconfig",
  --- Search files and content
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
})
