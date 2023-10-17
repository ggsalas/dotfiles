local utils = require('telescope.utils')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local custom = require('ggsalas.telescope.telescopeCustomPickers')
local action_state = require('telescope.actions.state')

local M = {}

M.find_files_current_dir = function()
  local dir = utils.buffer_dir()

  builtin.find_files({
    prompt_title = string.format('Find files the Current Dir (%s)', dir),
    cwd = dir,
    disable_devicons = true
  })
end

M.grep_current_dir = function()
  local dir = utils.buffer_dir()
  
  builtin.live_grep({
    prompt_title = string.format('Grep in the Current Dir (%s)', dir),
    cwd = dir,
    disable_devicons = true,
    only_sort_text = true,
    use_regex = false,
    disable_coordinates = true,
  })
end

M.live_grep = function()
  builtin.live_grep({
    prompt_title = string.format('Grep in the Main Dir', utils.buffer_dir()),
    disable_devicons = true,
    only_sort_text = true,
    use_regex = false,
    disable_coordinates = true,
  })
end

M.grep_string = function()
  builtin.grep_string({
    disable_devicons = true,
    only_sort_text = true,
    use_regex = false,
    disable_coordinates = true,
  })
end

M.buffer_list = function()
  local width_padding = function()
    local cols = vim.o.columns
    -- print(vim.inspect(cols))

    if cols < 80 then
      return .9
    elseif cols < 150 then
      return 0.8
    else
      return 0.7
    end
  end

  local wp = width_padding()

  builtin.buffers {
    sort_lastused = true,
    show_all_buffers = true,
    disable_devicons = true,
    previewer = false,
    width_padding = wp,
    layout_strategy = 'vertical',
    layout_config = { width = wp, height = .55 },
    attach_mappings = function(prompt_bufnr, map)
      local delete_buf = function()
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        local multi_selections = current_picker:get_multi_selection()

        if next(multi_selections) == nil then
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.api.nvim_buf_delete(selection.bufnr, { force = true })
        else
          actions.close(prompt_bufnr)
          for _, selection in ipairs(multi_selections) do
            vim.api.nvim_buf_delete(selection.bufnr, { force = true })
          end
        end

      end

      map('i', '<C-x>', delete_buf)
      return true
    end
  }
end

M.delta_git_commits = function(opts)
  opts = opts or {}
  --[[ opts.previewer = delta ]]

  builtin.git_commits(opts)
end

M.delta_git_bcommits = function(opts)
  opts = opts or {}
  --[[ opts.previewer = delta ]]

  builtin.git_bcommits(opts)
end

M.delta_git_status = function(opts)
  opts = opts or {}
  --[[ opts.previewer = delta ]]

  builtin.git_status(opts)
end

M.search_dot_files = function()
  custom.dot_files({
    previewer = false,
  })
end

M.search_notes = function()
  builtin.find_files({ prompt_title = "Notes", cwd = "~/Google Drive/My Drive/Notas/", disable_devicons = true })
end

return M
