local api = vim.api;
local strings = require "plenary.strings"

local M = {}

function M.map(modes, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  for i = 1, string.len(modes) do
    vim.keymap.set(string.sub(modes, i, i), lhs, rhs, options)
  end
end

function M.pretty_table(table)
  local stringified = {};

  for i,v in pairs(table) do
    stringified[tostring(i)] = tostring(v)
  end

  local longest_left = 0
  local longest_right = 0

  for i,v in pairs(stringified) do
    if #i > longest_left then
      longest_left = #i
    end

    if #v > longest_right then
       longest_right = #v
    end

  end

  local lines = {}
  local line_count = 0

  for i,v in pairs(stringified) do
    line_count = line_count + 1
    lines[line_count] = " " .. strings.align_str(i, longest_left, false) .. " │ " .. strings.align_str(v, longest_right, true) .. " "
  end

  return {
    lines = lines,
    rows = line_count,
    cols = longest_left + longest_right + 5,
  }
end

function M.contains(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end

return M
