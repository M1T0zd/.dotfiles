require("lazy").setup({
	---- CORE / LIB ----
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },

	---- CODE INTELLIGENCE ----
	{
		"neovim/nvim-lspconfig",
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-l>"] = cmp.mapping.complete(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						select = false,
						behavior = cmp.ConfirmBehavior.Replace,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "copilot" },
				},
				-- window = {
				--     completion = cmp.config.window.bordered(),
				--     documentation = cmp.config.window.bordered(),
				-- },
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						symbol_map = { Copilot = "" },

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(_, vim_item)
							return vim_item
						end,
					}),
				},
			})
		end,
	}, -- Collection of configurations for built-in LSP client
	{ "L3MON4D3/LuaSnip" }, -- Snippets plugin
	{ "saadparwaiz1/cmp_luasnip" }, -- Snippets source for nvim-cmp
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
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				-- automatic_installation = true,
				ensure_installed = {
					"ts_ls",
					"eslint",
					"html",
					"cssls",
					"lua_ls"
				},
				handlers = {
					-- The first entry (without a key) will be the default handler
					-- and will be called for each installed server that doesn't have
					-- a dedicated handler.
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						})
					end,
					-- Next, you can provide a dedicated handler for specific servers.
					-- For example, a handler override for the `rust_analyzer`:
					["rust_analyzer"] = function()
						require("rust-tools").setup({})
					end,
					-- ["tsserver"] = function()
					-- 	require("lspconfig").tsserver.setup({
					-- 		capabilities = lsp_capabilities,
					-- 		settings = {
					-- 			completions = {
					-- 				completeFunctionCalls = true,
					-- 			},
					-- 		},
					-- 	})
					-- end,
				},
			})
		end,
	},
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
		-- config = function()
		-- 	require("trouble").setup()
		-- end
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
		    {
		      "<leader>xx",
		      "<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		    },
		    {
		      "<leader>xX",
		      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		      desc = "Buffer Diagnostics (Trouble)",
		    },
		    {
		      "<leader>cs",
		      "<cmd>Trouble symbols toggle focus=false<cr>",
		      desc = "Symbols (Trouble)",
			},
		    {
		      "<leader>cl",
		      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		      desc = "LSP Definitions / references / ... (Trouble)",
		    },
		    {
		      "<leader>xL",
		      "<cmd>Trouble loclist toggle<cr>",
		      desc = "Location List (Trouble)",
		    },
		    {
		      "<leader>xQ",
		      "<cmd>Trouble qflist toggle<cr>",
		      desc = "Quickfix List (Trouble)",
		    },
		}
	},
	{ "mbbill/undotree" },
	{
		'rmagatti/auto-session',
		lazy = false,
		keys = {
			-- Will use Telescope if installed or a vim.ui.select picker otherwise
			{ '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
			{ '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save session' },
			{ '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
		},


		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
			-- log_level = 'debug',
			session_lens = {
				-- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
				load_on_setup = true,
				previewer = false,
				mappings = {
					-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
					delete_session = { "i", "<C-D>" },
					alternate_session = { "i", "<C-S>" },
			        copy_session = { "i", "<C-Y>" },
				},
				-- Can also set some Telescope picker options
				-- For all options, see: https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
				theme_conf = {
					border = true,
					-- layout_config = {
					--   width = 0.8, -- Can set width and height as percent of window
					--   height = 0.5,
					-- },
				},
			},
		}
	},
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	},
	{
		"stevearc/conform.nvim",
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
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup()
		end,
	},

	-- Telescope --
	{
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
	},
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
			local dap = require("dap")
			dap.adapters.node2 = {
				type = "executable",
				command = "node",
				args = {
					os.getenv("HOME") .. "/.local/share/nvim/mason/packages/node-debug2-adapter/node-debug2-adapter",
				},
			}
			dap.configurations.typescript = {
				{
					name = "Launch",
					type = "node2",
					request = "launch",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					console = "integratedTerminal",
				},
				{
					-- For this to work you need to make sure the node process is started with the `--inspect` flag.
					name = "Attach to process",
					type = "node2",
					request = "attach",
					processId = require("dap.utils").pick_process,
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
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	-- { 'stevearc/dressing.nvim' },
	{
		"ggandor/leap.nvim",
		config = function()
			local leap = require("leap")
			leap.add_default_mappings()
			-- leap.opts.special_keys.next_group = "<BS>"
		end,
	},
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
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				-- show_current_context = true,
				-- show_current_context_start = true,
			})
		end,
	},
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
