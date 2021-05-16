require'lspinstall'.setup()

DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

local lsp = require'lspconfig'

lsp.typescript.setup{}
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

-- tsserver/web javascript react, vue, json, html, css, yaml
local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
-- You can look for project scope Prettier and Eslint with e.g. vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to global Prettier where needed.
-- local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}

local eslint = {
    lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

local tsserver_args = {}
local auto_formatters = {}
local javascript_autoformat = {'BufWritePre', '*.js', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
local javascriptreact_autoformat = {'BufWritePre', '*.jsx', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
local typescript_autoformat = {'BufWritePre', '*.ts', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
local typescriptreact_autoformat = {'BufWritePre', '*.tsx', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}

table.insert(tsserver_args, prettier)
table.insert(tsserver_args, eslint)

-- autoformat
table.insert(auto_formatters, javascript_autoformat)
table.insert(auto_formatters, javascriptreact_autoformat)
table.insert(auto_formatters, typescript_autoformat)
table.insert(auto_formatters, typescriptreact_autoformat)

lsp.efm.setup {
   cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
   init_options = {documentFormatting = true, codeAction = true},
   filetypes = {"lua", "javascriptreact", "javascript", "typescript","typescriptreact","sh", "html", "css", "json", "yaml", "markdown", "vue"},
   settings = {
       rootMarkers = {".git/"},
       languages = {
           -- lua = lua_arguments,
           -- sh = sh_arguments,
           javascript = tsserver_args,
           javascriptreact = tsserver_args,
           typescript = tsserver_args,
           typescriptreact = tsserver_args,
           html = {prettier},
           css = {prettier},
           json = {prettier},
           yaml = {prettier},
           -- markdown = {markdownPandocFormat}
       }
   },
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
  indicator_ok = ' ',
  status_symbol= ' ',
})
