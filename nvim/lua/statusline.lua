require('lualine').setup({
    options = {
        theme = 'auto',
        component_separators = { left = ' |', right = '| '},
        section_separators = { left = '█ ', right = ' █'},
    },
    extensions = { 'nvim-tree', 'quickfix', 'aerial' },
    tabline = {
        lualine_a = {'buffers'},
    }
})
