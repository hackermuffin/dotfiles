return {
	"preservim/nerdtree",
	config = function()
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
		-- start NERDTree on session load
		vim.api.nvim_create_autocmd("SessionLoadPost", {
			command = "NERDTree | wincmd p",
			group = group,
		})

		-- close NERDTree if last open buffer
		group = vim.api.nvim_create_augroup("NERDTreeAutoquit", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			command = "if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif",
			group = group,
		})

		-- register find files hotkey
		vim.keymap.set("n", "<Leader>nf", "<cmd>NERDTreeFind<cr>", { desc = "Find current file in NERDTree" })
	end,
}
