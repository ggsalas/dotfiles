-- config leap, a better way to do cursor jump

require 'leap'

vim.keymap.set('n', 'f', '<Plug>(leap-forward-to)')
vim.keymap.set('n', 't', '<Plug>(leap-forward-till)')
vim.keymap.set('n', 'F', '<Plug>(leap-backward-to)')
vim.keymap.set('n', 'T', '<Plug>(leap-backward-ill)')

vim.keymap.set('n', 'gs', '<Plug>(leap-cross-window)')
