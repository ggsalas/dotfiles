return {
  "RRethy/nvim-base16",
  dependencies = "brenoprata10/nvim-highlight-colors",
  config = function()
    -- This config creates light and dark themes and apply based on system darkMode
    -- Also apply tweaks to have a minimalistic design

    -- Set colorscheme
    vim.o.termguicolors = true

    -- Visual options
    vim.o.cursorline = true

    local function colorLight()
      vim.g.background = 'light'

      -- solarized light
      require('base16-colorscheme').setup({
        base00 = '#fdf6e3',
        base01 = '#eee8d5',
        base02 = '#93a1a1',
        base03 = '#839496',
        base04 = '#657b83',
        base05 = '#586e75',
        base06 = '#073642',
        base07 = '#002b36',
        base08 = '#dc322f',
        base09 = '#cb4b16',
        base0A = '#b58900',
        base0B = '#859900',
        base0C = '#2aa198',
        base0D = '#268bd2',
        base0E = '#6c71c4',
        base0F = '#d33682'
      })
    end

    local function colorDark()
      vim.g.background = 'dark'

      -- color Nord
      require('base16-colorscheme').setup({
        base00 = "#2E3440",
        base01 = "#3f495a",
        base02 = "#616f89",
        base03 = "#8994a9",
        base04 = "#D8DEE9",
        base05 = "#E5E9F0",
        base06 = "#ECEFF4",
        base07 = "#8FBCBB",
        base08 = "#BF616A",
        base09 = "#D08770",
        base0A = "#EBCB8B",
        base0B = "#A3BE8C",
        base0C = "#81A1C1",
        base0D = "#5E81AC",
        base0E = "#88C0D0",
        base0F = "#c47eb7"
      })
    end

    local function tweaks()
      local colors = require('base16-colorscheme').colors

      -- Minimalistic global design
      vim.api.nvim_set_hl(0, 'StatusLine', { fg = colors.base00, bg = colors.base05 })
      vim.api.nvim_set_hl(0, 'WinBar', { fg = colors.base05, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'WinBarNC', { fg = colors.base03, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'Visual', { bg = colors.base01 })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.base02, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.base05, bg = colors.base01 })

      -- All virtual text in grey
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = colors.base03 })
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = colors.base03 })
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = colors.base03 })
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = colors.base03 })

      -- Minimalistic Telescope
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = colors.base03, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = colors.base03, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'TelescopeTitle', { fg = colors.base03, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = colors.base03, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = colors.base03, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = colors.base03, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = colors.base03, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = colors.base03, bg = colors.base00 })
      vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = colors.base05, bg = colors.base01 })
      vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = colors.base05, bg = colors.base01 })
      vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = colors.base03, bg = colors.base00 })

      -- leap plugin
      vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = colors.base00, bg = colors.base0B})
      vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = colors.base00, bg = colors.base0B})
      vim.api.nvim_set_hl(0, 'LeapMatch', { fg = colors.base00, bg = colors.base0B})

      -- Only show spell errors
      vim.api.nvim_set_hl(0, 'SpellCap', { underline = false, undercurl = false, underdotted = false })
      vim.api.nvim_set_hl(0, 'SpellRare', { underline = false, undercurl = false, underdotted = false })
      vim.api.nvim_set_hl(0, 'SpellLocal', { underline = false, undercurl = false, underdotted = false })
    end

    function ChangeColorsBasedOnMacos()
      -- Return true if dark mode is activated on macos
      local function isDarkMode()
        local status_file = io.popen("dark-mode status", "r")

        if status_file then
          local result = status_file:read "*line"
          status_file:close()

          return result:match("on") ~= nil
        end
      end

      if isDarkMode() then
        colorDark()
      else
        colorLight()
      end

      tweaks()
    end

    vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained' }, {
      group = vim.api.nvim_create_augroup('apply-colorschema', { clear = true }),
      callback = ChangeColorsBasedOnMacos
    })
  end
}
