-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme base16-solarized-light]]

-- Visual options
vim.o.cursorline = true

-- set colors and change automatically with the theme
vim.api.nvim_exec([[
function! s:changeColorsBasedOnMacos() abort
  let hasDarkmode = system('dark-mode status')

  if (hasDarkmode=~'on')
    call ColorDark()
  else 
    call ColorLight()
  endif
endfunction

function! ColorLight()
  set background=light

  " solarized light
  let g:base16_00 = '#fdf6e3'
  let g:base16_01 = '#eee8d5' 
  let g:base16_02 = '#93a1a1' 
  let g:base16_03 = '#839496'
  let g:base16_04 = '#657b83' 
  let g:base16_05 = '#586e75' 
  let g:base16_06 = '#073642' 
  let g:base16_07 = '#002b36'
  let g:base16_08 = '#dc322f' 
  let g:base16_09 = '#cb4b16' 
  let g:base16_0A = '#b58900' 
  let g:base16_0B = '#859900'
  let g:base16_0C = '#2aa198' 
  let g:base16_0D = '#268bd2' 
  let g:base16_0E = '#6c71c4' 
  let g:base16_0F = '#d33682'

  call Base16_customize()
endfunction

function! ColorDark()
  set background=dark
  
  " color Nord
  let g:base16_00 = "#2E3440"
  let g:base16_01 = "#3f495a"
  let g:base16_02 = "#616f89"
  let g:base16_03 = "#8994a9"
  let g:base16_04 = "#D8DEE9"
  let g:base16_05 = "#E5E9F0"
  let g:base16_06 = "#ECEFF4"
  let g:base16_07 = "#8FBCBB"
  let g:base16_08 = "#BF616A"
  let g:base16_09 = "#D08770"
  let g:base16_0A = "#EBCB8B"
  let g:base16_0B = "#A3BE8C"
  let g:base16_0C = "#81A1C1"
  let g:base16_0D = "#5E81AC"
  let g:base16_0E = "#88C0D0"
  let g:base16_0F = "#B48EAD"

  call Base16_customize()
endfunction

" base 16 colors
" Color list: http://chriskempson.com/projects/base16/
function! Base16_customize() abort
lua <<EOF
  require('base16-colorscheme').setup({
      base00 = vim.g["base16_00"], 
      base01 = vim.g["base16_01"],  
      base02 = vim.g["base16_02"],  
      base03 = vim.g["base16_03"], 
      base04 = vim.g["base16_04"], 
      base05 = vim.g["base16_05"],  
      base06 = vim.g["base16_06"],  
      base07 = vim.g["base16_07"], 
      base08 = vim.g["base16_08"], 
      base09 = vim.g["base16_09"],  
      base0A = vim.g["base16_0A"],  
      base0B = vim.g["base16_0B"], 
      base0C = vim.g["base16_0C"], 
      base0D = vim.g["base16_0D"],  
      base0E = vim.g["base16_0E"],  
      base0F = vim.g["base16_0F"], 
  })
EOF

augroup CursorLine
  au!
  au VimEnter * setlocal cursorline
  au WinEnter * setlocal cursorline
  au BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Custom values
exe 'hi StatusLine guifg=' . g:base16_00 . ' guibg=' . g:base16_05
" exe 'hi WinBar guifg=' . g:base16_00 . ' guibg=' . g:base16_03
" exe 'hi WinBarNC guifg=' . g:base16_05 . ' guibg=' . g:base16_01
exe 'hi WinBar guifg=' . g:base16_05 . ' guibg=' . g:base16_00
exe 'hi WinBarNC guifg=' . g:base16_03 . ' guibg=' . g:base16_00
exe 'hi Visual guibg=' . g:base16_01
exe 'hi LineNr guifg=' . g:base16_02
exe 'hi DiagnosticVirtualTextError guifg=' . g:base16_03
exe 'hi DiagnosticVirtualTextWarn guifg=' . g:base16_03
exe 'hi DiagnosticVirtualTextInfo guifg=' . g:base16_03
exe 'hi DiagnosticVirtualTextHint guifg=' . g:base16_03
exe 'hi GitSignsAdd guifg=' . g:base16_0B
exe 'hi GitSignsChange guifg=' . g:base16_0D
exe 'hi GitSignsDelete guifg=' . g:base16_08
exe 'hi NormalFloat guifg=' . g:base16_05 . ' guibg=' . g:base16_01
exe 'hi TermCursorNC guibg=' . g:base16_00 . ' guifg=' . g:base16_05
exe 'hi TermCursor guibg=' . g:base16_05 . ' guifg=' . g:base16_00
" exe 'hi CursorLine guifg=' . g:base16_00 . ' guibg=' . g:base16_08
" exe 'hi CursorLine guifg=red guibg=blue'
exe 'hi TelescopePromptNormal guifg=red guibg=green'

exe 'hi TelescopeBorder guifg=' g:base16_03 . ' guibg=' . g:base16_00
exe 'hi TelescopePromptBorder guifg=' g:base16_03 . ' guibg=' . g:base16_00
exe 'hi TelescopeTitle guifg=' g:base16_03 . ' guibg=' . g:base16_00
exe 'hi TelescopePromptTitle guifg=' g:base16_03 . ' guibg=' . g:base16_00
exe 'hi TelescopeResultsTitle guifg=' g:base16_03 . ' guibg=' . g:base16_00
exe 'hi TelescopePreviewTitle guifg=' g:base16_03 . ' guibg=' . g:base16_00
exe 'hi TelescopeNormal  guifg=' g:base16_03 . ' guibg=' . g:base16_00
exe 'hi TelescopePromptNormal   guifg=' g:base16_03 . ' guibg=' . g:base16_00
exe 'hi TelescopeSelection guifg=' g:base16_05 . ' guibg=' . g:base16_01
exe 'hi TelescopeSelectionCaret  guifg=' g:base16_05 . ' guibg=' . g:base16_01
exe 'hi TelescopePromptPrefix    guifg=' g:base16_03 . ' guibg=' . g:base16_00
" exe 'hi TelescopePromptPrefix guifg=red guibg=blue'

hi SpellCap gui=NONE
hi SpellRare gui=NONE
hi SpellLocal gui=NONE
endfunction

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'LineNr', 'Comment'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call Base16_customize()
  autocmd VimEnter,FocusGained  * call s:changeColorsBasedOnMacos()  
augroup END

]], true )
