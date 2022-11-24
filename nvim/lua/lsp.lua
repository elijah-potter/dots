local aerial = require 'aerial'
local utils = require 'utils'
local autopairs = require 'nvim-autopairs'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'

vim.diagnostic.config({
  virtual_text = false,
  float = {
    focus = false,
    scope = "cursor"
  }
})

autopairs.setup({})

aerial.setup({
  backends = { "lsp", "treesitter", "markdown" },
  close_on_select = true,
  nerd_font = "auto",
  lsp = {
    diagnostics_trigger_update = false,
  }
})

local on_attach = function(client, bufnr)
  utils.map("n", "<C-X>", ":AerialOpen<CR>")
  utils.map("n", "<C-F>", ":lua vim.lsp.buf.code_action()<CR>")
  utils.map("n", "<C-S>", ":lua vim.lsp.buf.hover()<CR>")
  utils.map("n", "<C-D>", ":lua vim.lsp.buf.definition()<CR>")
  utils.map("n", "<C-G>", ":lua vim.lsp.buf.rename()<CR>")
  vim.api.nvim_create_autocmd("CursorHold,CursorHoldI", {
    command = ":lua vim.diagnostic.open_float(nil, nil)"
  });
end

local options = {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.default_capabilities(),
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

local lua = require 'languages/lua'
lua.setup(options)
