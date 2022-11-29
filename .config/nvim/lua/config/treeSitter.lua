require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    ignore_install = { "latex", "phpdoc" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {'markdown'}
    }
}

