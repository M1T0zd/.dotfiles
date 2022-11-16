local M = {}

M.toggle_inlay_hint = function ()
    require'lsp_extensions'.inlay_hints{
        highlight = "Comment",
        prefix = " >> ",
        aligned = false,
        only_current_line = false,
        enabled = {  "TypeHint", "ChainingHint", "ParameterHint" }
    }
end

do -- ToggleTerm --
    local Terminal  = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        dir = "git_dir",
        direction = "float",
    })

    M._lazygit_toggle = function ()
        lazygit:toggle()
    end
end

return M
