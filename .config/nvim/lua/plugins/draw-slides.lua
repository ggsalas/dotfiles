return {
  -- Simple presentation (slides) tool
  -- Evaluate more complex ones here: https://youtu.be/owx5KoiqFBs
  ----------------------------------------------------------------
  {
    "sotte/presenting.vim",
    config = function()
      vim.g.presenting_top_margin = 0
      vim.g.presenting_quit = 'q'
      vim.g.presenting_next = '<Right>'
      vim.g.presenting_prev = '<Left>'
    end
  },

  -- Nice drawings tool
  ---------------------
  {
    "jbyuki/venn.nvim",
    config = function()
      vim.api.nvim_exec([[
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
      ]], true)
    end
  },

}
