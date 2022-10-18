require('telescope').setup {
  defaults = {
   mappings = {
      n = {
    	  ['<c-d>'] = require('telescope.actions').delete_buffer
      },
      i = {
        ["<C-h>"] = "which_key",
        ['<c-d>'] = require('telescope.actions').delete_buffer
      }
    },
   file_ignore_patterns = {
     "node_modules", "build", "dist", "yarn.lock"
   },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
    },
  },
}
require("telescope").load_extension('harpoon')
require("telescope").load_extension "file_browser"
require("telescope").load_extension("session-lens")
require('telescope').load_extension('neoclip')

require('neogit').setup {
  integrations = {
    diffview = true
  },
}

require('zen-mode').setup {
  plugins = {
    tmux = { enabled = false }
  }
}

-- Code Intelligence --

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "typescript", "python" },

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
}

