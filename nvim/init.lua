-- Shortcuts
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api

-- QoL
g.syntax_enable = false

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
opt.wrap = true

opt.colorcolumn = "80"

-- Load packages
require 'plugins'

-- Load utility functions
local utils = require 'utils'

-- Load programming language support
require 'lsp'
require 'treesitter'

-- Hehe
local apm = require 'vim-apm'
apm:setup({})
vim.keymap.set("n", "<leader>apm", function() apm:toggle_monitor() end)

--- Statusline
local lualine = require 'lualine'

local function time()
  local timetable = os.date('*t')
  return string.format("%01d:%02d:%02d", timetable.hour, timetable.min, timetable.sec)
end

lualine.setup({
  options = {
    theme = 'auto',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    globalstatus = true
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { { 'filename', path = 4 } },
    lualine_x = { 'filetype' },
    lualine_y = {},
    lualine_z = { 'location' }
  },
  extensions = { 'nvim-tree', 'quickfix', 'aerial' },
  tabline = {
    lualine_a = { { 'buffers', show_filename_only = false } },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { time },
  }
})

require 'snippets'

-- Auto-Completion
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ['<C-P>'] = cmp.mapping.select_prev_item(),
    ["<C-N>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
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
      { name = 'buffer' },
      { name = 'path' },
    }
  )
})

-- Markdown and LaTeX previewing
local knap = require 'knap'

vim.g.knap_settings = {
  textopdf = "pdflatex -jobname \"$(basename -s .pdf %outputfile%)\" -halt-on-error",
  textopdfbufferasstdin = true,
  mdoutputext = "pdf",
  mdtopdf = "~/.config/pandoc_wrap.sh %docroot% %outputfile%"
}

utils.map("nv", "<leader><leader>s", function()
  knap.toggle_autopreviewing()
end)

-- Telescope
local telescope = require 'telescope'
local actions = require 'telescope.actions'

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
    },
    frecency = {
      auto_validate = false
    }
  }
})

telescope.load_extension('ui-select')
telescope.load_extension('frecency')

utils.map("n", "<leader>f", ":Telescope frecency workspace=CWD<CR>")
utils.map("n", "<leader>g", ":Telescope live_grep<CR>")
utils.map("n", "<leader>t", ":Telescope treesitter<CR>")
utils.map("n", "<leader>b", ":Telescope current_buffer_fuzzy_find<CR>")

-- Oil
local oil = require 'oil'
oil.setup()

-- Leaping
local leap = require 'leap'
leap.add_default_mappings()

-- File Explorer
g.loaded = 1

-- Disable builtin netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

local nvim_tree = require 'nvim-tree'

nvim_tree.setup({
  view = { adaptive_size = true, side = "right" },
})
utils.map("n", "<C-n>", ":NvimTreeOpen<CR>")
utils.map("n", "<leader>n", ":NvimTreeFindFile<CR>")

-- Git Integration
local gitsigns = require 'gitsigns'
gitsigns.setup({ signcolumn = false, numhl = true })

-- Focus windows
utils.map("n", "<leader>h", "<C-W>h")
utils.map("n", "<leader>j", "<C-W>j")
utils.map("n", "<leader>k", "<C-W>k")
utils.map("n", "<leader>l", "<C-W>l")

-- Split along the vertical center
utils.map("n", "<leader>s", ":vsplit<CR>")
-- Split along the horizontal center
utils.map("n", "<leader>S", ":split<CR>")

-- Swap windows
utils.map("n", "<leader>r", "<C-W>R")
-- Close windows
utils.map("n", "<leader>c", "<C-W>c")
-- Delete buffer
utils.map("n", "<leader>d", ":bd<CR>")
-- Delete all buffers
utils.map("n", "<leader><leader>q", ":bufdo bd<CR>")

-- Switch tabs
utils.map("n", "<leader>u", ":bp<CR>")
utils.map("n", "<leader>p", ":bn<CR>")

utils.map("nv", "<C-A-j>", "<C-D>")
utils.map("nv", "<C-A-k>", "<C-U>")

-- Reload Neovim
utils.map("n", "<leader><leader>r", ":source $MYVIMRC<CR>")

-- Discord presence
local presence = require "presence"
presence.setup({
  main_image = "file"
})

-- Make everything look pretty
local noice = require 'noice'
noice.setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = false,
  },
})

local nightfox = require 'nightfox'
nightfox.setup({
  options = {
    transparent = true,
    styles = {
      comments = "italic",
      functions = "bold",
    }
  },
})

if vim.g.neovide then
  vim.o.guifont = "MonaspiceNe NFM:h12"
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_floating_shadow = false

  if os.getenv("GTK_THEME"):find "dark" then
    vim.g.neovide_transparency = 0.7
  else
    vim.g.neovide_transparency = 1
  end
end

if os.getenv("GTK_THEME"):find "dark" then
  vim.cmd([[ colorscheme carbonfox ]])
else
  vim.cmd([[ colorscheme dayfox ]])
end
