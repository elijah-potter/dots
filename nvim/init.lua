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

require 'git'
require 'snippets'
require 'completion'
require 'lsp'
require 'ast'
require 'filetree'
require 'statusline'
require 'colorscheme'

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

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = {"*"},
        command = ":%s/\\s\\+$//e"
})
