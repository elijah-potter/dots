-- Shortcuts
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

-- QoL
g.syntax_enable = true
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
        component_separators = { left = ' |', right = '| '},
        section_separators = { left = '█ ', right = ' █'},
    },
    extensions = { 'nvim-tree', 'quickfix', 'aerial' },
    tabline = {
        lualine_a = {'buffers'},
    }
})

-- Navigation
local aerial = require 'aerial'
aerial.setup({
        backends = { "lsp", "treesitter", "markdown" },
        default_direction = "float",
        float = {
                border = "rounded",
                relative = "cursor"
        },
        close_on_select = true,
        nerd_font = "auto",
        lsp = {
                diagnostics_trigger_update = false,
        }
})
map("n", "<C-X>", ":AerialToggle<CR>")

local luasnip = require 'luasnip'
local luasnip_vscode_loader = require 'luasnip.loaders.from_vscode'
luasnip_vscode_loader.lazy_load()

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
        { name = "emoji"}
    }, {
        { name = 'buffer'}
    })
})

-- File Explorer
local nvim_tree = require 'nvim-tree'
nvim_tree.setup({
	view = {
		adaptive_size = true,
		side = "right",
		mappings = {
			list = {
				{ key = "H", action = "none" },
				{ key = "L", action = "none" }
			}
		}
	}
})
map("n", "<C-n>", ":NvimTreeToggle<CR>")

-- Git Integration
local gitsigns = require 'gitsigns'
gitsigns.setup()

-- Everyday mappings
map("n", "<S-H>", "<C-W>h")
map("n", "<S-J>", "<C-W>j")
map("n", "<S-K>", "<C-W>k")
map("n", "<S-L>", "<C-W>l")

map("n", "<S-A>", "<C-W>H")
map("n", "<S-C>", "<C-W>c")

map("n", "<C-h>", ":bp<CR>")
map("n", "<C-l>", ":bn<CR>")

map("nv", "<A-h>", "hh")
map("nv", "<A-j>", "jj")
map("nv", "<A-k>", "kk")
map("nv", "<A-l>", "ll")

-- Make everything look pretty
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_lualine_bold = true

vim.cmd('colorscheme tokyonight')
