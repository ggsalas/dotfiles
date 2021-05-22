" Plug 'RRethy/nvim-base16' " Seems is not needed
Plug 'chriskempson/base16-vim'

" Functions
"""""""""""
" Simple Tabs
function NewTabLine()
  let s = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let s .= '%' . i . 'T'
    let s .= (i != 1 ? '%#TabLine#' : '')
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' '
    let  file = fnamemodify(
          \ bufname(tabpagebuflist(l:i)[tabpagewinnr(l:i) - 1]),
          \ ':t'
          \ )
    if file == ''
      let file = '[No Name]'
    endif
    let s .= file
    let s .= ' '
    let s .= (getbufvar(buflist[winnr - 1], "&mod") ? '+ ' : '')
    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return s
endfunction

" Get linter diagnostic from nvim native lsp
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

function! s:changeColorsBasedOnMacos() abort
  let hasDarkmode = system('dark-mode status')

  if (hasDarkmode=~'on')
    call ColorDark()
    call s:base16_customize()
  else 
    call ColorLight()
    call s:base16_customize()
  endif
endfunction

function! ColorLight()
  set background=light
  color base16-solarized-light
endfunction

function! ColorDark()
  set background=dark
  color base16-dracula
endfunction

" Main
""""""
set termguicolors
syntax enable

" Cursor
" In normal and visual mode use block cursor with with colors from "Cursor" highlight group
" In insert-like modes use a block with cursor with default colors
" In Replace-likes modes, use a underline cursor with default colors.
set guicursor=n-v:block-Cursor,i-ci-ve-c-ci:block,r-cr:hor20,o:hor50

" GitGutter
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_allow_clobber = 0

" base 16 colors
" Color list: http://chriskempson.com/projects/base16/
function! s:base16_customize() abort
  call Base16hi("Cursor", g:base16_gui00, g:base16_gui0F, g:base16_cterm00, g:base16_cterm05, "", "")
  call Base16hi("StatusLine", g:base16_gui00, g:base16_gui05, g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("StatusLineNC", g:base16_gui05, g:base16_gui02, g:base16_cterm01, g:base16_cterm05, "bold", "")

  call Base16hi("LineNr", g:base16_gui03, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "", "")
  call Base16hi("FoldColumn", g:base16_gui03, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "", "")
  call Base16hi("SignColumn", g:base16_gui03, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("Visual", g:base16_gui00, g:base16_gui03, g:base16_cterm00, g:base16_cterm05, "", "")

   call Base16hi("GitGutterAdd ", g:base16_gui0B, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
   call Base16hi("GitGutterChange", g:base16_gui0E, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
   call Base16hi("GitGutterDelete", g:base16_gui08, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
   call Base16hi("GitGutterChangeDelete", g:base16_gui08, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")

  call Base16hi("CocErrorHighlight", "", "transparent", g:base16_cterm00, g:base16_cterm05, "", "")
  call Base16hi("CocErrorSign", g:base16_gui08, "transparent", g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("CocWarningSign", g:base16_gui09, "transparent", g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("CocInfoSign", g:base16_gui0E, "transparent", g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("CocHintSign", g:base16_gui03, "transparent", g:base16_cterm00, g:base16_cterm05, "bold", "")

  call Base16hi("TelescopeMatching", g:base16_gui08, "transparent", g:base16_cterm00, g:base16_cterm05, "bold", "")

  call Base16hi("TabLineSel", g:base16_gui0B, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")

  call Base16hi("SpellBad", "", "", "", "", "undercurl", g:base16_gui03)
  call Base16hi("SpellCap", "", "", "", "", "none", "")
  call Base16hi("SpellRare", "", "", "", "", "none", "")
  call Base16hi("SpellLocal", "", "", "", "", "none", "")
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
  autocmd ColorScheme * call s:base16_customize()
  autocmd VimEnter,FocusGained  * call s:changeColorsBasedOnMacos()  
augroup END

" Status Line 
set statusline =\[%{gitbranch#name()}]\ %f\ %m
set statusline +=\ %*%=\ %*
set statusline +=\ %*%=\ %*%{LspStatus()}\ %*

" Tabs
set tabline=%!NewTabLine()

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
