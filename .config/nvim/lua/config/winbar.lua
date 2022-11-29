local M = {}

--[[ vim.api.nvim_set_hl(0, 'WinBarPath', { bg = vim.g["base16_01"], fg = vim.g["base16_05"] }) ]]

local winbar_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
}

function M.eval()

    if vim.bo.buftype == 'terminal' then
      return ""
    end

    if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
        return ""
    end

    local file_path = vim.api.nvim_eval_statusline('%f', {}).str
    local modified = vim.api.nvim_eval_statusline('%M', {}).str == '+' and ' [+] ' or ' '

    --[[ return '%#WinBar#' ]]
    --[[  .. file_path ]]
    --[[  .. modified ]]
    --[[  .. '%*' ]]
    return file_path
     .. modified
end

return M
