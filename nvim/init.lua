-- Shortcuts
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api

-- QoL
g.syntax_enable = false

g.mapleader = ' '
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

--- Statusline
local lualine = require 'lualine'

local function time()
  local timetable = os.date('*t')
  return string.format("%01d:%02d:%02d", timetable.hour, timetable.min, timetable.sec)
end

local function fileexists(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end

local function getepoch()
  return os.time(os.date("!*t"))
end

local lastwordcount = "";
local lastwordcountupdate = getepoch();

local function wordcount()
  if getepoch() - lastwordcountupdate < 5 then
    return lastwordcount;
  end

  local filepath = vim.fn.expand('%')

  if filepath == nil or filepath == '' or not fileexists(filepath) then
    return ""
  end

  local handle = io.popen('harper-cli parse ' .. filepath .. ' | grep Word | wc -l')
  local output = handle:read('*a'):gsub("[\n\r]", " ")

  lastwordcount = output;
  lastwordcountupdate = getepoch()

  return output
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
      { name = 'lazydev' },
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
    file_ignore_patterns = { '.git' },
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
    },
  },
  extensions = {
    ["ui-select"] = {
      sorting_strategy = "ascending",
      results_title = false,
      layout_strategy = "cursor",
      layout_config = {
        width = 80,
        height = 20,
      },
      borderchars = { "", "", "", "", "", "", "", "" },
    },
    frecency = {
      db_safe_mode = false,
      auto_validate = true
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

local gitblame = require 'gitblame'
gitblame.setup({
  enabled = false
})

utils.map("n", "<leader>i", ":GitBlameToggle<CR>")

-- Focus windows
utils.map("n", "<leader>h", "<C-W>h")
utils.map("n", "<leader>j", "<C-W>j")
utils.map("n", "<leader>k", "<C-W>k")
utils.map("n", "<leader>l", "<C-W>l")

-- Split along the vertical center
utils.map("n", "<leader>s", ":vsplit<CR>")
-- Split along the horizontal center
utils.map("n", "<leader>S", ":split<CR>")

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

vim.api.nvim_create_user_command("CopyRelPath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Reload Neovim
utils.map("n", "<leader><leader>r", ":source $MYVIMRC<CR>")

-- Discord presence
local presence = require "presence"
presence.setup({
  main_image = "file"
})

-- -- Make everything look pretty
-- local noice = require 'noice'
-- noice.setup({
--   lsp = {
--     override = {
--       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--       ["vim.lsp.util.stylize_markdown"] = true,
--       ["cmp.entry.get_documentation"] = true,
--     },
--   },
--   presets = {
--     bottom_search = true,
--     command_palette = true,
--     long_message_to_split = true,
--     inc_rename = true,
--     lsp_doc_border = false,
--   },
-- })

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

vim.keymap.set("n", "<leader>o", function()
  vim.fn.jobstart({ "tatum", "serve", "--open", vim.fn.expand('%') }, { noremap = true, silent = true })
end)

local theme = os.getenv("GTK_THEME") or ""
if os.getenv("GTK_THEME"):find "dark" then
  require("catppuccin").setup({
    flavour = "mocha"
  })
else
  require("catppuccin").setup({
    flavour = "latte"
  })
end

vim.cmd.colorscheme "catppuccin"
