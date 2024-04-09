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
local group = vim.api.nvim_create_augroup("NERDTreeAutostart", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- local argc = vim.api.nvim_eval("argc()")
		local argc = vim.fn.argc()
		local argv = vim.fn.argv()
		if argc == 0 then
			-- if no args, start NERDTree focused
			vim.cmd("NERDTree")
		elseif argc == 1 and vim.fn.isdirectory(argv[1]) == 1 then
			-- if directory, cd to directory and start NERDTree focuses with empty buffer
			vim.cmd("execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0]")
		else
			vim.cmd("NERDTree | wincmd p")
		end
	end,
	group = group,
})

-- close NERDTree if last open buffer
vim.cmd([[
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]])
