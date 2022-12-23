require('nvim-tree').setup {
  hijack_directories = {
    enable = false,
  },
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
      },
    },
  },
  view = {
    width = 50,
    mappings = {
      list = {
        { key = { '<CR>', 'o', '<2-LeftMouse>', 'l' }, action = 'edit' },
      },
    },
  },
}

vim.keymap.set('n', '<leader>-', ':NvimTreeFindFile <cr>')
vim.keymap.set('n', '<leader>_', ':NvimTreeToggle <cr>')
