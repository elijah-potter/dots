require 'nightfox'.setup({
	options = {
		dim_inactive = true,
		styles = {
			comments = "italic",
			functions = "bold",
			types = "italic,bold"
		}
	}
})

vim.cmd('colorscheme nightfox')
