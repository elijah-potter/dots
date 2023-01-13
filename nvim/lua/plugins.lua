local packer = require 'packer'

packer.startup(function()
  -- Let packer manage itself
  use 'wbthomason/packer.nvim'

  use 'lewis6991/impatient.nvim'
  
  use 'kyazdani42/nvim-web-devicons'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/typescript.nvim'

  use 'echasnovski/mini.pairs'
  use 'echasnovski/mini.indentscope'

  use 'lewis6991/gitsigns.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" }
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'
  use 'stevearc/aerial.nvim'
  use 'folke/twilight.nvim' 
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'folke/trouble.nvim'

  use 'folke/noice.nvim'
  use 'MunifTanjim/nui.nvim'

  use 'wuelnerdotexe/vim-enfocado'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'filipdutescu/renamer.nvim'

  use 'simrat39/rust-tools.nvim'

  use 'epwalsh/obsidian.nvim'
  use 'ggandor/leap.nvim'
end)
