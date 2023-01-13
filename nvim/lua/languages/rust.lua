local rt = require 'rust-tools'

local M = {}

function M.setup(options)
  rt.setup({
    inlay_hints = {
      show_parameter_hints = false
    },
    server = {
      standalone = false,
      on_attach = options.on_attach,
      capabilities = options.capabilities,
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            allFeatures = true,
            overrideCommand = {
                'cargo', 'clippy', '--workspace', '--message-format=json',
                '--all-targets', '--all-features'
            }
          },
        }
      },
    }
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = function()
      vim.lsp.buf.format({ timeout_ms = 200 })
    end,
  })
end

return M;
