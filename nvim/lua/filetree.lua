local map = require 'utils'.map

require 'nvim-tree'.setup({
	view = {
		adaptive_size = true,
		side = "right",
		mappings = {
			list = {
				{ key = "H", action = "none" },
				{ key = "L", action = "none" }
			}
		}
	}
})

map("n", "<C-n>", ":NvimTreeToggle<CR>")

