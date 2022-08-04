local aerial = require 'aerial'
local utils = require 'utils'
local map = utils.map
local autopairs = require 'nvim-autopairs'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

autopairs.setup({})

local on_attach = function(...)
        aerial.on_attach(...)
end

local capabilities = vim.lsp.protocol.make_client_capabilities();
capabilities = cmp_nvim_lsp.update_capabilities(capabilities);

-- Setup Languages
local rust = require 'languages/rust'
rust.setup({on_attach = on_attach, capabilities = capabilities})

local eslint = require 'languages/eslint'
eslint.setup({on_attach = on_attach, capabilities = capabilities})

map("n", "<C-F>", ":lua vim.lsp.buf.code_action()<CR>")
map("v", "<C-R>", ":lua vim.lsp.buf.range_code_action()<CR>")
map("n", "<C-S>", ":lua vim.lsp.buf.hover()<CR>")
map("n", "<C-D>", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<C-G>", ":lua vim.lsp.buf.rename()<CR>")
