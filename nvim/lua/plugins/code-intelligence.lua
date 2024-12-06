return {
	{ "L3MON4D3/LuaSnip" }, -- Snippets plugin
	{ "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				-- keybinds for navigation in lspsaga window
				move_in_saga = {
					keys = {
						prev = "<C-k>",
						next = "<C-j>"
					}
				},
				-- use enter to open file with finder
				finder = {
					keys = {
						edit = "<CR>",
					}
				},
				-- use enter to open file with definition preview
				definition = {
					keys = {
						close = "<C-c>",
						edit = "<CR>",
					}
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{ "onsails/lspkind.nvim" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "simrat39/rust-tools.nvim" },
	{ "Saecki/crates.nvim" },
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
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
	-- {
	-- 	"VonHeikemen/lsp-zero.nvim",
	-- 	dependencies = {
	-- 		-- LSP Support
	-- 		{ "neovim/nvim-lspconfig" },
	-- 		{ "williamboman/mason.nvim" },
	-- 		{ "williamboman/mason-lspconfig.nvim" },
	--
	-- 		-- Autocompletion
	-- 		{ "hrsh7th/nvim-cmp" },
	-- 		{ "hrsh7th/cmp-buffer" },
	-- 		{ "hrsh7th/cmp-path" },
	-- 		{ "saadparwaiz1/cmp_luasnip" },
	-- 		{ "hrsh7th/cmp-nvim-lsp" },
	-- 		{ "hrsh7th/cmp-nvim-lua" },
	--
	-- 		-- Snippets
	-- 		{ "L3MON4D3/LuaSnip" },
	-- 		{ "rafamadriz/friendly-snippets" },
	-- 	},
	-- 	config = function()
	-- 		local lsp_zero = require("lsp-zero")
	-- 		lsp_zero.preset("recommended")
	-- 		lsp_zero:setup()
	-- 		lsp_zero.on_attach(function(client, bufnr)
	-- 			-- see :help lsp-zero-keybindings
	-- 			-- to learn the available actions
	-- 			lsp_zero.default_keymaps({ buffer = bufnr })
	-- 		end)
	-- 	end,
	-- },
}
