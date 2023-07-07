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
                ['<c-d>'] = telescope_actions.delete_buffer,
                ['<c-t>'] = trouble_telescope.open_with_trouble
            },
            i = {
                ['<C-h>'] = 'which_key',
                ['<c-d>'] = telescope_actions.delete_buffer,
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


---- CODE INTELLIGENCE ----

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
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

lspconfig['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

local rt = require("rust-tools")
rt.setup({
    tools = {
        runnables = {
            use_telescope = true,
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = function(_, bufnr)
            on_attach(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
        -- flags = lsp_flags,
        -- capabilities = capabilities,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})
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

-- -- Completion Plugin Setup
-- cmp.setup({
--   -- Enable LSP snippets
--   snippet = {
--     expand = function(args)
--         vim.fn["vsnip#anonymous"](args.body)
--     end,
--   },
--   mapping = {
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     -- Add tab support
--     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--     ['<Tab>'] = cmp.mapping.select_next_item(),
--     ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Insert,
--       select = true,
--     })
--   },
--   -- Installed sources:
--   sources = {
--     { name = 'path' },                              -- file paths
--     { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
--     { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
--     { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
--     { name = 'buffer', keyword_length = 2 },        -- source current buffer
--     { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
--     { name = 'calc'},                               -- source for math calculation
--   },
--   window = {
--       completion = cmp.config.window.bordered(),
--       documentation = cmp.config.window.bordered(),
--   },
--   formatting = {
--       fields = {'menu', 'abbr', 'kind'},
--       format = function(entry, item)
--           local menu_icon ={
--               nvim_lsp = 'λ',
--               vsnip = '⋗',
--               buffer = 'Ω',
--               path = '🖫',
--           }
--           item.menu = menu_icon[entry.source.name]
--           return item
--       end,
--   },
-- })

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

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})

-- mason --
require('mason').setup()

---- MISC ----

require('zen-mode').setup {
    plugins = {
        tmux = { enabled = false }
    }
}

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}
