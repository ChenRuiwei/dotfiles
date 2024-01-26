local helpers = require("personal.luasnip-helper-funcs")
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Return snippet tables
return {
  -- Fenced block of code
  s(
    { trig = "cc", snippetType = "autosnippet" },
    fmta(
      [[
        ```<>
        <>
        ```
      ]],
      {
        i(1),
        d(2, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- PYTHON CODE BLOCK
  s(
    { trig = "baa", snippetType = "autosnippet" },
    fmt(
      [[
        ```bash
        {}
        ```
        ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- PYTHON CODE BLOCK
  s(
    { trig = "pyy", snippetType = "autosnippet" },
    fmt(
      [[
        ```python
        {}
        ```
        ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- RUST CODE BLOCK
  s(
    { trig = "ruu", snippetType = "autosnippet" },
    fmt(
      [[
        ```rust
        {}
        ```
        ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
}
