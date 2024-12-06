return {
	---- CORE / LIB ----
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },

	---- TOOLS ----
	{ "mbbill/undotree" },
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup()
		end,
	},

	-- MOVEMENT --
	{
		"ggandor/leap.nvim",
		config = function()
			local leap = require("leap")
			leap.add_default_mappings()
			-- leap.opts.special_keys.next_group = "<BS>"
		end,
	},

	-- TELESCOPE --
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
	},
	{
		"ThePrimeagen/harpoon",
		-- dependencies = { 'hvim-lua/plenary.nvim' },
	},
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- ETC --
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				plugins = {
					tmux = { enabled = true },
				},
			})
		end,
	},
	{
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup()
		end,
	},
	{ "ThePrimeagen/vim-be-good" },
	{ "dstein64/vim-startuptime" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
}
