-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require "lazy"

lazy.setup({
  'kyazdani42/nvim-web-devicons',
  'neovim/nvim-lspconfig',
  'jose-elias-alvarez/typescript.nvim',
  'echasnovski/mini.indentscope',
  'lewis6991/gitsigns.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  { 'L3MON4D3/LuaSnip', build = "make install_jsregexp" },
  'kyazdani42/nvim-tree.lua',
  'nvim-lualine/lualine.nvim',
  'folke/twilight.nvim',
  'folke/zen-mode.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  'folke/trouble.nvim',
  'wuelnerdotexe/vim-enfocado',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'smjonas/inc-rename.nvim',
  'simrat39/rust-tools.nvim',
  'ggandor/leap.nvim',
  'ray-x/lsp_signature.nvim',
  'frabjous/knap',
  'SmiteshP/nvim-navbuddy',
  'SmiteshP/nvim-navic',
  'MunifTanjim/nui.nvim',
  'rudism/telescope-dict.nvim',
  'HiPhish/nvim-ts-rainbow2'
})
