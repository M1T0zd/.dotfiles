	return {
		"nvim-telescope/telescope.nvim",
		config = function()
			-- local telescope_actions = require("telescope.actions")
			local trouble_telescope = require("trouble.sources.telescope")
			local telescope = require("telescope")

			telescope.setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				defaults = {
					mappings = {
						n = {
							["<c-s>"] = function()
								require("telescope.builtin").find_files({ hidden = true })
							end,
							-- ['<c-x>'] = telescope_actions.delete_buffer,
							["<c-t>"] = trouble_telescope.open,
						},
						i = {
							["<C-h>"] = "which_key",
							-- ['<c-x>'] = telescope_actions.delete_buffer,
							["<c-t>"] = trouble_telescope.open,
						},
					},
					file_ignore_patterns = {
						"node_modules",
						"build",
						"dist",
						"yarn.lock",
					},
				},
				extensions = {
					file_browser = {
						hijack_netrw = true,
					},
				},
			})
			telescope.load_extension("harpoon")
			telescope.load_extension("file_browser")
			telescope.load_extension("neoclip")
			telescope.load_extension("ui-select")
			telescope.load_extension("noice")
		end,
	}
