local keymap_lib = require('main.lib.keymap')
local bind = keymap_lib.bind
local nbind = keymap_lib.nbind
local tbind = keymap_lib.tbind

local f = require('main.function')

---- UTIL ----

nbind('<leader>z', '<cmd>qa<CR>') -- exit nvim
nbind('<leader>c', function() vim.opt.colorcolumn = next(vim.opt.colorcolumn:get()) == nil and '80' or '' end) -- toggle colorcolumn 80
nbind('<leader>b', '<cmd>Ex<CR>') -- open Netrw
nbind('<leader>u', '<cmd>UndotreeToggle<CR>')
nbind('<leader>i', function() require'zen-mode'.toggle({
  window = {
    width = .85
  }
}) end)
nbind('<leader>/', '<cmd>VimBeGood<CR>')
bind({ 'n', 'v' }, '<leader>.', ':CommentToggle<CR>') -- comment line(s)
nbind('<A-d>', '<cmd>Lspsaga open_floaterm<CR>') -- open terminal
tbind('<A-d>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]]) -- close terminal
-- nbind('<Leader>T', require'lsp_extensions'.inlay_hints)
nbind('<Leader>T', f.toggle_inlay_hint)

-- Telescope --
local telescope_builtin = require('telescope.builtin')
nbind('ff', telescope_builtin.find_files)
nbind('fg', telescope_builtin.live_grep)
nbind('fb', telescope_builtin.buffers)
nbind('f/', telescope_builtin.help_tags)
nbind('fh', '<cmd>Telescope harpoon marks<CR>')
nbind('fs', require('session-lens').search_session)
nbind('fe', '<cmd>Telescope file_browser<CR>')
nbind('fc', '<cmd>Telescope neoclip<CR>')

-- Harpoon --
local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')
local harpoon_tmux = require('harpoon.tmux')
nbind('<leader>m', harpoon_mark.add_file)
-- home row keys
nbind('<leader>j', function() harpoon_ui.nav_file(1) end)
nbind('<leader>f', function() harpoon_ui.nav_file(2) end)
nbind('<leader>k', function() harpoon_ui.nav_file(3) end)
nbind('<leader>d', function() harpoon_ui.nav_file(4) end)
nbind('<leader>l', function() harpoon_ui.nav_file(5) end)
nbind('<leader>s', function() harpoon_ui.nav_file(6) end)
nbind("<leader>'", function() harpoon_ui.nav_file(7) end)
nbind('<leader>a', function() harpoon_ui.nav_file(8) end)
-- home row keys 2
nbind('<leader>)', function() harpoon_tmux.gotoTerminal(1) end)
nbind('<leader>(', function() harpoon_tmux.gotoTerminal(2) end)
nbind('<leader>}', function() harpoon_tmux.gotoTerminal(3) end)
nbind('<leader>{', function() harpoon_tmux.gotoTerminal(4) end)
nbind('<leader>]', function() harpoon_tmux.gotoTerminal(5) end)
nbind('<leader>[', function() harpoon_tmux.gotoTerminal(6) end)
nbind('<leader>>', function() harpoon_tmux.gotoTerminal(7) end)
nbind('<leader><', function() harpoon_tmux.gotoTerminal(8) end)


---- CODE INTELLIGENCE ----

-- Diagnostics --
nbind('<space>e', vim.diagnostic.open_float)
nbind('[d', vim.diagnostic.goto_prev)
nbind(']d', vim.diagnostic.goto_next)
nbind('<space>q', vim.diagnostic.setloclist)

-- Trouble
nbind('<leader>xx', '<cmd>TroubleToggle<cr>')
nbind('<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
nbind('<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>')
nbind('<leader>xl', '<cmd>TroubleToggle loclist<cr>')
nbind('<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
nbind('gR', '<cmd>TroubleToggle lsp_references<cr>')

-- LspSaga --

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
nbind('gh', '<cmd>Lspsaga lsp_finder<CR>')

-- Code action
bind({'n','v'}, '<leader>ca', '<cmd>Lspsaga code_action<CR>')

-- Rename
nbind('gr', '<cmd>Lspsaga rename<CR>')

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
nbind('gd', '<cmd>Lspsaga peek_definition<CR>')

-- Show line diagnostics
nbind('<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>')

-- Show cursor diagnostic
nbind('<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<CR>')

-- Diagnsotic jump can use `<c-o>` to jump back
nbind('[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
nbind(']e', '<cmd>Lspsaga diagnostic_jump_next<CR>')

-- Only jump to error
nbind('[E', function()
  require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
nbind(']E', function()
  require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- Outline
nbind('<leader>o', '<cmd>LSoutlineToggle<CR>')

-- Hover Doc
nbind('K', '<cmd>Lspsaga hover_doc<CR>')


-- EXPORTS --
local M = {}

local set_lsp_binds = function(bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { buffer=bufnr }
  nbind('gD', vim.lsp.buf.declaration, bufopts)
  nbind('K', vim.lsp.buf.hover, bufopts)
  nbind('gi', vim.lsp.buf.implementation, bufopts)
  nbind('<C-k>', vim.lsp.buf.signature_help, bufopts)
  nbind('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  nbind('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  nbind('<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  nbind('<space>D', vim.lsp.buf.type_definition, bufopts)
  nbind('<space>,', function() vim.lsp.buf.format { async = true } end, bufopts)
end

M.set_lsp_binds = set_lsp_binds

return M
