local renamer = require 'renamer'
local mason = require 'mason'
local mason_lspconfig = require 'mason-lspconfig'
local aerial = require 'aerial'
local trouble = require 'trouble'
local utils = require 'utils'
local mini_pairs = require 'mini.pairs'
local mini_indentscope = require "mini.indentscope"
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local signature = require 'lsp_signature'

signature.setup({
  bind = true,
  handler_opts = {
    border = "none"
  }
})

vim.diagnostic.config({
  virtual_text = false,
  float = {
    focus = false,
    scope = "cursor"
  }
})

vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local lvl = ({
    'ERROR',
    'WARN',
    'INFO',
    'DEBUG',
  })[result.type]
  vim.notify({ result.message }, lvl, {
    title = 'LSP | ' .. client.name,
    timeout = 5000,
    keep = function()
      return lvl == 'ERROR' or lvl == 'WARN'
    end,
  })
end

renamer.setup({})

mason.setup({})
mason_lspconfig.setup({
  automatic_installation = true
})

mini_pairs.setup({})
mini_indentscope.setup({
  draw = {
    animation = mini_indentscope.gen_animation.quartic({ duration = 5 })
  }
})

aerial.setup({
  backends = { "lsp", "treesitter", "markdown" },
  close_on_select = true,
  nerd_font = "auto",
  layout = {
    max_width = 100,
  },
  float = {
    border = "none"
  },
  lsp = {
    diagnostics_trigger_update = false,
  }
})

trouble.setup{
  position = "left",
}

utils.map("n", "<C-T>", ":Trouble<CR>")

local on_attach = function(client, bufnr)
  utils.map("n", "<C-X>", ":AerialOpen float<CR>")
  utils.map("n", "<C-F>", ":lua vim.lsp.buf.code_action()<CR>")
  utils.map("n", "<C-S>", ":lua vim.lsp.buf.hover()<CR>")
  utils.map("n", "<C-D>", ":lua vim.lsp.buf.definition()<CR>")
  utils.map("n", "<C-G>", function()
    renamer.rename()
  end)
  vim.api.nvim_create_autocmd("CursorHold,CursorHoldI", {
    command = ":lua vim.diagnostic.open_float(nil, nil)"
  });
end

local capabilities = cmp_nvim_lsp.default_capabilities();
capabilities.textDocument.completion.completionItem.snippetSupport = true

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Setup Languages
local files = { "rust", "web", "ltex", "lua", "python", "bash", "go" }

for _, file in ipairs(files) do
  local lang = require ('languages/' .. file)
  lang.setup(options)
end
