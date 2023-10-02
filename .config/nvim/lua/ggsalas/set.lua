-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.o.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- diff split vertical
vim.o.diffopt = 'vertical'

-- Switch files without need to save
vim.o.hidden = true

-- Not touch the borders of the screen on scroll
vim.o.scrolloff = 1

-- Tabs config
vim.o.expandtab = true -- spaces not tabs
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.list = true
vim.o.listchars = 'tab:--' -- alert if I use tabs!! : retab to fix

-- Dash should not split a word
vim.opt.iskeyword:append '-'

-- Mainain current window at the top, split to the bottom
vim.o.splitbelow = true

-- Not break lines
vim.o.wrap = false

-- vim.opt.filetype.plugin = 'on'
-- vim.cmd [[filetype plugin on]]

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- automatically rebalance windows on vim resize
vim.api.nvim_create_autocmd('VimResized', {
  command = 'wincmd =',
  pattern = '*',
})
