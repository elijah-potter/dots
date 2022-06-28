require('lualine').setup({
    options = {
        theme = 'auto'
    },
    extensions = { 'nvim-tree', 'quickfix' },
    tabline = {
        lualine_a = {'buffers'},
    }
})
