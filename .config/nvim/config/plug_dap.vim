"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-dap is a debug adapter protocol client, or "debugger", or "debug-frontend"
" this config needs to be outside "Plug"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.config/nvim/plugged/vscode-node-debug2/out/src/nodeDebug.js'},
}
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='', numhl=''})
EOF

nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dk :lua require'dap'.step_out()<CR>
nnoremap <leader>dl :lua require'dap'.step_into()<CR>
nnoremap <leader>dj :lua require'dap'.step_over()<CR>

nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>d_ :lua require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
nnoremap <leader>di :lua require'dap.ui.variables'.hover(function () return vim.fn.expand("<cexpr>") end)<CR>
vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>d? :lua require'dap.ui.variables'.scopes()<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>

nnoremap <leader>da :lua require'debugHelper'.attach()<CR>

" jank/vim-test and mfussenegger/nvim-dap
nnoremap <leader>dd :TestNearest -strategy=jest<CR>
function! JestStrategy(cmd)
    echo 'It works! Command for running tests: ' . a:cmd
  let testName = 'change the status on select'
  " let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
  let fileName = "src/pages/Queue/Queue.test.tsx"
  " let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
  call luaeval("require'debugHelper'.debugJest([[" . testName . "]], [[" . fileName . "]])")
endfunction      
let g:test#custom_strategies = {'jest': function('JestStrategy')}
