-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  }

  -- debug
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} }
  use {
    "microsoft/vscode-js-debug",
    opt = true,
    run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" 
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-git',
    },
  }

  -- Typescript
  use 'jose-elias-alvarez/typescript.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Comments
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = false })
    end,
  }

  use({ -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable 'make' == 1,
  }

  use { 'nvim-telescope/telescope-ui-select.nvim' }

  -- File navigators
  use 'justinmk/vim-dirvish'
  use 'nvim-tree/nvim-tree.lua'
  use 'pbrisbin/vim-mkdir' -- create non existing dirextories

  -- Color
  use 'RRethy/nvim-base16'

  -- StatusLine
  use 'nvim-lua/lsp-status.nvim'

  -- Undo manage
  use 'mbbill/undotree'

  -- Nice drawings tool
  use 'jbyuki/venn.nvim'

  -- Search/Replace
  use 'windwp/nvim-spectre'

  -- Show colors as background
  use 'brenoprata10/nvim-highlight-colors'

  -- Surrounds
  use {
    'kylechui/nvim-surround',
    tag = '*', -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require('nvim-surround').setup {}
    end,
  }

  -- Coercion (camelCase (crc), snake_case (crs), UPPER_CASE (cru), dash-case (cr-)...) and Substitutions
  use 'tpope/vim-abolish'

  -- simple presentation tool
  use 'sotte/presenting.vim'

  -- motions
  use { 'ggandor/leap.nvim' }

  -- Database
  use {
    "tpope/vim-dadbod",
    opt = true,
    requires = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      require("ggsalas.dadbod").setup()
    end,
    cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
  }

  -- IA
  -- use { 'github/copilot.vim' }
  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("ggsalas.chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

  -- Sourcegraph IA (Cody)
  use { 'sourcegraph/sg.nvim', run = 'nvim -l build/init.lua' }

  -- html template system
  use {'mustache/vim-mustache-handlebars'}

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
