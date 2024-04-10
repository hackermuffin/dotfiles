-- set leader key
vim.cmd('let mapleader=","')

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

-- add telescope shortcuts
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fr", builtin.resume, {})
