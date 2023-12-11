-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- -- different indent width
-- vim.api.nvim_create_autocmd("FileType", {
--   -- group = augroup("indent_width"),
--   pattern = { "lua", "tex" },
--   callback = function()
--     vim.opt.tabstop = 2
--     vim.opt.shiftwidth = 2
--     vim.opt.softtabstop = 2
--   end,
-- })

-- Disable auto comment when press 'o' or 'Enter' on new lines
vim.cmd([[autocmd BufNewFile,BufRead * setlocal formatoptions-=cro]])

-- Set verilog detection to override detection of 'vhda/verilog_systemverilog.vim'
vim.cmd([[
  au! filetypedetect BufNewFile,BufRead *.v setfiletype verilog
  " au! filetypedetect * *.v
  " au filetypedetect BufNewFile,BufRead *.v setfiletype verilog
]])
