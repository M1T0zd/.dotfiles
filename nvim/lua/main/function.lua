local M = {}

M.set_inlay_hint = function ()
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

    local terminal = Terminal:new({
        hidden = true,
        direction = "float",
    })

    local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        dir = "git_dir",
        direction = "float",
    })

    local btop = Terminal:new({
        cmd = "btop",
        hidden = true,
        direction = "float"
    })

    M.terminal_toggle = function ()
        terminal:toggle()
        terminal:change_dir()
    end

    M.lazygit_toggle = function ()
        -- lazygit:send("<esc>q")
        -- lazygit:change_dir("git_dir")
        -- lazygit:send("lazygit")
        lazygit:toggle()
    end

    M.btop_toggle = function ()
        btop:toggle()
    end
end

return M
