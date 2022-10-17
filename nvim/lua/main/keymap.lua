local nbind = require("main.lib.keymap").nbind
local tbind = require("main.lib.keymap").tbind

-- convenience binds --
-- fix terminal binds
tbind('<esc>', [[<C-\><C-n>]])
tbind('jk', [[<C-\><C-n>]])
tbind('<C-h>', [[<Cmd>wincmd h<CR>]])
tbind('<C-j>', [[<Cmd>wincmd j<CR>]])
tbind('<C-k>', [[<Cmd>wincmd k<CR>]])
tbind('<C-l>', [[<Cmd>wincmd l<CR>]])

-- leader binds --
nbind("<leader>z", ":qa<CR>") -- exit nvim
nbind("<leader>t", ":ToggleTerm direction=float<CR>") -- open terminal
nbind("<leader>c", function() vim.opt.colorcolumn = next(vim.opt.colorcolumn:get()) == nil and "80" or "" end) -- toggle colorcolumn 80
nbind("<leader>b", "<cmd>Ex<CR>") -- open Netrw
nbind("<leader>g", function() require'neogit'.open({ kind = "replace" }) end)
nbind("<leader>o", ":SymbolsOutline<CR>")
nbind("<leader>u", ":UndotreeToggle<CR>")
nbind("<leader>i", function() require"zen-mode".toggle({
  window = {
    width = .85
  }
}) end)
nbind("<leader>/", ":VimBeGood<CR>")

-- telescope --
local telescope_builtin = require('telescope.builtin')
nbind('ff', telescope_builtin.find_files)
nbind('fg', telescope_builtin.live_grep)
nbind('fb', telescope_builtin.buffers)
nbind('f/', telescope_builtin.help_tags)
nbind('fh', ':Telescope harpoon marks<CR>')
nbind('fs', require('session-lens').search_session)
nbind('fe', ':Telescope file_browser<CR>')
nbind('fc', ':Telescope neoclip<CR>')

-- harpoon --
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
local harpoon_tmux = require("harpoon.tmux")
nbind('<leader>m', harpoon_mark.add_file)
-- home row keys
nbind('<leader>j', function() harpoon_ui.nav_file(1) end)
nbind('<leader>f', function() harpoon_ui.nav_file(2) end)
nbind('<leader>k', function() harpoon_ui.nav_file(3) end)
nbind('<leader>d', function() harpoon_ui.nav_file(4) end)
nbind('<leader>l', function() harpoon_ui.nav_file(5) end)
nbind('<leader>s', function() harpoon_ui.nav_file(6) end)
nbind("<leader>'", function() harpoon_ui.nav_file(7) end)
nbind("<leader>a", function() harpoon_ui.nav_file(8) end)
-- home row keys 2
nbind("<leader>)", function() harpoon_tmux.gotoTerminal(1) end)
nbind("<leader>(", function() harpoon_tmux.gotoTerminal(2) end)
nbind("<leader>}", function() harpoon_tmux.gotoTerminal(3) end)
nbind("<leader>{", function() harpoon_tmux.gotoTerminal(4) end)
nbind("<leader>]", function() harpoon_tmux.gotoTerminal(5) end)
nbind("<leader>[", function() harpoon_tmux.gotoTerminal(6) end)
nbind("<leader>>", function() harpoon_tmux.gotoTerminal(7) end)
nbind("<leader><", function() harpoon_tmux.gotoTerminal(8) end)
