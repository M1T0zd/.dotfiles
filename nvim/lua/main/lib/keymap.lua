local M = {}

local function bind(op, lhs, rhs, opts)
    opts = vim.tbl_extend("force",
        { noremap = true, silent = true },
        opts or {}
    )
    vim.keymap.set(op, lhs, rhs, opts)
end

local function op_bind(op)
    return function(lhs, rhs, opts) bind(op, lhs, rhs, opts) end
end

M.bind = bind
M.nbind = op_bind("n")
M.vbind = op_bind("v")
M.xbind = op_bind("x")
M.ibind = op_bind("i")
M.tbind = op_bind("t")

return M

