local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local custom = require('ggsalas.telescope.telescopeCustomPickers')
local action_state = require('telescope.actions.state')

-- helpers
----------
function Get_buffer_dir(dir)
  local filetype = vim.api.nvim_exec('echo &filetype', true)
  local local_dir = vim.fn.expand('%:h');
  local pwd = vim.api.nvim_exec('echo getcwd()', true)
  local search_dir = {}
  -- print(vim.inspect(pwd))

  if dir == nil then
    if filetype == 'dirvish' then
      table.insert(search_dir, local_dir)
    else
      table.insert(search_dir, pwd)
    end
  else
    table.insert(search_dir, dir)
  end

  return search_dir
end

local M = {}
-- Same as builtin.find_files but finds on a default dir
M.find_files = function(dir)
  local cwd = Get_buffer_dir(dir)[1]

  builtin.find_files({
    prompt_title = string.format('Search files in %s', vim.fn.pathshorten(cwd)),
    cwd = cwd,
    disable_devicons = true
  })
end

-- Same as builtin.grep_string but finds on a default dir
M.grep_string = function(search, dir)
  local search_dir = Get_buffer_dir(dir)

  builtin.grep_string({
    prompt_title = string.format('Grep of "%s" in %s', search, vim.fn.pathshorten(search_dir[1])),
    search = search,
    search_dirs = search_dir,
    disable_devicons = true,
    only_sort_text = true,
    use_regex = false,
    layout_strategy = "vertical",
    layout_config = { preview_height = 0.65 },
    path_display = "truncate",
    -- default_text = search -- currently broken https://github.com/nvim-telescope/telescope.nvim/issues/808
  })
end

-- Seems not working.. review later:
-- https://github.com/tjdevries/config_manager/blob/26dc8d25c2c16680c69872712e7e190dc7432c75/xdg_config/nvim/lua/tj/telescope/init.lua
M.grep_last_search = function(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.path_display = "shorten"
  opts.word_match = "-w"
  opts.search = register
  -- opts.layout_strategy = "vertical"

  require("telescope.builtin").grep_string(opts)
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

-- // waiting for https://github.com/nvim-telescope/telescope.nvim/pull/613
function M.file_browser()
  local opts

  opts = {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    layout_config = {
      prompt_position = "top",
    },
    disable_devicons = true,
    cwd = vim.fn.expand('%:p:h'),

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        current_picker.cwd = new_cwd
        current_picker:refresh(opts.new_finder(new_cwd), { reset_prompt = true })
      end

      map('n', 'l', actions.select_default)

      map('i', '<c-l>', actions.select_default)

      map("i", "-", function()
        modify_cwd(vim.fn.expand "~")
      end)

      return true
    end
  }

  require("telescope.builtin").file_browser(opts)
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
