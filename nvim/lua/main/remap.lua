local nnoremap = require("main.lib.keymap").nnoremap
local tnoremap = require("main.lib.keymap").tnoremap

-- convenience binds --
tnoremap("<Esc>", "<C-\\><C-n>") -- close terminal

-- leader binds --
nnoremap("<leader>r", ":source $MYVIMRC<CR>") -- reload nvim
nnoremap("<leader>q", ":qa<CR>") -- exit nvim
nnoremap("<leader>t", ":terminal<CR>") -- open terminal
nnoremap("<leader>b", "<cmd>Ex<CR>") -- open Netrw

-- telescope --
local builtin = require('telescope.builtin')
nnoremap('ff', builtin.find_files)
nnoremap('fg', builtin.live_grep)
nnoremap('fb', builtin.buffers)
nnoremap('f/', builtin.help_tags)
nnoremap('fh', ':Telescope harpoon marks<CR>')   
nnoremap('fs', require('session-lens').search_session)
nnoremap('fb', ':Telescope file_browser<CR>')

-- harpoon --
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
nnoremap('<leader>m', harpoon_mark.add_file)   
-- home row keys
nnoremap('<leader>j', function() harpoon_ui.nav_file(1) end)
nnoremap('<leader>f', function() harpoon_ui.nav_file(2) end)
nnoremap('<leader>k', function() harpoon_ui.nav_file(3) end)
nnoremap('<leader>d', function() harpoon_ui.nav_file(4) end)
nnoremap('<leader>l', function() harpoon_ui.nav_file(5) end)
nnoremap('<leader>s', function() harpoon_ui.nav_file(6) end)
nnoremap("<leader>'", function() harpoon_ui.nav_file(7) end)
nnoremap("<leader>a", function() harpoon_ui.nav_file(8) end)
     
