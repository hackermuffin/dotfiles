-- start a horizontal split terminal
vim.api.nvim_create_user_command("Hterm", function()
	vim.cmd([[
    :split
    :resize 20
    :term
    :startinsert
  ]])
end, {})

-- start a vertical split terminal
vim.api.nvim_create_user_command("Vterm", function()
	vim.cmd([[
    :vsplit
    :term
    :startinsert
  ]])
end, {})

-- start NERDTree on startup
vim.api.nvim_create_autocmd("StdinReadPre", {
	command = "let s:std_in=1",
})
vim.api.nvim_create_autocmd("VimEnter", {
	command = 'NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif',
})
