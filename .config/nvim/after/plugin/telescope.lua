local actions = require 'telescope.actions'

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = '  ',
    selection_caret = '❯ ',
    disable_devicons = true, -- seems is not detected as default, added on each function
    layout_strategy = 'vertical',
    layout_config = { horizontal = { preview_width = 0.3 }, vertical = { preview_height = 0.6 } },
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<esc>'] = actions.close,
        ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
        ['<cr>'] = actions.select_default + actions.center,
      },
      n = {
        ['<C-w>'] = actions.send_selected_to_qflist,
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
      },
    },
  },
  pickers = {
    lsp_references = {
      show_line = false,
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {},
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Enable handling for code actions
require('telescope').load_extension 'ui-select'

-- Mappings

-- files & grep
vim.keymap.set('n', '<leader>l', require('telescope.builtin').diagnostics, { desc = 'Search [L]inter' })
vim.keymap.set('n', '<leader>j', require('ggsalas.telescope').buffer_list)
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>s', require('ggsalas.telescope').live_grep, { desc = 'Grep in the Main Dir' })
vim.keymap.set('n', '<leader>df', require('ggsalas.telescope').find_files_current_dir)
vim.keymap.set('n', '<leader>ds', require('ggsalas.telescope').grep_current_dir, { desc = 'Grep in the Current Dir' })
vim.keymap.set('n', '<leader>*', require('ggsalas.telescope').grep_string, { desc = 'Grep word under cursor' })

-- git mappingrequire'telescope.themes'.get_dropdown()s
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_stash)
vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches)
vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_bcommits)
vim.keymap.set('n', '<leader>gC', require('telescope.builtin').git_commits)
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_status)

-- vim
vim.keymap.set('n', '<leader>gh', function()
  require('telescope.builtin').help_tags { prompt_title = 'Search Vim Help' }
end)
vim.keymap.set('n', '<leader>gn', function()
  require('telescope.builtin').man_pages { prompt_title = 'Search Man Pages' }
end)
vim.keymap.set('n', '<leader>gm', function()
  require('telescope.builtin').marks { prompt_title = 'Search Marks' }
end)
vim.keymap.set('n', '<leader>gq', function()
  require('telescope.builtin').quickfix { prompt_title = 'Search QuickFix list' }
end)
vim.keymap.set('n', '<leader>z', function()
  require('telescope.builtin').spell_suggest(require('telescope.themes').get_dropdown { prompt_title = 'Spell Suggestions' })
end)
vim.keymap.set('n', '<leader>gk', require('telescope.builtin').keymaps)
vim.keymap.set('n', '<leader>do', require('ggsalas.telescope').search_dot_files)

vim.api.nvim_create_user_command('Notes', require('ggsalas.telescope').search_notes, {})
