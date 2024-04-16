return {
	"meatballs/notebook.nvim",
	dependencies = {
		"meatballs/magma-nvim",
	},
	opts = function()
		local function dump(o)
			if type(o) == "table" then
				local s = "{ "
				for k, v in pairs(o) do
					if type(k) ~= "number" then
						k = '"' .. k .. '"'
					end
					s = s .. "[" .. k .. "] = " .. dump(v) .. ","
				end
				return s .. "} "
			else
				return tostring(o)
			end
		end
		-- helper functions to set ipynb cells as magma cells
		local api = require("notebook.api")
		local settings = require("notebook.settings")
		function _G.define_cell(extmark)
			if extmark == nil then
				extmark, _ = api.current_extmark()
			end
			local start_line = extmark[1] + 1
			local end_line = extmark[3].end_row
			print(start_line, end_line)
			pcall(function()
				vim.fn.MagmaDefineCell(start_line, end_line)
			end)
		end
		function _G.define_all_cells()
			local buffer = vim.api.nvim_get_current_buf()
			local extmarks = settings.extmarks[buffer]
			if extmarks ~= nil then
				for id, cell in pairs(extmarks) do
					local extmark =
						vim.api.nvim_buf_get_extmark_by_id(0, settings.plugin_namespace, id, { details = true })
					if cell.cell_type == "code" then
						define_cell(extmark)
					end
				end
			end
		end

		vim.api.nvim_create_augroup("IpynbMagmaInit", { clear = true })
		vim.api.nvim_create_autocmd("BufRead", {
			pattern = "*.ipynb",
			command = "MagmaInit",
			group = "IpynbMagmaInit",
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = { "MagmaInitPost" },
			callback = _G.define_all_cells,
			group = "IpynbMagmaInit",
		})
	end,
}
