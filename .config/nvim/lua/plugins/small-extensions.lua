return {
  -- Show colors as background
  ----------------------------
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      vim.o.termguicolors = true
    end
  },

  -- Surround
  -----------
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },

  -- Detect tabstop and shiftwidth automatically
  ----------------------------------------------
  {
    "tpope/vim-sleuth"
  },

  -- better vim motions
  ---------------------
  {
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set('n', 'f', '<Plug>(leap-forward-to)')
      vim.keymap.set('n', 't', '<Plug>(leap-forward-till)')
      vim.keymap.set('n', 'F', '<Plug>(leap-backward-to)')
      vim.keymap.set('n', 'T', '<Plug>(leap-backward-ill)')

      vim.keymap.set('n', 'gs', '<Plug>(leap-cross-window)')
    end
  },

  -- html template system
  -----------------------
  {
    "mustache/vim-mustache-handlebars"
  },

}
