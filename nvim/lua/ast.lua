local aerial = require 'aerial'
local utils = require 'utils'
local map = utils.map

aerial.setup({
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

map("n", "<C-X>", ":AerialToggle<CR>")
