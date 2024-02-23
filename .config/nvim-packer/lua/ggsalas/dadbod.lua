-- Manage relational databases 
---------------------------------------------------------------------------------
local M = {}

vim.keymap.set('n', '<leader>b', ':DBUIToggle<CR>')

local function db_completion()
  require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
end

function M.setup()
  vim.g.db_ui_debug = false

  vim.g.db_ui_execute_on_save = false

  vim.g.db_ui_save_location = vim.fn.stdpath "config" .. require("plenary.path").path.sep .. "db_ui"

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
    },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
      "mysql",
      "plsql",
    },
    callback = function()
      vim.schedule(db_completion)
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dbui' },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<Plug>(DBUI_GotoFirstSibling)', {})
        vim.api.nvim_buf_set_keymap(0, 'n', 'J', '<Plug>(DBUI_GotoLastSibling)', {})

        -- restore original mappings
        vim.api.nvim_buf_set_keymap(0, 'n', '<C-j>', ':wincmd j<CR>', {})
        vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', ':wincmd k<CR>', {})
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'sql' },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'v', '<leader>]', '<Plug>(DBUI_ExecuteQuery)', {})
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>]', '<Plug>(DBUI_ExecuteQuery)', {})
    end,
  })
end

return M
