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

-- marking mode
vim.api.nvim_create_user_command("MarkingMode", function()
	vim.b.autoformat = false
	vim.opt.colorcolumn = "80"
end, {})
