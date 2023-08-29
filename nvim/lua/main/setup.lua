---- UTIL ----
require('nvim_comment').setup()
require('trouble').setup()
require("toggleterm").setup()

-- Telescope --
local telescope = require('telescope')
local telescope_actions = require('telescope.actions')

local trouble_telescope = require('trouble.providers.telescope')

require('telescope').setup {
    pickers = {
        find_files = {
            hidden = true
        }
    },
    defaults = {
        mappings = {
            n = {
                ['<c-s>'] = function() require "telescope.builtin".find_files({ hidden = true }) end,
                -- ['<c-x>'] = telescope_actions.delete_buffer,
                ['<c-t>'] = trouble_telescope.open_with_trouble
            },
            i = {
                ['<C-h>'] = 'which_key',
                -- ['<c-x>'] = telescope_actions.delete_buffer,
                ['<c-t>'] = trouble_telescope.open_with_trouble
            }
        },
        file_ignore_patterns = {
            'node_modules', 'build', 'dist', 'yarn.lock'
        },
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
        },
    },
}
telescope.load_extension('harpoon')
telescope.load_extension('file_browser')
telescope.load_extension('session-lens')
telescope.load_extension('neoclip')
telescope.load_extension('ui-select')


---- CODE INTELLIGENCE ----

-- mason --
require('mason').setup()
require("mason-lspconfig").setup {
    automatic_installation = true,
}
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function ()
        require("rust-tools").setup {}
    end
}

-- LSP --
local lspconfig = require('lspconfig')

--eUse an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require('main.keymap').set_lsp_binds(bufnr)
end

local lsp_flags = {}

-- Add additional capabilities supported by nvim-cmp
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- lspconfig.pyright.setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
-- }
-- lspconfig.eslint.setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
--     settings = {
--         packageManager = 'npm'
--     -- packageManager = 'yarn'
--   },
--   on_attach = function(client, bufnr)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = bufnr,
--       command = "EslintFixAll",
--     })
--   end,
-- }
-- lspconfig.tsserver.setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
-- }
-- lspconfig.volar.setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
-- }
-- lspconfig.lua_ls.setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = { 'vim' },
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = vim.api.nvim_get_runtime_file('', true),
--             },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
-- }

-- require("typescript").setup({})

-- local rt = require("rust-tools")
-- rt.setup({
--     tools = {
--         runnables = {
--             use_telescope = true,
--         },
--     },
--
--     -- all the opts to send to nvim-lspconfig
--     -- these override the defaults set by rust-tools.nvim
--     -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
--     server = {
--         -- on_attach is a callback called when the language server attachs to the buffer
--         on_attach = function(_, bufnr)
--             on_attach(_, bufnr)
--             -- Hover actions
--             vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
--             -- Code action groups
--             vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
--         end,
--         -- flags = lsp_flags,
--         -- capabilities = capabilities,
--         settings = {
--             -- to enable rust-analyzer settings visit:
--             -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
--             ["rust-analyzer"] = {
--                 -- enable clippy on save
--                 checkOnSave = {
--                     command = "clippy",
--                 },
--             },
--         },
--     },
-- })
-- rt.inlay_hints.enable()

-- Completion --
local cmp = require('cmp')

local lspkind = require('lspkind')

local luasnip = require('luasnip')

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            -- select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    -- window = {
    --     completion = cmp.config.window.bordered(),
    --     documentation = cmp.config.window.bordered(),
    -- },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(_, vim_item)
                return vim_item
            end
        })
    },
}

-- treesitter --
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or 'all'
    ensure_installed = { 'c', 'lua', 'rust', 'typescript', 'python' },

    sync_install = false,

    auto_install = true,
    indent = {
        enable = true
    },
    autotag = {
        enable = true,
    },
    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    },
}

-- LspSaga --
local saga = require('lspsaga')
saga.setup()
-- saga.init_lsp_saga()

-- null-ls --
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
          -- null_ls.builtins.diagnostics.eslint_d.with(opts.eslint_diagnostics),
          -- null_ls.builtins.formatting.eslint_d.with(opts.eslint_formatting),
          -- null_ls.builtins.formatting.prettier.with(opts.prettier_formatting),
          -- null_ls.builtins.formatting.stylua.with(opts.stylua_formatting),
          -- null_ls.builtins.formatting.elm_format.with(opts.elm_format_formatting),
          -- null_ls.builtins.code_actions.eslint_d.with(opts.eslint_diagnostics),
        },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>,", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
  
      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end
  
    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>,", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

null_ls.builtins.formatting.prettierd.with({
      condition = function(utils)
        return utils.has_file({ ".prettierrc.js" })
      end,
    })

-- prettier --
local prettier = require("prettier")

prettier.setup({
  bin = 'prettierd',
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})

---- MISC ----
require('zen-mode').setup {
    plugins = {
        tmux = { enabled = true }
    }
}

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}
