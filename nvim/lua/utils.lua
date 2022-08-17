local M = {}

function M.map(modes, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    for i = 1, string.len(modes) do
    	vim.api.nvim_set_keymap(string.sub(modes, i, i), lhs, rhs, options)
    end
end

function M.bmap(modes, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    for i = 1, string.len(modes) do
    	vim.api.nvim_buf_set_keymap(string.sub(modes, i, i), lhs, rhs, options)
    end
end

return M
