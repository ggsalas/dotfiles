return {
  -- create non existing directories
  ----------------------------------
  {
    "pbrisbin/vim-mkdir"
  },

  -- File tree
  ------------
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
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
    end
  },

  -- In-buffer navigation
  -----------------------
  {
    'justinmk/vim-dirvish',
    config = function()
      -- Go to pwd
      vim.keymap.set('n', '_', ':Dirvish .<CR>')

      -- folders first, then files
      vim.g.dirvish_mode = [[:sort ,^.*[\/],]]

      -- set mapoigs for dirvish buffer only
      local dirvish_mode = vim.api.nvim_create_augroup('dirvish_mode', { clear = true })
      local opts = { noremap = true, silent = true }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          vim.api.nvim_buf_set_keymap(0, 'n', 'o', ":call dirvish#open('edit', 0)<CR>", opts)
        end,
        pattern = { 'dirvish' },
        group = dirvish_mode,
      })

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
          vim.api.nvim_buf_set_keymap(0, 'n', 'm',
            ":!mv <C-R>=expand('<cfile>:p', 0)<CR> <C-R>=expand('<cfile>:p', 0)<CR>", { noremap = true, silent = false })
        end,
        pattern = { 'dirvish' },
        group = dirvish_mode,
      })
    end
  }
}
