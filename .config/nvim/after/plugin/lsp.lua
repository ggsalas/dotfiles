-- LSP settings.
-- Note: currently I have 2 ways to format:
--   1. On shared on_attach: is a user_command "Format"
--   2. On null_ls config: is an autocmd

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- Keymaps here will work only after LSP connects

  -- Sets the mode, buffer and description for each keymap
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('ga', vim.lsp.buf.code_action, '[G]oto [A]ction')

  nmap('[e', vim.diagnostic.goto_prev)
  nmap(']e', vim.diagnostic.goto_next)

  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end


-- Create a command `:Format` local to the LSP buffer
vim.api.nvim_create_user_command('Format', function(_)
  vim.lsp.buf.format()
end, { desc = 'Format current buffer with LSP' })

vim.keymap.set('n', '<leader>,', vim.lsp.buf.format)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable automatically the following language servers
local autoinstall_servers = {
  'clangd',
  'rust_analyzer',
  'pyright',
  'tsserver',
  -- 'sumneko_lua',
  'gopls',
  'phpactor',
  'tailwindcss',
  'cssls',
}

-- tsserver cannot be autoconfigured
-- https://github.com/jose-elias-alvarez/typescript.nvim#setup
local autoconfig_servers = {
  'clangd',
  'rust_analyzer',
  'pyright',
  -- 'sumneko_lua',
  'gopls',
  'phpactor',
  'tailwindcss',
  'cssls',
}

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
  ensure_installed = autoinstall_servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(autoconfig_servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Custom configuration for lua
--
-- Make runtime files discoverable to the server
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')

-- check neodev plugin to configure lua
-- require('lspconfig').sumneko_lua.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         globals = { 'vim' },
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file('', true),
--         checkThirdParty = false,
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = { enable = false },
--     },
--   },
-- }

-- Custom configuration for Typescript
require('typescript').setup {
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = { -- pass options to lspconfig's setup method
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
    end,
  },
}

-- null-ls for format, diagnostics and code actions on many languages
local null_ls = require 'null-ls'

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  }
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup {
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.eslint_d, -- eslint or eslint_d
    null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua.with {
      condition = function(utils)
        return utils.root_has_file { 'stylua.toml', '.stylua.toml' }
      end,
    },
    null_ls.builtins.formatting.pg_format.with({
      extra_args = { "-s", "2" },
    }),
    null_ls.builtins.code_actions.gitsigns,
    -- Note: not sure if I want this here or usr the built in commands: Typescript...
    -- require 'typescript.extensions.null-ls.code-actions',
    --   .with({
    --     extra_args = { "--keywords", "upper" }, -- change to your dialect
    -- })
    -- null_ls.builtins.diagnostics.sqlfluff.with({
    --     extra_args = { "--dialect", "postgres" }, -- change to your dialect
    -- }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method 'textDocument/formatting' then
      -- if file type is sql do nothing
      if vim.api.nvim_buf_get_option(bufnr, 'filetype') == 'sql' then
        return
      end
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      -- For now disable format on save
      -- vim.api.nvim_create_autocmd('BufWritePre', {
      --   group = augroup,
      --   buffer = bufnr,
      --   callback = function()
      --     lsp_formatting(bufnr)
      --   end,
      -- })
    end
  end,
}

-- Activate plugin for better comments
require('nvim-treesitter.configs').setup {
  context_commentstring = {
    enable = true,
  },
}
