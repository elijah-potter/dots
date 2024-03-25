local mason = require 'mason'
local mason_lspconfig = require 'mason-lspconfig'
local utils = require 'utils'
local mini_indentscope = require "mini.indentscope"
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local trouble = require 'trouble'

trouble.setup({
  position = "left",
})

vim.diagnostic.config({
  virtual_text = true,
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

mason.setup({})
mason_lspconfig.setup({
  automatic_installation = true
})

mini_indentscope.setup({
  draw = {
    animation = mini_indentscope.gen_animation.quartic({ duration = 5 })
  }
})

local aerial = require 'aerial'
aerial.setup({
  close_on_select = true
})

utils.map("n", "<C-T>", ":Trouble workspace_diagnostics<CR>")

local on_attach = function(client, bufnr)
  local lsp_inlayhints = require 'lsp-inlayhints'
  lsp_inlayhints.setup()
  lsp_inlayhints.on_attach(client, bufnr)

  utils.map("n", "<C-X>", ":AerialToggle float<CR>")

  utils.map("n", "<C-F>", function()
    vim.lsp.buf.code_action()
  end)
  utils.map("n", "<C-S>", function()
    vim.lsp.buf.hover()
  end)
  utils.map("n", "<C-D>", function()
    vim.lsp.buf.definition()
  end)
  utils.map("n", "<C-W>", function()
    vim.diagnostic.goto_prev()
  end)
  utils.map("n", "<C-E>", function()
    vim.diagnostic.goto_next()
  end)

  vim.keymap.set("n", "<C-G>", function()
    local inc_rename = require 'inc_rename'
    inc_rename.setup();
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function()
      pcall(function()
        -- These have special, non-LSP formatters
        local blacklist = { "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "markdown", "css" }

        if not utils.contains(blacklist, vim.bo.filetype) then
          vim.lsp.buf.format({ timeout_ms = 200 })
        end
      end)
    end,
  })
end

local capabilities = cmp_nvim_lsp.default_capabilities();
capabilities.textDocument.completion.completionItem.snippetSupport = true

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
}

local lspconfig = require 'lspconfig'

-- Setup Languages that require no additional config (just use the LSP as-is)
local basic_languages = { "gopls", "pyright", "bashls", "cssls", "html", "jsonls", "svelte", "tailwindcss", "omnisharp",
  "clangd", "yamlls" }

for _, lsp in ipairs(basic_languages) do
  lspconfig[lsp].setup(options)
end

-- Languages that require additional config
local files = { "rust", "web", "lua", "harper" }

for _, file in ipairs(files) do
  local lang = require('languages/' .. file)
  lang.setup(options)
end
