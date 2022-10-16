local M = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true, silent = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.bind = bind
M.nbind = bind("n")
M.vbind = bind("v")
M.xbind = bind("x")
M.ibind = bind("i")
M.tbind = bind("t")

return M

