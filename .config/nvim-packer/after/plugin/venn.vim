function! DrawStart() 
  set virtualedit=all
  set cursorcolumn
endfunction

function! DrawStop() 
  set virtualedit=""
  set nocursorcolumn
endfunction

command -bang DrawStart call DrawStart()<bang>
command -bang DrawStop call DrawStop()<bang>
vmap . :VBox<cr>

