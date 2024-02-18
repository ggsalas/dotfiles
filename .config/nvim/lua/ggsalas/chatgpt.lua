local M = {}

function M.setup()
  require("chatgpt").setup()
end

vim.keymap.set({ 'n', 'v' }, '<leader>ie', '<cmd>ChatGPTEditWithInstructions<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ia', ':ChatGPTRun', { silent = false})
vim.keymap.set({ 'n', 'v' }, '<leader>if', '<cmd>ChatGPTRun fix_bugs<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ix', '<cmd>ChatGPTRun explain_code<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>is', '<cmd>ChatGPTRun summarize<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>it', '<cmd>ChatGPTRun add_tests<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ic', '<cmd>ChatGPTRun complete_code<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ig', '<cmd>ChatGPTRun grammar_correction<CR>', { silent = true })

vim.keymap.set({ 'n', 'i' }, '<c-]>', '<esc><cmd>ChatGPTCompleteCode<CR>', { silent = true })


return M
