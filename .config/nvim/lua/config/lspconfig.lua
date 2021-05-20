require'lspinstall'.setup()

vim.lsp.set_log_level("debug")

DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

local lsp = require'lspconfig'

-- For some reason fails randomly. Added an augroup into plug_lsp.vim
-- local on_attach = function(client)
--   if client.resolved_capabilities.document_formatting then
--     vim.cmd [[augroup lsp_formatting]]
--     vim.cmd [[autocmd!]]
--     vim.cmd [[au BufWritePre * <cmd>lua vim.lsp.buf.formatting_sync(nil, 1000)]]
--     vim.cmd [[augroup END]]
--   end
-- end

lsp.tsserver.setup({
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false

    on_attach(client)
  end,
})
lsp.css.setup{}
lsp.graphql.setup{}
lsp.html.setup{}
lsp.json.setup{}
lsp.yaml.setup{}
lsp.bash.setup{}
lsp.vim.setup{}
lsp.lua.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- efm setup
------------

-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
-- local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}
local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    formatCommand = "eslint_d -f unix --fix-to-stdout --stdin --stdin-filename ${INPUT}",
    formatStdin = true
}

local tsserver_args = {}
table.insert(tsserver_args, prettier)
table.insert(tsserver_args, eslint)

lsp.efm.setup {
   cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
   init_options = {documentFormatting = true, codeAction = false},
   filetypes = {"lua", "javascriptreact", "javascript", "typescript","typescriptreact","sh", "html", "css", "scss", "json", "yaml", "markdown", "vue"},
   settings = {
       rootMarkers = {".git/"},
       languages = {
           javascript = tsserver_args,
           javascriptreact = tsserver_args,
           typescript = tsserver_args,
           typescriptreact = tsserver_args,
           html = {prettier},
           css = {prettier},
           scss = {prettier},
           json = {prettier},
           yaml = {prettier},
           -- lua = lua_arguments,
           -- sh = sh_arguments,
           -- markdown = {markdownPandocFormat}
       }
   },
   on_attach = on_attach
}

-- Plug lsp-status
------------------
local lsp_status = require('lsp-status')

lsp_status.config {
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1])
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2])
        }
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end
}

lsp_status.config({
  indicator_errors = '✖',
  indicator_warnings = '',
  indicator_info = 'ℹ',
  indicator_hint = '',
  indicator_ok = ' ',
  status_symbol= ' ',
})
