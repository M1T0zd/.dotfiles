-- open all folds
vim.api.nvim_create_autocmd(
    "BufRead",
    { pattern = "*", command = "silent! :%foldopen!" }
)
-- enable pell checker
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)

