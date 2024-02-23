vim.cmd [[
function! GGsalasFoldStyle()
    let line = getline(v:foldstart)

    let nucolwidth = &foldcolumn + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart . ' lines  '

    " expand tabs into spaces
    let chunks = split(line, "\t", 1)
    let line = join(map(chunks[:-2], 'v:val . repeat(" ", &tabstop - strwidth(v:val) % &tabstop)'), '') . chunks[-1]

    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount)) . ' '
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)

    return line . repeat('.', fillcharcount) . ' ' . foldedlinecount
endfunction
]]

vim.api.nvim_create_user_command('FoldSyntax', function() 
  vim.opt.foldmethod = 'syntax' 
  vim.opt.foldlevel = 0
end, {})
vim.api.nvim_create_user_command('FoldExpr', function() 
  vim.opt.foldmethod = 'expr' 
  vim.opt.foldlevel = 0
end, {})
vim.api.nvim_create_user_command('FoldManual', function() 
  vim.opt.foldmethod = 'manual' 
  vim.opt.foldlevel = 0
end, {})
vim.api.nvim_create_user_command('FoldDiff', function() 
  vim.opt.foldmethod = 'diff' 
  vim.opt.foldlevel = 0
end, {})
-- vim.api.nvim_create_user_command('Fold', function(opts) vim.opt.foldmethod = opts.nargs end, { nargs = 1 })


-- SEEMS I'M NOT USING DIFFERENT CONFIGS PER FILE TYPE
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldtext = 'GGsalasFoldStyle()'
vim.opt.foldlevel = 99

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'markdown' },
--   callback = function()
--     vim.opt.foldmethod = 'expr'
--     vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--     vim.opt.foldtext = 'GGsalasFoldStyle()'
--     vim.opt.foldlevel = 99
--   end,
-- })
--
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json', 'lua', 'html' },
--   callback = function()
--     vim.opt.foldmethod = 'expr'
--     vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--     vim.opt.foldtext = 'GGsalasFoldStyle()'
--     vim.opt.foldlevel = 2
--   end,
-- })

-- Workaround to fix telescope bug
-- https://github.com/nvim-telescope/telescope.nvim/issues/559#issuecomment-1074076011
-- vim.api.nvim_create_autocmd('BufRead', {
--   callback = function()
--     vim.api.nvim_create_autocmd('BufWinEnter', {
--       once = true,
--       command = 'normal! zx',
--     })
--   end,
-- })
