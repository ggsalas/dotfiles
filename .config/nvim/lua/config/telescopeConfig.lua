local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')

-- Global remapping
-------------------
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' >',
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.send_to_qflist,
                ["<esc>"] = actions.close
            }
        }
    },
    extensions = {
        fzy_native = {override_generic_sorter = false, override_file_sorter = true},
        fzf_writer = {minimum_grep_characters = 3, minimum_files_characters = 3, use_highlighter = true}
    }
}

require('telescope').load_extension('fzy_native')

local M = {}

M.search_config = function()
    require("telescope.builtin").find_files({shorten_path = true, prompt_title = "< Config >", cwd = "$HOME/.config/"})
end

M.search_notes = function()
    require("telescope.builtin").find_files({
        shorten_path = true,
        prompt_title = "< Notes >",
        cwd = "$HOME/Google Drive/My Drive/Notas"
    })
end

M.grep_in_folder = function(dir)
    require('telescope').extensions.fzf_writer.staged_grep({
        shorten_path = true,
        prompt_title = string.format('< Live Grep on %s >', dir),
        search_dirs = {dir}
    })
end

M.buffer_list = function()
    require'telescope.builtin'.buffers {
        shorten_path = true,
        sort_lastused = true,
        show_all_buffers = true,
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

return M
