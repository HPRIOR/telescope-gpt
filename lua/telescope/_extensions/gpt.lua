local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

local M = {}

local config = {
    title = "ChatGpt Actions",
    commands = {
        "add_tests",
        "chat",
        "docstring",
        "explain_code",
        "fix_bugs",
        "grammar_correction",
        "interactive",
        "optimize_code",
        "summarize",
        "translate"
    },
    theme = require('telescope.themes').get_dropdown {}
}


M.chat_gpt_run = function()
    local mode = vim.fn.mode()

    local in_visual_mode = mode == 'v' or mode == 'V' or mode == "\22"

    -- capture marks around visual selection
    if in_visual_mode then
        local start_pos = vim.fn.getpos("v")
        local end_pos = vim.fn.getpos(".")

        vim.fn.setpos("'<", start_pos)
        vim.fn.setpos("'>", end_pos)
    end

    pickers.new(config.theme, {
        prompt_title = config.title,
        finder = finders.new_table({
            results = config.commands,
        }),
        sorter = conf.generic_sorter(config.theme),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection[1] == "interactive" then
                    if in_visual_mode then
                        vim.cmd("'<,'>ChatGPTEditWithInstructions")
                    else
                        vim.cmd("ChatGPTEditWithInstructions")
                    end
                elseif selection[1] == "chat" then
                    vim.cmd("ChatGPT")
                else
                    if in_visual_mode then
                        vim.cmd("'<,'>ChatGPTRun " .. selection[1])
                    else
                        vim.cmd("ChatGPTRun " .. selection[1])
                    end
                end
            end)
            return true
        end,
    }):find()
end

return require("telescope").register_extension {
    setup = function(opts)
        config = vim.tbl_deep_extend("force", config, opts)
    end,
    exports = { gpt = M.chat_gpt_run },
}
