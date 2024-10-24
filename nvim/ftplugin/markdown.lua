local wk = require("which-key")

wk.add({
  { "<leader>p", group = "preview" },
  { "<leader>pp", "<Plug>MarkdownPreviewToggle", desc = "Toggle preview" },
})
