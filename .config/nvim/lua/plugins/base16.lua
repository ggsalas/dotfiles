return {
  "RRethy/nvim-base16",
  dependencies = "brenoprata10/nvim-highlight-colors",
  config = function()
    -- Set colorscheme
    vim.o.termguicolors = true
    vim.cmd [[colorscheme base16-solarized-light]]

    -- Visual options
    vim.o.cursorline = true
  end
}
