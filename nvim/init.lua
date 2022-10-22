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
opt.signcolumn = 'number'
opt.cursorline = true
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.wildmode = 'longest,list'
opt.termguicolors = true
opt.clipboard = 'unnamedplus'

-- Load packages
require 'plugins'

-- Load cache
require 'impatient'

-- Load utility functions
local utils = require 'utils'

-- Load programming language support
require 'lsp'
require 'treesitter'

--- Statusline
local lualine = require 'lualine'
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
        }
})

local luasnip = require 'luasnip'
local luasnip_snipmate_loader = require 'luasnip.loaders.from_snipmate'
luasnip_snipmate_loader.lazy_load({paths = {"./snippets"}})

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
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                })
        },
        sources = cmp.config.sources(
                {
                        {name = 'nvim_lsp'},
                        {name = 'luasnip'},
                        {name = 'path'},
                },
                {{name = 'buffer'}}
        )
})

-- Telescope
local telescope = require 'telescope'
telescope.setup()
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
        remove_keymaps = {"f"}
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
opt.list = true
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"

require("indent_blankline").setup {
        show_current_context = true,
        use_treesitter = true,
        char_blankline = '┆',
}

local tokyonight = require 'tokyonight'
tokyonight.setup({style = "night"})

vim.cmd('colorscheme tokyonight')
