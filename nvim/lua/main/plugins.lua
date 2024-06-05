require("lazy").setup({
	---- CORE / LIB ----
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },

	---- CODE INTELLIGENCE ----
	{ "neovim/nvim-lspconfig" }, -- Collection of configurations for built-in LSP client
	{ "L3MON4D3/LuaSnip" }, -- Snippets plugin
	{ "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
	{
		'nvimdev/lspsaga.nvim',
		config = function()
			require('lspsaga').setup({})
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter', -- optional
			'nvim-tree/nvim-web-devicons',     -- optional
		},
	},
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
	{ 
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
	},
	{ "simrat39/rust-tools.nvim" },
	{ "Saecki/crates.nvim" },
	{ 
		"mfussenegger/nvim-lint",
		config = function()
			require('lint').linters_by_ft = {
				javascript = { 'eslint_d' },
				typescript = { 'eslint_d' },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()

					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").try_lint()

					-- You can call `try_lint` with a linter name or a list of names to always
					-- run specific linters, independent of the `linters_by_ft` configuration
					-- require("lint").try_lint("cspell")
				end,
			})
		end,
	},

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
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
	{
		'stevearc/conform.nvim',
		opts = {},
		config = function()
			require("conform").setup({
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				},
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- Use a sub-list to run only the first available formatter
					javascript = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
				},
			})
		end,
	},
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

	-- DEBUGGING --
	{ 
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require('dap')
			dap.adapters.node2 = {
				type = 'executable',
				command = 'node',
				args = {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/node-debug2-adapter'},
			}
			dap.configurations.typescript = {
				{
					name = 'Launch',
					type = 'node2',
					request = 'launch',
					program = '${file}',
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = 'inspector',
					console = 'integratedTerminal',
				},
				{
					-- For this to work you need to make sure the node process is started with the `--inspect` flag.
					name = 'Attach to process',
					type = 'node2',
					request = 'attach',
					processId = require'dap.utils'.pick_process,
				},
			}
		end,
			

	},
	{ 
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "node2" },
				automatic_installation = true,
			})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
	},

	-- THEME/VISUALS --
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },
	{ "navarasu/onedark.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
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
