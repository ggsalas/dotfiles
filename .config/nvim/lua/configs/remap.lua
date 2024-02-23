-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Reload vim config
vim.keymap.set('n', '<leader>.', ":lua package.loaded.config = nil <cr>:source ~/.config/nvim/init.lua <cr>:echo 'Neovim Config Reloaded' <cr>")

-- Window movments
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set('t', '<c-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<c-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<c-h>', '<c-\\><c-n><c-w>h')
vim.keymap.set('t', '<c-l>', '<c-\\><c-n><c-w>l')

-- tabs
vim.keymap.set('n', '<leader>ta', ':tabnew<cr>')

-- window resize
vim.keymap.set('n', '<up>', ':resize -2<cr>')
vim.keymap.set('n', '<down>', ':resize +2<cr>')
vim.keymap.set('n', '<left>', ':vertical resize -2<cr>')
vim.keymap.set('n', '<right>', ':vertical resize +2<cr>')

-- center scroll
vim.keymap.set('n', '<C-u>', '<S-M><C-U>zz')
vim.keymap.set('n', '<C-d>', '<S-M><C-D>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

-- Center moovments
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
-- ...or global copy replacing default
vim.keymap.set({ 'n', 'v' }, 'y', '"+y')
vim.keymap.set('n', 'yy', '<S-V>"+y<esc>')
vim.keymap.set('i', '<C-r>r', '<C-r>+')
vim.keymap.set('c', '<C-r>r', '<C-r>+')

-- Do not copy text I'm replacing with paste
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Expand path with %%
vim.keymap.set('c', '%%', "<C-R>=fnameescape(expand('%:h')) . '/' <CR>")

-- Go to previous selection
vim.keymap.set('n', 'gp', '`[v`]')

-- Move selection
vim.keymap.set('v', 'J', ":m '>+1<cr>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<cr>gv=gv")

-- Replace word under cursor or selection
vim.keymap.set('n', '<Leader>r', ':%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>')
vim.keymap.set('v', '<Leader>r', 'y :%s/<C-r>"/<C-r><C-w>/gc<Left><Left><Left>')

-- Esc remove search highlight
vim.keymap.set('n', '<Esc>', ':nohlsearch<cr>', { silent = true })

-- Wildmenu navigation
-- vim.keymap.set('c', '<Down>',  '<Right>')
-- vim.keymap.set('c', '<Up>',  '<Left>')
-- vim.keymap.set('c', '<Right>',  '<Down>')
-- vim.keymap.set('c', '<Left>',  '<Up>')

-- Node
vim.keymap.set('n', '<Leader>no', ':!node % <CR>', { silent = true })

