local f = require("main.function")

-- open all folds
vim.api.nvim_create_autocmd(
    "BufRead",
    { pattern = "*", command = "silent! :%foldopen!" }
)
-- enable spell checker
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)
-- enable inlay hints
-- vim.api.nvim_create_autocmd(
--     {"BufEnter", "BufWinEnter", "TabEnter"},
--     { pattern = { "*.rs" }, callback = f.toggle_inlay_hint }
-- )
