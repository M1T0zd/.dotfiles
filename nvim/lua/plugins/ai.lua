return {
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			local home = vim.fn.expand("$HOME")
			require("chatgpt").setup({
				api_key_cmd = "gpg --decrypt " .. home .. "/Documents/openai-apikey.gpg",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	lazy = true,
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			-- replaced by copilot-cmp
	-- 			suggestion = { enabled = false },
	-- 			panel = { enabled = false },
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
}
