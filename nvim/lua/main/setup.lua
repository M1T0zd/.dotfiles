---- UTIL ----
require("nvim_comment").setup()
require("trouble").setup()
require("toggleterm").setup()

-- Telescope --
local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

local trouble_telescope = require("trouble.providers.telescope")

require("telescope").setup({
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
				["<c-t>"] = trouble_telescope.open_with_trouble,
			},
			i = {
				["<C-h>"] = "which_key",
				-- ['<c-x>'] = telescope_actions.delete_buffer,
				["<c-t>"] = trouble_telescope.open_with_trouble,
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
telescope.load_extension("session-lens")
telescope.load_extension("neoclip")
telescope.load_extension("ui-select")
telescope.load_extension("noice")

---- CODE INTELLIGENCE ----

-- mason --
require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
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
	}
})

-- LSP --
local lspconfig = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	require("main.keymap").set_lsp_binds(bufnr)
end

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

-- treesitter --
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

---- MISC ----
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

require("zen-mode").setup({
	plugins = {
		tmux = { enabled = true },
	},
})

local leap = require("leap")
leap.add_default_mappings()
-- leap.opts.special_keys.next_group = "<BS>"


require("ibl").setup({
	-- show_current_context = true,
	-- show_current_context_start = true,
})
