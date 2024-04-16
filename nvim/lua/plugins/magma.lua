return {
	"meatballs/magma-nvim",
	config = function()
		-- bootstrap python venv if not present
		local venv_dir = vim.fn.stdpath("data") .. "/venv"
		local python_bin = venv_dir .. "/bin/python"
		if vim.fn.isdirectory(venv_dir) == 0 then
			vim.fn.system({
				"python3",
				"-m",
				"venv",
				venv_dir,
				"--system-site-packages",
			})
			vim.fn.system({
				python_bin,
				"-m",
				"pip",
				"install",
				"'pynvim>=0.5'",
				"jupyter-client",
				"ueberzug",
				"pillow",
				"cairosvg",
				"pnglatex",
				"plotly",
				"kaleido",
			})
		end

		-- set python venv
		vim.cmd("let g:python3_host_prog = '" .. python_bin .. "'")

		-- set up autorun of remote plugin loading
		vim.api.nvim_create_augroup("RemotePluginLoad", { clear = true })
		vim.api.nvim_create_autocmd("VimEnter", {
			command = "UpdateRemotePlugins",
		})
	end,
}
