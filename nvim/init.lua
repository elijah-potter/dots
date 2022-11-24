-- Shortcuts
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api

-- QoL
g.syntax_enable = false

-- We have tree-sitter
g.mapleader = ' '
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'number'
opt.cursorline = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wildmode = 'longest,list'
opt.termguicolors = true
opt.clipboard = 'unnamedplus'
opt.foldmethod = 'indent'
opt.foldenable = false
opt.updatetime = 250

-- Load packages
require 'plugins'

-- Load utility functions
local utils = require 'utils'

-- Load programming language support
require 'lsp'
require 'treesitter'

--- Statusline
local lualine = require 'lualine'

local function time()
  local timetable = os.date('*t')
  return string.format("%02d:%02d:%02d", timetable.hour, timetable.min, timetable.sec)
end

lualine.setup({
  options = {
    theme = 'auto',
    section_separators = {left = '', right = ''},
    component_separators = {left = '', right = ''},
    globalstatus = true
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  extensions = {'nvim-tree', 'quickfix', 'aerial'},
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { time },
  }
})

-- Snippets
local luasnip = require 'luasnip'
luasnip.config.setup({
  enable_autosnippets = true,
  update_events = 'TextChanged,TextChangedI'
})

local luasnip_snipmate_loader = require 'luasnip.loaders.from_snipmate'
luasnip_snipmate_loader.lazy_load({paths = {"./snippets"}})

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Auto-Completion
local cmp = require 'cmp'
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lsp_signature_help' },
    },
    {
      { name = 'buffer' },
      { name = 'path' },
    }
  )
})

-- Telescope
local telescope = require 'telescope'

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    borderchars = { "", "", "", "", "", "", "", "" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    }
  },
  extensions = {
    ["ui-select"] = {
      sorting_strategy = "ascending",
      results_title = false,
      layout_strategy = "cursor",
      layout_config = {
        width = 60,
        height = 9,
      },
      borderchars = { "", "", "", "", "", "", "", "" },
    }
  }
})

telescope.load_extension('ui-select')
utils.map("n", "ff", ":Telescope find_files<CR>")
utils.map("n", "fg", ":Telescope live_grep<CR>")
utils.map("n", "ft", ":Telescope treesitter<CR>")
utils.map("n", "fb", ":Telescope current_buffer_fuzzy_find<CR>")

-- File Explorer
g.loaded = 1

-- Disable builtin netrw
g.loaded_netrwPlugin = 1

local nvim_tree = require 'nvim-tree'
nvim_tree.setup({
  view = {adaptive_size = true, side = "right", mappings = {}},
  open_on_setup = false,
  remove_keymaps = {"f"},
})
utils.map("n", "<C-n>", ":NvimTreeOpen<CR>")

-- Git Integration
local gitsigns = require 'gitsigns'
gitsigns.setup({signcolumn = false, numhl = true})

-- Allow focusing on specific parts of code
local twilight = require 'twilight'
twilight.setup()
utils.map("n", "<leader>t", ":Twilight<CR>")

-- Everyday mappings
utils.map("n", "<leader>h", "<C-W>h")
utils.map("n", "<leader>j", "<C-W>j")
utils.map("n", "<leader>k", "<C-W>k")
utils.map("n", "<leader>l", "<C-W>l")

utils.map("n", "<leader>s", ":vsplit<CR>")
utils.map("n", "<leader>S", ":split<CR>")

utils.map("n", "<leader>r", "<C-W>R")
utils.map("n", "<leader>c", "<C-W>c")
utils.map("n", "<leader>d", ":bd<CR>")

utils.map("n", "<leader>u", ":bp<CR>")
utils.map("n", "<leader>p", ":bn<CR>")

utils.map("t", "\\tt", "<C-\\><C-n>")

utils.map("nv", "<A-h>", "hhh")
utils.map("nv", "<A-j>", "jjj")
utils.map("nv", "<A-k>", "kkk")
utils.map("nv", "<A-l>", "lll")

-- Make everything look pretty
require("indent_blankline").setup {
  show_current_context = true,
  use_treesitter = true,
  char_blankline = '┆',
}

local tokyonight = require 'tokyonight'
tokyonight.setup({style = "night"})

vim.cmd('colorscheme tokyonight')
