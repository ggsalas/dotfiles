require('spectre').setup{
  default = {
    mapping={
      ['toggle_no_ignore'] = {
        map = "tg",
        cmd = "<cmd>lua require('spectre').change_options('no-ignore')<CR>",
        desc = "toggle no-ignore git files"
      },
    },
    find_engine = {
      ['rg'] = {
        cmd = "rg",
        options = {
          ['no-ignore'] = {
            value="--no-ignore",
            icon="[G]",
            desc="no git ignore"
          },
        }
      },
    }
  }
}
