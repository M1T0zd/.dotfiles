local M = {}

do -- ToggleTerm --
	local Terminal = require("toggleterm.terminal").Terminal

	local terminal = Terminal:new({
		hidden = true,
		direction = "float",
	})

	local lazygit = Terminal:new({
		cmd = "lazygit",
		hidden = true,
		dir = "git_dir",
		direction = "float",
	})

	local btop = Terminal:new({
		cmd = "btop",
		hidden = true,
		direction = "float",
	})

	M.terminal_toggle = function()
		terminal:toggle()
		terminal:change_dir()
	end

	M.lazygit_toggle = function()
		lazygit:toggle()
	end

	M.btop_toggle = function()
		btop:toggle()
	end
end

-- function to open ChatGPTRun custom menu
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
M.chatgpt_run = function()
	opts = themes.get_dropdown({})
	pickers
		.new(opts, {
			prompt_title = "ChatGPTRun",
			finder = finders.new_table({
				results = {
					"grammar_correction",
					"translate",
					"keywords",
					"docstring",
					"add_tests",
					"optimize_code",
					"summarize",
					"fix_bugs",
					"explain_code",
					"roxygen_edit",
					"code_readability_analysis",
				},
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.cmd("ChatGPTRun " .. selection[1])
				end)
				return true
			end,
		})
		:find()
end

return M
