vim.keymap.set('n', '<leader>-', ':NvimTreeFindFile <cr>')
vim.keymap.set('n', '<leader>_', ':NvimTreeToggle <cr>')

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
end

require("nvim-tree").setup({
  on_attach = on_attach,
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
  },
})
