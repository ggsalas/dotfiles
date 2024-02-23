-- nvim_command- Set options for markdown files
local break_lines = vim.api.nvim_create_augroup('break_lines', { clear = true })
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.md"},
  callback = function()
    vim.o.wrap = true
    vim.o.conceallevel = 2
  end,
  group = break_lines
})

-- Autosave
local markdown_autosave = vim.api.nvim_create_augroup('markdown_autosave', { clear = true })
vim.api.nvim_create_autocmd({"BufLeave", "BufWinLeave", "FocusLost"}, {
  pattern = {"*.md"},
  callback = function() vim.api.nvim_command("w") end,
  group = markdown_autosave
})

