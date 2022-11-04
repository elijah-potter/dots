local packer = require 'packer'

packer.startup(function()
  -- Let packer manage itself
  use 'wbthomason/packer.nvim'
  
  use 'kyazdani42/nvim-web-devicons'
  use 'neovim/nvim-lspconfig'
  use 'windwp/nvim-autopairs'
  use 'lewis6991/gitsigns.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'saadparwaiz1/cmp_luasnip'
  use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" }
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'
  use 'stevearc/aerial.nvim'
  use 'folke/tokyonight.nvim'
  use 'folke/twilight.nvim' 
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use "lukas-reineke/indent-blankline.nvim"
end)
