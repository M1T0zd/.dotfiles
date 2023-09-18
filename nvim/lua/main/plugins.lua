require("lazy").setup({
	---- CORE / LIB ----
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },

	---- CODE INTELLIGENCE ----
	{ "neovim/nvim-lspconfig" }, -- Collection of configurations for built-in LSP client
	{ "L3MON4D3/LuaSnip" }, -- Snippets plugin
	{ "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
	{ "glepnir/lspsaga.nvim" },
	{ "onsails/lspkind.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{ "simrat39/rust-tools.nvim" },
	{ "Saecki/crates.nvim" },

	-- AI --
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
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		lazy = true,
		config = function()
			require("copilot").setup({
				-- replaced by copilot-cmp
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	---- UTIL ----
	{
		"folke/trouble.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	{ "mbbill/undotree" },
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
			})
		end,
	},
	{ "terrortylor/nvim-comment" },
	{ "nvimdev/guard.nvim" },
	{ "akinsho/toggleterm.nvim", version = "*" },

	-- Telescope --
	{ "nvim-telescope/telescope.nvim" },
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
	{
		"rmagatti/session-lens",
		dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
		config = function()
			require("session-lens").setup()
		end,
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- CODE COMPLETION --
	{ "hrsh7th/nvim-cmp" },

	-- Completion sources
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-buffer" },

	-- THEME/VISUALS --
	{
		"goolord/alpha-nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	},
	{ "kyazdani42/nvim-web-devicons" },
	{ "navarasu/onedark.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
	},

	---- MISC ----
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	-- { 'stevearc/dressing.nvim' },
	{ "ggandor/leap.nvim" },
	{ "folke/zen-mode.nvim" },
	{
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup()
		end,
	},
	{ "ThePrimeagen/vim-be-good" },
	{ "dstein64/vim-startuptime" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup()
		end,
	},
	{ "junegunn/vim-easy-align" },
})
