return {
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
}
