local help_mode = vim.api.nvim_create_augroup('help_mode', { clear = true })
local opts = { noremap = true, silent = true }

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<cr>', '<c-]>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', '<bs>', '<c-T>', opts)
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<cr>', opts)
  end,
  pattern = { 'help' },
  group = help_mode,
})
