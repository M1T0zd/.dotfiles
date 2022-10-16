require("main.packer")
require("main.set")
require("main.keymap")
require("main.theme")
require("main.lsp")
require("main.treesitter")

-- SETUP --
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
