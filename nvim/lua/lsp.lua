local mason = require 'mason'
local mason_dap = require 'mason-nvim-dap'
local mason_lspconfig = require 'mason-lspconfig'
local utils = require 'utils'
local mini_indentscope = require "mini.indentscope"
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local trouble = require 'trouble'

local dap = require 'dap'
utils.map("n", "<leader>v", function()
  dap.set_exception_breakpoints()
  dap.continue()
end)

utils.map("n", "<leader>y", function()
  dap.step_over()
end)

utils.map("n", "<leader>i", function()
  dap.step_into()
end)

utils.map("n", "<leader>x", function()
  dap.step_out()
end)

utils.map("n", "<leader>z", function()
  dap.toggle_breakpoint()
end)

require("nvim-dap-virtual-text").setup()
local dapui = require 'dapui'
dapui.setup()

utils.map('n', "<leader>r", function()
  dapui.toggle()
end)

trouble.setup({
  win = {
    position = "left",
  }
})

vim.diagnostic.config({
  virtual_lines = true,
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
mason_dap.setup({
  ensure_installed = { "codelldb", "java-debug-adapter" },
  handlers = {},
})
mason_lspconfig.setup({
  automatic_installation = { exclude = { "harper_ls" } }
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

utils.map("n", "<C-T>", ":Trouble diagnostics<CR>")

vim.keymap.set("n", "<C-G>", function()
  local inc_rename = require 'inc_rename'
  inc_rename.setup({});
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

local on_attach = function(client, bufnr)
  local lsp_inlayhints = require 'lsp-inlayhints'
  lsp_inlayhints.setup()
  lsp_inlayhints.on_attach(client, bufnr)

  utils.map("n", "<C-x>", ":AerialToggle float<CR>")
  utils.map("nv", "<C-f>", ":lua vim.lsp.buf.code_action()<CR>")
  utils.map("nv", "<C-s>", ":lua vim.lsp.buf.hover()<CR>")
  utils.map("nv", "<C-d>", ":lua vim.lsp.buf.definition()<CR>")
  utils.map("nv", "<C-h>", ":lua require(\"telescope.builtin\").lsp_references()<CR>")
  utils.map("n", "<C-q>", ":lua vim.diagnostic.goto_prev()<CR>")
  utils.map("n", "<C-e>", ":lua vim.diagnostic.goto_next()<CR>")

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function()
      pcall(function()
        -- These have special, non-LSP formatters
        local blacklist = { "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "markdown", "css",
          "ps1" }

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
  "clangd", "yamlls", "gradle_ls", "marksman" }

for _, lsp in ipairs(basic_languages) do
  lspconfig[lsp].setup(options)
end

-- Languages that require additional config
local files = { "rust", "web", "lua", "harper", "powershell", "java" }

for _, file in ipairs(files) do
  local lang = require('languages/' .. file)
  lang.setup(options)
end
