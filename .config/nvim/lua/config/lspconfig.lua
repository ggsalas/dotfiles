local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local lsp_installer = require("nvim-lsp-installer")

--[[ [LSP] Accessing client.resolved_capabilities is deprecated, update your plugins or configuration to access client.server_capabilities instead.The new key/value pairs in server_capabilities directly m ]]
--[[ atch those defined in the language server protocol ]]

-- vim.lsp.set_log_level("debug")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

-- lspconfig.json.setup{}
-- lspconfig.yaml.setup{}
-- lspconfig.vimls.setup{}
-- lspconfig.graphql.setup{}
-- lspconfig.bashls.setup{}
lspconfig.tailwindcss.setup{}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}
require'lspconfig'.cssmodules_ls.setup{}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- require'lspinstall'.setup()
-- local servers = require'lspinstall'.installed_servers()
-- for _, server in pairs(servers) do
--   require'lspconfig'[server].setup{}
-- end

-- Linter null-ls
-----------------
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.eslint, -- eslint or eslint_d
    null_ls.builtins.code_actions.eslint, -- eslint or eslint_d
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type Spaces" } }),
  },
  on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  vim.lsp.buf.formatting_sync()
              end,
          })
      end
  end,
})

-- Typescript setup
-------------------
lspconfig.tsserver.setup({
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false

    require("nvim-lsp-ts-utils").setup({
      debug = true,
      disable_commands = false,
      update_imports_on_move = true,
      require_confirmation_on_move = true,
      always_organize_imports = false,
    })
  end,
})

-- Lsp-status setup (status line)
---------------------------------
local lsp_status = require("lsp-status")

lsp_status.config({
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = { character = 0, line = vim.fn.byte2line(symbol.valueRange[1]) },
        ["end"] = { character = 0, line = vim.fn.byte2line(symbol.valueRange[2]) },
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end,
})

lsp_status.config({
  indicator_errors = "✖",
  indicator_warnings = "",
  indicator_info = "ℹ",
  indicator_hint = "",
  indicator_ok = " ",
  status_symbol = " ",
})


local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "✖" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "ℹ" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = true,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
