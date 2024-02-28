return {
  -- Automatically install LSPs to stdpath for neovim
  ---------------------------------------------------
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },

  -- Handle native neovim LSP
  ---------------------------
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        -- Keymaps here will work only after LSP connects
        -- sets the mode, buffer and description for each keymap
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
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')
      end

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_create_user_command('Format',
        vim.lsp.buf.format,
        { desc = 'Format current buffer with LSP' }
      )

      vim.keymap.set('n', '<leader>,', vim.lsp.buf.format)

      -- Setup mason so it can manage external tooling
      require('mason').setup()

      -- nvim-cmp supports additional completion capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require("mason-lspconfig").setup({
        ensure_installed = {
          'clangd',
          'rust_analyzer',
          'pyright',
          'tsserver',
          'lua_ls',
          'gopls',
          'phpactor',
          'tailwindcss',
          'cssls',
          'cssmodules_ls',
        },
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
              on_attach = on_attach,
              capabilities = capabilities
            }
          end,

          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  workspace = {
                    checkThirdParty = false,
                    -- Tells lua_ls where to find all the Lua files that you have loaded
                    -- for your neovim configuration.
                    library = {
                      '${3rd}/luv/library',
                      unpack(vim.api.nvim_get_runtime_file('', true)),
                    },
                    -- If lua_ls is really slow on your computer, you can try this instead:
                    -- library = { vim.env.VIMRUNTIME },
                  },
                  -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                  -- diagnostics = { disable = { 'missing-fields' } },
                },
                -- Lua = {
                --   diagnostics = {
                --     globals = { "vim", "it", "describe", "before_each", "after_each" },
                --   }
                -- }
              }
            }
          end,

          ["tsserver"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.tsserver.setup {
              go_to_source_definition = {
                fallback = true, -- fall back to standard LSP definition on failure
              },
              server = {         -- pass options to lspconfig's setup method
                on_attach = function(client)
                  client.server_capabilities.documentFormattingProvider = false
                end,
              },
            }
          end
        }
      })
    end,
  },

  -- Support for extra Typescript LSP methods
  -------------------------------------------
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- none-ls (fork of null_ls)
  -- use command line tools as it was LSP server
  ----------------------------------------------
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format {
          filter = function(client)
            return client.name == 'null-ls'
          end,
          bufnr = bufnr,
        }
      end

      local null_ls = require("null-ls")

      null_ls.setup({
        debug = true,
        sources = {
          -- eslint or eslint_d
          null_ls.builtins.diagnostics.eslint_d.with({
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity["HINT"] -- ERROR, WARN, INFO, HINT
            end,
          }),
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
        },
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            -- if file type is sql do nothing
            if vim.api.nvim_buf_get_option(bufnr, 'filetype') == 'sql' then
              return
            end
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }

            --[[ -- format on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                  vim.lsp.buf.format {
                    filter = function(client)
                      return client.name == 'null-ls'
                    end,
                    bufnr = bufnr,
                  }
              end,
            }) ]]
          end
        end,
      })
    end
  },

  -- CMP
  ------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-git',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-Space>'] = cmp.mapping.complete(),
          -- ['<CR>'] = cmp.mapping.confirm {
          --   behavior = cmp.ConfirmBehavior.Replace,
          --   select = true,
          -- },
          ['<CR>'] = cmp.mapping.confirm(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's', 'c' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's', 'c' }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' }
        }),
      }

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = {
          { name = 'cmp_git' },
          { name = 'buffer' },
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline {
          ['<down>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'c' }),
          ['<up>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'c' }),
        },
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
          },
          completeopt = "menuone,noinsert,noselect",
          keyword_length = 0,
        },
        mapping = cmp.mapping.preset.cmdline {
          ['<Down>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'c' }),
          ['<C-j>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'c' }),
          ['<Up>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'c' }),
          ['<C-k>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'c' }),
        },
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  }

}
