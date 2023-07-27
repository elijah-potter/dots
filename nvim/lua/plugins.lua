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
  "pmizio/typescript-tools.nvim",
  'echasnovski/mini.indentscope',
  'lewis6991/gitsigns.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'saadparwaiz1/cmp_luasnip',
  { 'L3MON4D3/LuaSnip', build = "make install_jsregexp" },
  'kyazdani42/nvim-tree.lua',
  'nvim-lualine/lualine.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/nvim-treesitter-context',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  'folke/trouble.nvim',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'smjonas/inc-rename.nvim',
  'simrat39/rust-tools.nvim',
  'ggandor/leap.nvim',
  'frabjous/knap',
  'SmiteshP/nvim-navbuddy',
  'SmiteshP/nvim-navic',
  'MunifTanjim/nui.nvim',
  'rudism/telescope-dict.nvim',
  {
    'glacambre/firenvim',
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
      require("lazy").load({ plugins = "firenvim", wait = true })
      vim.fn["firenvim#install"](0)
    end
  },
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
  'wakatime/vim-wakatime',
  "folke/noice.nvim",
  "windwp/nvim-ts-autotag",
  "EdenEast/nightfox.nvim",
  "andweeb/presence.nvim"
})
