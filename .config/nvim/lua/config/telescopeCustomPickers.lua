local finders = require('telescope.finders')
local pickers = require('telescope.pickers')

local conf = require('telescope.config').values

local M = {}

M.dot_files = function(opts)
  -- TODO: remove /Users/ggsalas in some way (from sh path or from inline vim.tbl_flatten)
  -- local finder = vim.tbl_flatten({
  --     'git', '--git-dir', '/Users/ggsalas/.dotfiles/', 'ls-files', '--full-name', '|', 'sed', 's,^,$HOME/,'
  --   })

  pickers.new(opts, {
    prompt_title = '< DotFiles >',
    finder = finders.new_oneshot_job(vim.tbl_flatten({ 'sh', '/Users/ggsalas/.config/nvim/lua/config/getDotFiles.sh' })),
    -- finder = finders.new_oneshot_job(finder),

    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
  }):find()
end

return M
