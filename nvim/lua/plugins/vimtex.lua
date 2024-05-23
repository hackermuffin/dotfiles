return {
	"lervag/vimtex",
	config = function()
		vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
		vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
		vim.g.vimtex_view_method = "zathura"

		local group = vim.api.nvim_create_augroup("texsetup", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*.tex",
			group = group,
			callback = function()
				-- Spell check latex documents
				vim.opt.spelllang = "en_au"
				vim.opt.spell = true
				-- enable wordwrap
				vim.cmd(":set wrap")
				vim.cmd(":set linebreak")
			end,
		})
	end,
}
