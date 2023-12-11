local helpers = require("personal.luasnip-helper-funcs")
local get_visual = helpers.get_visual

return {
  -- MATH ROMAN i.e. \mathrm
  s(
    { trig = "([^%a])rmm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\mathrm{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
}
