return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.csharpier,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
			},
		})

		vim.keymap.set("n", "<C-A-l>", vim.lsp.buf.format, {})
	end,
}
