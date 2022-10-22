local aerial = require 'aerial'
local utils = require 'utils'
local autopairs = require 'nvim-autopairs'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

autopairs.setup({})

aerial.setup({
        backends = { "lsp", "treesitter", "markdown" },
        default_direction = "float",
        float = {
                border = "rounded",
        },
        close_on_select = true,
        nerd_font = "auto",
        lsp = {
                diagnostics_trigger_update = false,
        }
})

local options = {
        on_attach = function(client, bufnr)
                aerial.on_attach(client, bufnr)
        end,
        capabilities = cmp_nvim_lsp.default_capabilities()
}

-- Setup Languages
local rust = require 'languages/rust'
rust.setup(options)

local eslint = require 'languages/eslint'
eslint.setup(options)

local typescript = require 'languages/typescript'
typescript.setup(options)

local ltex = require 'languages/ltex'
ltex.setup(options)

utils.map("n", "<C-X>", ":AerialOpen<CR>")
utils.map("n", "<C-F>", ":lua vim.lsp.buf.code_action()<CR>")
utils.map("v", "<C-R>", ":lua vim.lsp.buf.range_code_action()<CR>")
utils.map("n", "<C-S>", ":lua vim.lsp.buf.hover()<CR>")
utils.map("n", "<C-D>", ":lua vim.lsp.buf.definition()<CR>")
utils.map("n", "<C-G>", ":lua vim.lsp.buf.rename()<CR>")
