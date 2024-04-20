-- inspirted by config from https://github.com/jmbuhr/quarto-nvim-kickstarter/blob/main/lua/plugins/quarto.lua
-- with some modifications
return {

	{ -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
		-- for complete functionality (language features)
		"quarto-dev/quarto-nvim",
		ft = { "quarto" },
		dev = false,
		opts = {
			lspFeatures = {
				languages = { "r", "python", "julia", "bash", "lua", "html", "dot", "javascript", "typescript", "ojs" },
			},
			codeRunner = {
				enabled = true,
				default_method = "molten",
			},
		},
		keys = {
			{ "<leader>rc", "<cmd>QuartoActivate<cr><cmd>QuartoSend<cr>", desc = "test" },
		},
		dependencies = {
			-- for language features in code cells
			-- configured in lua/plugins/lsp.lua and
			-- added as a nvim-cmp source in lua/plugins/completion.lua
			"jmbuhr/otter.nvim",
		},
	},

	{ -- paste an image from the clipboard or drag-and-drop
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
		ft = { "markdown", "quarto", "latex" },
		opts = {
			filetypes = {
				markdown = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					drag_and_drop = {
						download_images = false,
					},
				},
				quarto = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					drag_and_drop = {
						download_images = false,
					},
				},
			},
		},
		config = function(_, opts)
			require("img-clip").setup(opts)
			vim.keymap.set("n", "<leader>ii", ":PasteImage<cr>", { desc = "insert [i]mage from clipboard" })
		end,
	},

	{ -- preview equations
		"jbyuki/nabla.nvim",
		keys = {
			{ "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "toggle [m]ath equations" },
		},
	},

	{ -- magma plugin actually does the running of python code
		"benlubas/molten-nvim",
		build = ":UpdateRemotePlugins",
		init = function()
			-- bootstrap python venv if not present, assuming python >= 3.10 is present
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
					"-U",
					"pynvim",
					"jupyter-client",
					"cairosvg",
					"pnglatex",
					"plotly",
					"kaleido",
					"pyperclip",
					"nbformat",
					"pillow",
					"jupytext", -- for jupytext.vim
				})
			end
			-- vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = false
		end,
		keys = {
			{ "<leader>mi", ":MoltenInit<cr>", desc = "[m]olten [i]nit" },
			{
				"<leader>mv",
				":<C-u>MoltenEvaluateVisual<cr>",
				mode = "v",
				desc = "molten eval visual",
			},
			{ "<leader>mr", ":MoltenReevaluateCell<cr>", desc = "molten re-eval cell" },
		},
	},

	{ -- use my fork to support quarto file type
		"hackermuffin/jupytext.vim",
		init = function()
			local venv_dir = vim.fn.stdpath("data") .. "/venv"
			vim.g.jupytext_command = venv_dir .. "/bin/jupytext"
			vim.g.jupytext_fmt = "quarto"
		end,
	},
}
