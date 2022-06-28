local lspconfig = require 'lspconfig'
local aerial = require 'aerial'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local utils = require 'utils'
local map = utils.map
local autopairs = require 'nvim-autopairs'

autopairs.setup({})

local settings = {
	ltex = {},
	eslint = {},
	tsserver = {},
	jsonls = {},
	rust_analyzer = {
		['rust-analyzer'] = {
            		checkOnSave = {
                		command = 'clippy',
            		},
        	},
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local on_attach = aerial.on_attach

for name, setting in pairs(settings) do
	lspconfig[name].setup({
        on_attach = on_attach,
		capabilities = capabilities,
		settings = setting
	})
end

map("n", "<C-F>", ":lua vim.lsp.buf.code_action()<CR>")
map("n", "<C-S>", ":lua vim.lsp.buf.hover()<CR>")
map("n", "<C-D>", ":lua vim.lsp.buf.definition()<CR>")
