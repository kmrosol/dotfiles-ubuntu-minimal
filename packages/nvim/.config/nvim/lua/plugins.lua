-- ============================================================================
-- Neovim Plugin Configuration with Packer
-- ============================================================================

vim.cmd.packadd "packer.nvim"

require("packer").startup(function()
  -- ============================================================================
  -- Package Manager
  -- ============================================================================
  use 'wbthomason/packer.nvim'

  -- ============================================================================
  -- Language Server Protocol (LSP)
  -- ============================================================================
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- ============================================================================
  -- Auto Completion
  -- ============================================================================
  use {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-vsnip',
  }

  -- ============================================================================
  -- File Navigation & Search
  -- ============================================================================
  -- Telescope file browser
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  -- Defx file explorer
  use {
    'Shougo/defx.nvim',
    'kristijanhusak/defx-git',
    'kristijanhusak/defx-icons',
    'ryanoasis/vim-devicons',
  }

  -- Fuzzy finder
  use {
    'ibhagwan/fzf-lua',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- ============================================================================
  -- Syntax Highlighting & Parsing
  -- ============================================================================
  use 'nvim-treesitter/nvim-treesitter'

  -- ============================================================================
  -- UI & Visual Enhancements
  -- ============================================================================
  -- Indentation guides
  use "lukas-reineke/indent-blankline.nvim"

  -- Color schemes
  use {
    "folke/tokyonight.nvim",
    'tiagovla/tokyodark.nvim',
  }

  -- ============================================================================
  -- Movement & Navigation
  -- ============================================================================
  -- Easy motion-like cursor movement
  use 'phaazon/hop.nvim'

  -- ============================================================================
  -- Editing Enhancements
  -- ============================================================================
  -- Auto-close brackets and tags
  use {
    "windwp/nvim-autopairs",
    "windwp/nvim-ts-autotag",
  }

  -- Surround text objects
  use {
    "kylechui/nvim-surround",
    tag = "*",
  }

  -- Comment toggling
  use 'numToStr/Comment.nvim'

end)

