local aerial = require 'aerial'
local utils = require 'utils'
local map = utils.map

aerial.setup({
        default_direction = "float",
        float = {
                borer = "rounded",
                relative = "editor"
        },
        close_on_select = true,
        nerd_font = "auto"
})

map("n", "<C-X>", ":AerialToggle<CR>")
