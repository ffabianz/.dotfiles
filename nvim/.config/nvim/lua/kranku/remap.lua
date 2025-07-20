vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end, { desc = "format" })
