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
  "kyazdani42/nvim-web-devicons",
  "neovim/nvim-lspconfig",
  "pmizio/typescript-tools.nvim",
  "echasnovski/mini.indentscope",
  "lewis6991/gitsigns.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  { "L3MON4D3/LuaSnip",                         build = "make install_jsregexp" },
  "kyazdani42/nvim-tree.lua",
  "nvim-lualine/lualine.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  "folke/trouble.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "smjonas/inc-rename.nvim",
  "ggandor/leap.nvim",
  "frabjous/knap",
  "MunifTanjim/nui.nvim",
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
  "folke/noice.nvim",
  "windwp/nvim-ts-autotag",
  "andweeb/presence.nvim",
  "stevearc/aerial.nvim",
  "folke/zen-mode.nvim",
  "stevearc/oil.nvim",
  "terryma/vim-expand-region",
  "nvim-telescope/telescope-frecency.nvim",
  "f-person/git-blame.nvim",
  "sindrets/diffview.nvim",
  "mfussenegger/nvim-dap",
  "nvim-neotest/nvim-nio",
  "rcarriga/nvim-dap-ui",
  "jay-babu/mason-nvim-dap.nvim",
  "folke/lazydev.nvim",
  "saecki/crates.nvim",
  'mrcjkb/rustaceanvim',
  'theHamsta/nvim-dap-virtual-text',
  'nvim-java/nvim-java',
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
  { 'akinsho/git-conflict.nvim',                version = "*",                                                                                 config = true },
  'NoahTheDuke/vim-just',
  'sindrets/diffview.nvim',
  { 'wakatime/vim-wakatime',        lazy = false },
  "sphamba/smear-cursor.nvim",
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = true,
      smear_insert_mode = true,
    },
  },
  { "miikanissi/modus-themes.nvim", priority = 1000 },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = "*",
  --   opts = {
  --     provider = "ollama",
  --     vendors = {
  --       ollama = {
  --         __inherited_from = "openai",
  --         api_key_name = "",
  --         endpoint = "http://127.0.0.1:11434/v1",
  --         model = "qwen2.5-coder",
  --       },
  --     },
  --   },
  --   build = "make",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --   },
  -- }
})
