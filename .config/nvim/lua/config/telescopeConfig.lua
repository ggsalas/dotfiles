local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local custom = require('config.telescopeCustomPickers')

-- Global remapping
-------------------
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
        disable_devicons = true, -- seems is not detected as default, added on each function
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-w>"] = actions.send_selected_to_qflist,
            ["<C-q>"] = actions.send_to_qflist,
            ["<esc>"] = actions.close
          },
          n = {
            ["<C-w>"] = actions.send_selected_to_qflist,
            ["<C-q>"] = actions.send_to_qflist,
          },
        }
    }
}

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('fzf_writer')


local M = {}

M.search_curent_dir = function()
    builtin.find_files({
        prompt_title = string.format('< Search files in %s >', vim.fn.pathshorten(vim.fn.expand('%:h'))),
        cwd = vim.fn.expand('%:p'),
        disable_devicons = true
    })
end

M.search_notes = function()
    builtin.find_files({
        prompt_title = "< Notes >",
        cwd = "$HOME/Google Drive/My Drive/Notas",
        disable_devicons = true
    })
end

M.grep_in_folder = function(dir)
    require('telescope').extensions.fzf_writer.grep({
        shorten_path = true,
        -- prompt_title = string.format('< Live Grep on %s >', dir),
        prompt_title = string.format('< Live Grep on %s >', vim.fn.pathshorten(dir)),
        cwd = dir,
        only_sort_text = true,
        disable_devicons = true
    })
end

M.grep = function()
    require('telescope').extensions.fzf_writer.grep({
        shorten_path = true,
        prompt_title = '< Live Grep >',
        only_sort_text = true,
        disable_devicons = true
    })
end

M.grep_curent_dir = function()
    local dir = vim.fn.expand('%:p:h');

    require('telescope').extensions.fzf_writer.grep({
        shorten_path = true,
        prompt_title = string.format('< Live Grep on %s >', vim.fn.pathshorten(vim.fn.expand('%:h'))),
        cwd = dir,
        only_sort_text = true,
        disable_devicons = true
    })
end

M.buffer_list = function()
    builtin.buffers {
        sort_lastused = true,
        show_all_buffers = true,
        disable_devicons = true,
        -- previewer = false,
        attach_mappings = function(prompt_bufnr, map)
            local delete_buf = function()
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                local multi_selections = current_picker:get_multi_selection()

                if next(multi_selections) == nil then
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    vim.api.nvim_buf_delete(selection.bufnr, {force = true})
                else
                    actions.close(prompt_bufnr)
                    for _, selection in ipairs(multi_selections) do
                        vim.api.nvim_buf_delete(selection.bufnr, {force = true})
                    end
                end

            end

            map('i', '<C-x>', delete_buf)
            return true
        end
    }
end

-- use delta for diff
-- TODO: get <c-d> and <c-u> work with this to scroll the preview
---------------------
local delta = previewers.new_termopen_previewer {
    get_command = function(entry)
        -- this is for status
        -- You can get the AM things in entry.status. So we are displaying file if entry.status == '??' or 'A '
        -- just do an if and return a different command
        if entry.status == '??' or 'A ' then
            return {'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value}
        end

        -- note we can't use pipes
        -- this command is for git_commits and git_bcommits
        return {'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'diff', entry.value .. '^!'}

    end
}

M.delta_git_commits = function(opts)
    opts = opts or {}
    opts.previewer = delta

    builtin.git_commits(opts)
end

M.delta_git_bcommits = function(opts)
    opts = opts or {}
    opts.previewer = delta

    builtin.git_bcommits(opts)
end

M.delta_git_status = function(opts)
    opts = opts or {}
    opts.previewer = delta

    builtin.git_status(opts)
end

-- // waiting for https://github.com/nvim-telescope/telescope.nvim/pull/613
function M.file_browser()
    local opts

    opts = {
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        prompt_position = "top",
        disable_devicons = true,
        cwd = vim.fn.expand('%:p:h'),

        attach_mappings = function(prompt_bufnr, map)
            local current_picker = action_state.get_current_picker(prompt_bufnr)

            local modify_cwd = function(new_cwd)
                current_picker.cwd = new_cwd
                current_picker:refresh(opts.new_finder(new_cwd), {reset_prompt = true})
            end

            local go_parent = function()
                modify_cwd(current_picker.cwd .. "/..")
            end

            map("n", "-", go_parent)

            map("n", "h", go_parent)

            map("i", "<c-h>", go_parent)

            map('n', 'l', actions.select_default)

            map('i', '<c-l>', actions.select_default)

            map("i", "-", function()
                modify_cwd(vim.fn.expand "~")
            end)

            return true
        end
    }

    require("telescope.builtin").file_browser(opts)
end

M.search_dot_files = function()
  custom.dot_files({})
end

return M
