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

return M
