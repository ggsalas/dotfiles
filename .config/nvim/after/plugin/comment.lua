require('nvim-treesitter.configs').setup {
  enable_autocmd = false,
}

require('ts_context_commentstring').setup {} 
vim.g.skip_ts_context_commentstring_module = true

-- Enable Comment.nvim
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

