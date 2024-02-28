-- Require 2 command line apps:
--   * `brew install jq`
--   * `brew install tidy-html5`
--------------------------------

return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local rest = require('rest-nvim')
    local builtin = require('telescope.builtin')

    rest.setup({
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = true,
    })

    vim.keymap.set('n', '<leader>r]', rest.run)
    vim.keymap.set('n', '<leader>rp', function() rest.run(true) end)

    vim.api.nvim_create_user_command('QuickFix', ':copen', {})

    local search_rest = function()
      builtin.find_files({
        prompt_title = "Rest queries",
        cwd = "~/Google Drive/My Drive/.config-private/rest-nvim/",
        disable_devicons = true,
      })
    end

    vim.api.nvim_create_user_command('RestFind', search_rest, {})
    vim.api.nvim_create_user_command('RestFolder', "e ~/Google Drive/My\\ Drive/.config-private/rest-nvim/" , {})
  end
}
