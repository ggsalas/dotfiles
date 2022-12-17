" LSP mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent>gi <cmd>lua vim.lsp.buf.implementation({ trim_text = false })<CR>
nnoremap <silent>K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent>[l <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent>]l <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent>ga <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>k <cmd>lua vim.diagnostic.open_float()<CR>
command! -bang Format :lua vim.lsp.buf.formatting_sync(nil, 10000)<CR>

sign define LspDiagnosticsSignError text=✖
sign define LspDiagnosticsSignWarning text=
sign define LspDiagnosticsSignInformation text=ℹ 
sign define LspDiagnosticsSignHint text= 

set shortmess+=c
