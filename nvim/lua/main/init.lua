require("main.set")
require("main.remap")
require("main.packer")
require("main.theme")


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
