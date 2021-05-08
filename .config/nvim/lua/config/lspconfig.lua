require'lspinstall'.setup()

local lsp = require'lspconfig'
-- local on_attach = require'completion'.on_attach

lsp.typescript.setup{}
lsp.css.setup{}
