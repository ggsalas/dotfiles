require'lspinstall'.setup()

-- vim.lsp.set_log_level("debug")
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

local lsp = require 'lspconfig'

lsp.css.setup {}
lsp.graphql.setup {}
lsp.html.setup {}
lsp.json.setup {}
lsp.yaml.setup {}
lsp.bash.setup {}
lsp.vim.setup {}

-- Typescript setup
-------------------
lsp.tsserver.setup({
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false

        require("nvim-lsp-ts-utils").setup {
            debug = true,
            disable_commands = true,
            update_imports_on_move = true,
            require_confirmation_on_move = true
        }

    end
})

-- Lua setup
------------
lsp.lua.setup {settings = {Lua = {diagnostics = {globals = {'vim'}}}}}

-- Efm setup (linter)
---------------------
-- ts
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

-- lua
local luaFormat = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --column-limit=120",
    formatStdin = true
}

local lua_arguments = {}
table.insert(lua_arguments, luaFormat)

-- sh
local shfmt = {formatCommand = 'shfmt -ci -s -bn', formatStdin = true}

local sh_arguments = {}
table.insert(sh_arguments, shfmt)

lsp.efm.setup {
    cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {
        "lua", "javascriptreact", "javascript", "typescript", "typescriptreact", "sh", "html", "css", "scss", "json",
        "yaml", "markdown", "vue"
    },
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
            lua = lua_arguments,
            sh = sh_arguments
            -- markdown = {markdownPandocFormat}
        }
    }
    -- Using augroup on plug_lsp.vim because this stop work if open many buffers
    -- on_attach = function(client)
    --   if client.resolved_capabilities.document_formatting then
    --     vim.cmd [[augroup Format]]
    --     vim.cmd [[autocmd!]]
    --     vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nill, 1000)]]
    --     vim.cmd [[augroup END]]
    --   end
    -- end
}

-- Lsp-status setup (status line)
---------------------------------
local lsp_status = require('lsp-status')

lsp_status.config {
    select_symbol = function(cursor_pos, symbol)
        if symbol.valueRange then
            local value_range = {
                ["start"] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[1])},
                ["end"] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[2])}
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
    status_symbol = ' '
})
