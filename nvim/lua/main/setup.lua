---- UTIL ----
require('nvim_comment').setup()

-- Telescope --
require('telescope').setup {
  pickers = {
     find_files = {
        hidden = true
     }
  },
  defaults = {
   mappings = {
      n = {
    	  ['<c-d>'] = require('telescope.actions').delete_buffer
      },
      i = {
        ['<C-h>'] = 'which_key',
        ['<c-d>'] = require('telescope.actions').delete_buffer
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
require('telescope').load_extension('harpoon')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('session-lens')
require('telescope').load_extension('neoclip')


---- CODE INTELLIGENCE ----

-- LSP --
local lspconfig = require('lspconfig')

--eUse an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require('main.keymap').set_lsp_binds(bufnr)
end

local lsp_flags = {}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

lspconfig['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig['tsserver'].setup{
    _attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
lspconfig['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    -- Server-specific settings...
    settings = {
      ['rust-analyzer'] = {}
    }
}
lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
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
      select = true,
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
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
}

require'nvim-treesitter.configs'.setup {
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
saga.init_lsp_saga()


---- MISC ----

require('zen-mode').setup {
    plugins = {
        tmux = { enabled = false }
    }
}

