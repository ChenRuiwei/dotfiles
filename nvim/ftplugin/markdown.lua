local wk = require("which-key")

wk.register({
  ["<leader>p"] = {
    name = "+preview",
    p = { "<Plug>MarkdownPreviewToggle", "Toggle preview" },
  },
})
