return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set('n', '<Leader>u', ':UndotreeToggle<CR>')

    -- Undo persistent after close file
    vim.o.undofile = true
    vim.o.undodir = os.getenv("HOME") .. "/.vimUndoFiles"
    vim.o.undolevels = 5000
  end
}
