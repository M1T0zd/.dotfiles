require("main.packer")
require("main.set")
require("main.remap")
require("main.theme")
require("main.lsp")
require("main.treesitter")

-- SETUP --
require('telescope').setup {
  defaults = {
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

