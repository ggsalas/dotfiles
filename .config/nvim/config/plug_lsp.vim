" augroup lua_fmt
"   autocmd!
"   au BufWritePre *.js,*.jsx,*.ts,*.tsx,*.json,*.yaml,*.css,*.scss,*.html,*.lua,*.vim :lua vim.lsp.buf.formatting_sync(nil, 1000)
" augroup END

" LSP mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> [l <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]l <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>k <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
command! -bang Format :lua vim.lsp.buf.formatting_sync({}, 1000)<CR>

sign define LspDiagnosticsSignError text=✖
sign define LspDiagnosticsSignWarning text=
sign define LspDiagnosticsSignInformation text=ℹ 
sign define LspDiagnosticsSignHint text= 

set shortmess+=c

" nvim-compe
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:true
let g:compe.min_length = 2
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.omni = v:false
let g:compe.source.vsnip = v:false
let g:compe.source.emoji = v:false
let g:compe.source.path = { 'priority': 1100 }
let g:compe.source.nvim_lsp = { 'priority': 1000 }
let g:compe.source.buffer = { 'priority': 500 }
let g:compe.source.spell = { 'priority': 400 }
let g:compe.source.calc = { 'priority': 100 }
let g:compe.source.nvim_lua = { 'priority': 800 }

lua <<EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  else
    return t "<Tab>"
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
