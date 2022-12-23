-- Go to pwd
vim.keymap.set('n', '_', ':Dirvish .<CR>')

-- folders first, then files
vim.g.dirvish_mode = [[:sort ,^.*[\/],]]

-- set mapoigs for dirvish buffer only
local dirvish_mode = vim.api.nvim_create_augroup('dirvish_mode', { clear = true })
local opts = { noremap = true, silent = true }

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'l', ":call dirvish#open('edit', 0)<CR>", opts)
  end,
  pattern = { 'dirvish' },
  group = dirvish_mode,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'h', '<Plug>(dirvish_up)', opts)
  end,
  pattern = { 'dirvish' },
  group = dirvish_mode,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'm', ":!mv <C-R>=expand('<cfile>:p', 0)<CR> <C-R>=expand('<cfile>:p', 0)<CR>", { noremap = true, silent = false })
  end,
  pattern = { 'dirvish' },
  group = dirvish_mode,
})
