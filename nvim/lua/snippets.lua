local utils = require 'utils'

local luasnip = require 'luasnip'
local s = luasnip.snippet
local f = luasnip.function_node
local i = luasnip.insert_node
local t = luasnip.text_node

luasnip.config.setup({
  history = true,
  update_events = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
})

luasnip.add_snippets('markdown', {
  s({
    trig = 'date',
    dscr = 'Insert the current UTC date in RFC 1123 format',
  }, {
    f(function()
      return os.date('!%a, %d %b %Y %H:%M:%S GMT')
    end, {}),
  }),
  s({
    trig = 'front',
    dscr = 'Insert blog post frontmatter',
  }, {
    t({
      '---',
      '"description": "',
    }),
    i(1, 'Short description'),
    t({
      '"',
      '"pubDate": "',
    }),
    f(function()
      return os.date('!%a, %d %b %Y %H:%M:%S GMT')
    end, {}),
    t({
      '"',
      '"keywords":',
      '  - "',
    }),
    i(2, 'keyword'),
    t({
      '"',
      '"image": null',
      '"featured": false',
      '"draft": true',
      '---',
      '',
    }),
    i(0),
  }),
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
