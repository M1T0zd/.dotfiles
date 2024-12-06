return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or 'all'
				ensure_installed = {
					"markdown",
					"markdown_inline",
					"regex",
					"bash",
					"c",
					"lua",
					"rust",
					"javascript",
					"typescript",
					"python",
				},
				sync_install = false,
				auto_install = true,
				indent = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}
