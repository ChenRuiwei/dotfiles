local wk = require("which-key")

wk.add({
  {
    mode = { "n", "v" },
    { "g>", "<C-v>0<S-i>> <esc>", desc = "blockquote" },
  },
})
