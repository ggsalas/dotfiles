local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

-- Global remapping
-------------------
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

require('telescope').load_extension('fzy_native')

local M = {}

M.search_config = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Config >",
        cwd = "$HOME/.config/",
    })
end

M.search_notes = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Notes >",
        cwd = "$HOME/Google Drive/My Drive/Notas",
    })
end


M.grep_in_folder = function(dir)
    require("telescope.builtin").live_grep({
        prompt_title = string.format('< Live Grep on %s >', dir),
        search_dirs={dir}
    })
end

M.buffer_list = function()
  require'telescope.builtin'.buffers{
    sort_lastused = true,
    show_all_buffers = true,
    -- previewer = false,
    -- shorten_path = false,
    attach_mappings = function(prompt_bufnr, map)
      local delete_buf = function()
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        local multi_selections = current_picker:get_multi_selection()

        if next(multi_selections) == nil then
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.api.nvim_buf_delete(selection.bufnr, {force = true})
        else
          actions.close(prompt_bufnr)
          for _, selection in ipairs(multi_selections) do
            vim.api.nvim_buf_delete(selection.bufnr, {force = true})
          end
        end

      end

      map('i', '<C-x>', delete_buf)
      return true
    end
  }
end

return M
