-- Shortcuts
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt
local api = vim.api

-- QoL
g.syntax_enable = false --< We have TreeSitter
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

-- Load utility functions
local utils = require 'utils'
local map = utils.map

-- Load programming language support
require 'lsp'
require 'treesitter'

--- Statusline
local lualine = require 'lualine'
lualine.setup({
    options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {},
        lualine_z = {'location'}
  },
    extensions = { 'nvim-tree', 'quickfix', 'aerial' },
    tabline = {
        lualine_a = {'buffers'},
    }
})

local luasnip = require 'luasnip'
local luasnip_snipmate_loader = require 'luasnip.loaders.from_snipmate'
luasnip_snipmate_loader.lazy_load({ paths = {"./snippets"}})

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
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
        { name = 'emoji'},
    }, {
        { name = 'buffer'}
   })
})

-- Telescope
local telescope = require 'telescope'
telescope.setup({

})
map("n", "ff", ":Telescope find_files<CR>")
map("n", "fg", ":Telescope live_grep<CR>")
map("n", "fb", ":Telescope buffers<CR>")
map("n", "ft", ":Telescope treesitter<CR>")

-- File Explorer
local nvim_tree = require 'nvim-tree'
nvim_tree.setup({
	view = {
		adaptive_size = true,
		side = "right",
		mappings = {
		}
	}
})
map("n", "<C-n>", ":NvimTreeOpen<CR>")

-- Git Integration
local gitsigns = require 'gitsigns'
gitsigns.setup({
        signcolumn = false,
        numhl = true
})

-- Everyday mappings
map("n", "<leader>h", "<C-W>h")
map("n", "<leader>j", "<C-W>j")
map("n", "<leader>k", "<C-W>k")
map("n", "<leader>l", "<C-W>l")
map("n", "<leader>s", ":vsplit<CR>")
map("n", "<leader>S", ":split<CR>")
map("n", "<leader>r", "<C-W>R")
map("n", "<leader>c", "<C-W>c")
map("n", "<leader>d", ":bd<CR>")

map("n", "<leader>u", ":bp<CR>")
map("n", "<leader>p", ":bn<CR>")

map("t", "\\tt", "<C-\\><C-n>")

map("nv", "<A-h>", "hhh")
map("nv", "<A-j>", "jjj")
map("nv", "<A-k>", "kkk")
map("nv", "<A-l>", "lll")

function quote(str)
        return "\"" .. str .. "\""
end

api.nvim_create_user_command("Quote", function(opts)
        local line = api.nvim_get_current_line()
        local quoted = quote(line)
        api.nvim_set_current_line(quoted)
end, {})

-- Make everything look pretty
local tokyonight = require 'tokyonight'
tokyonight.setup({
        style = "night"
})

vim.cmd('colorscheme tokyonight')
