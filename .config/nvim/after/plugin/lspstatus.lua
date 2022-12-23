-- Lsp-status setup (status line)
local lsp_status = require 'lsp-status'
lsp_status.register_progress()

lsp_status.config {
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ['start'] = { character = 0, line = vim.fn.byte2line(symbol.valueRange[1]) },
        ['end'] = { character = 0, line = vim.fn.byte2line(symbol.valueRange[2]) },
      }

      return require('lsp-status.util').in_range(cursor_pos, value_range)
    end
  end,
}

lsp_status.config {
  indicator_errors = '✖',
  indicator_warnings = '',
  indicator_info = 'ℹ',
  indicator_hint = '',
  indicator_ok = ' ',
  status_symbol = ' ',
}

vim.api.nvim_exec(
  [[
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

set statusline =\ %f\ %m
set statusline +=\ %*%=\ %*
set statusline +=\ %*%=\ %*%{LspStatus()}\ %*
]],
  true
)
