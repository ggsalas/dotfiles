-- local tree_cb = require'nvim-tree.config'.nvim_tree_callback

-- vim.g.nvim_tree_bindings = {
--   { key = "l", cb = tree_cb("edit") },
--   { key = "h", cb = tree_cb("preview") },
-- }

require'nvim-tree'.setup {
  hijack_directories = {
    enable = false,
  },
  view = {
    mappings = {
      list = {
          { key = {"<CR>", "o", "<2-LeftMouse>", "l"}, action = "edit" },
      },
    },
  },
}
