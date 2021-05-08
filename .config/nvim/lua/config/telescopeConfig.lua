local actions = require('telescope.actions')

-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_to_qflist,
        ["<esc>"] = actions.close
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

-- require("telescope").load_extension("git_worktree")
require('telescope').load_extension('fzy_native')

local M = {}

M.search_config = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Config >",
        cwd = "$HOME/.config/",
    })
end

return M
