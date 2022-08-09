local aerial = require 'aerial'
local trouble = require 'trouble'
local utils = require 'utils'
local map = utils.map
local autopairs = require 'nvim-autopairs'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

autopairs.setup({})

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

trouble.setup({
        position = "left",
        icons = true,
})

local options = {
        on_attach = function(client, bufnr)
                aerial.on_attach(client, bufnr)
        end,
        capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
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

map("n", "<C-X>", ":AerialToggle<CR>")
map("n", "<C-T>", ":TroubleToggle workspace_diagnostics<CR>")
map("n", "<C-F>", ":lua vim.lsp.buf.code_action()<CR>")
map("v", "<C-R>", ":lua vim.lsp.buf.range_code_action()<CR>")
map("n", "<C-S>", ":lua vim.lsp.buf.hover()<CR>")
map("n", "<C-D>", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<C-G>", ":lua vim.lsp.buf.rename()<CR>")
