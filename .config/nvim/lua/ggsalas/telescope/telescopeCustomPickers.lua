local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local conf = require('telescope.config').values

local get_local_script_path = function(filename)
  local current_script_path = debug.getinfo(1).source:sub(2)

  -- Find the last occurrence of the '/' character in the path
  local last_slash_index = current_script_path:match '.*()/'

  -- Extract the part of the path up to the last '/' character
  local current_script_dir = current_script_path:sub(1, last_slash_index - 1)

  return current_script_dir .. '/' .. filename
end

local M = {}

M.dot_files = function(opts)
  local job_command = vim.tbl_flatten { 'sh', get_local_script_path 'getDotFiles.sh' }
  local finder = finders.new_oneshot_job(job_command)
  local previewer = conf.file_previewer(opts)
  local sorter = conf.file_sorter(opts)

  pickers.new(opts, {
    prompt_title = 'DotFiles',
    finder = finder,
    previewer = previewer,
    sorter = sorter,
  }):find()
end

return M
