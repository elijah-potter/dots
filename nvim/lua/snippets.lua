local utils = require 'utils'

local luasnip = require 'luasnip'
luasnip.config.setup({
  history = true,
  update_events = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
})

utils.map("i", "<C-L>", function ()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end);

utils.map("i", "<C-H>", function ()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end);

utils.map("n", "<leader><leader>s", ":source ~/.config/nvim/lua/snippets.lua<CR>")

local luasnip_snipmate_loader = require 'luasnip.loaders.from_snipmate'
luasnip_snipmate_loader.lazy_load({paths = {"./snippets"}})
